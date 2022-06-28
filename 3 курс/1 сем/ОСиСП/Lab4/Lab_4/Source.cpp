#undef UNICODE
#define _CRT_SECURE_NO_WARNINGS
#include <windows.h>
#include <stdio.h>
#include <AclAPI.h>
#include <sddl.h>
#include <string>

using namespace std;

#define MAX_LINE 50
#define EXIT 0
#define CREATE_KEY 1
#define FIND_REG_KEY 2
#define READ_KEY_FLAG 3
#define NOTIFY_KEY_CHANGED 4
#define READ_REG_DWORD 5
#define WRITE_REG_DWORD 6
#define READ_REG_STRING 7
#define WRITE_REG_STRING 8

HANDLE hKeyChangedEvent;
HANDLE hKeyChangedThread;

BOOL FindKey(HKEY currentKey, LPCSTR keyName);
const char* ConvertAceStrToStr(char* source);
int ReadKeyFlags(HKEY currentKey);
LPCSTR ReadStrFromReg(HKEY key, LPCSTR subkey, LPCSTR valueName);
void WriteStrInReg(HKEY key, LPCSTR subkey, LPCSTR valueName, LPCSTR value);
void  WriteDwordInReg(HKEY key, LPCSTR subkey, LPCSTR valueName, DWORD value);
DWORD ReadDwordFromReg(HKEY key, LPCSTR subkey, LPCSTR valueName);
void CreateRegKey(HKEY key, LPCSTR subkey);
DWORD WINAPI OnKeyChanged(LPVOID lpParam);

void CreateRegKey(HKEY key, LPCSTR subkey)
{
	DWORD dwDisposition;
	HKEY  hKey;
	DWORD Ret;
	Ret =
		RegCreateKeyEx(key, subkey, 0,
			NULL, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, NULL, &hKey, &dwDisposition);
	if (Ret != ERROR_SUCCESS)
	{
		printf("Error opening (or creating new) key.\n");
	}
	else 
		printf("Success opening (or creating new) key.\n");
	RegCloseKey(hKey);
}

int ReadKeyFlags(HKEY currentKey)
{
	int isSuccess = 1;
	DWORD securityDescriptorSize;
	DWORD subkeysNumber;
	RegQueryInfoKey(currentKey, NULL, 0, NULL, &subkeysNumber,
		NULL, NULL, NULL, NULL, NULL, &securityDescriptorSize, NULL);
	char* buffer = new char[securityDescriptorSize];
	DWORD result;
	result = RegGetKeySecurity(currentKey, DACL_SECURITY_INFORMATION, buffer, &securityDescriptorSize);
	if (result != ERROR_SUCCESS)
	{
		printf("Can't get security.\n");
		isSuccess = 0;
	}
	else
	{
		SECURITY_DESCRIPTOR* security = reinterpret_cast<SECURITY_DESCRIPTOR*>(buffer);
		LPSTR strDacl;
		ConvertSecurityDescriptorToStringSecurityDescriptor(security, SDDL_REVISION_1, DACL_SECURITY_INFORMATION, &strDacl, NULL);
		printf("%s\n", strDacl);
		printf("%s\n", ConvertAceStrToStr(strDacl));
	}
	return isSuccess;
}

void NotifyKeyChanged(HKEY currentKey)
{
	hKeyChangedEvent = CreateEvent(NULL, TRUE, FALSE, "KeyChanged");
	DWORD threadId;
	hKeyChangedThread = CreateThread(NULL, 0, OnKeyChanged, NULL, 0, &threadId);
	RegNotifyChangeKeyValue(currentKey, TRUE, REG_NOTIFY_CHANGE_LAST_SET, hKeyChangedEvent, TRUE);
}

DWORD ReadDwordFromReg(HKEY key, LPCSTR subkey, LPCSTR valueName)
{
	DWORD result;
	HKEY openedKey;
	result = RegOpenKeyEx(key, subkey, 0, KEY_READ, &openedKey);
	if (result != ERROR_SUCCESS)
	{
		printf("Can't open key.\n");
		return -1;
	}
	DWORD buffer;
	DWORD len = sizeof(buffer);
	result = RegQueryValueEx(openedKey, valueName, NULL, NULL, (BYTE*)&buffer, &len);
	if (result != ERROR_SUCCESS)
	{
		printf("Can't read value.\n");
		return -1;
	}
	RegCloseKey(openedKey);
	return buffer;
}

void  WriteDwordInReg(HKEY key, LPCSTR subkey, LPCSTR valueName, DWORD value)
{
	HKEY openedKey;
	DWORD result;
	result = RegOpenKeyEx(key, subkey, 0, KEY_WRITE, &openedKey);
	if (result != ERROR_SUCCESS)
	{
		printf("Can't open key.\n");
	}
	result = RegSetValueEx(openedKey, valueName, 0, REG_DWORD, (BYTE*)&value, sizeof(DWORD));
	if (result != ERROR_SUCCESS)
	{
		printf("Can't write to registry.\n");
	}
	RegCloseKey(openedKey);
	printf("Ready!\n");
}

LPCSTR ReadStrFromReg(HKEY key, LPCSTR subkey, LPCSTR valueName)
{
	DWORD result;
	HKEY openedKey;
	result = RegOpenKeyEx(key, subkey, 0, KEY_READ, &openedKey);
	if (result != ERROR_SUCCESS)
	{
		printf("Can't open key.\n");
		return NULL;
	}
	char* buffer = new char[MAX_LINE];
	DWORD len = MAX_LINE;
	result = RegQueryValueEx(openedKey, valueName, NULL, NULL, (BYTE*)buffer, &len);
	if (result != ERROR_SUCCESS)
	{
		printf("Can't read value.\n");
		return NULL;
	}
	RegCloseKey(openedKey);
	return buffer;;
}

void WriteStrInReg(HKEY key, LPCSTR subkey, LPCSTR valueName, LPCSTR value)
{
	HKEY openedKey;
	DWORD result;
	result = RegOpenKeyEx(key, subkey, 0, KEY_WRITE, &openedKey);
	if (result != ERROR_SUCCESS)
		printf("Can't create key.\n");
	result = RegSetValueEx(openedKey, valueName, 0, REG_SZ, (BYTE*)value, strlen(value));
	if (result != ERROR_SUCCESS)
		printf("Can't write in registry.\n");
	RegCloseKey(openedKey);
	printf("Ready!\n");
}

BOOL FindKey(HKEY currentKey, LPCSTR keyName)
{
	DWORD subkeysAmount;
	DWORD maxSubkeyLen, currentSubkeyLen;
	BOOL result;
	RegQueryInfoKey(currentKey, NULL, 0, NULL, &subkeysAmount, &maxSubkeyLen,
		NULL, NULL, NULL, NULL, NULL, NULL);
	char* bufferName = new char[maxSubkeyLen];
	for (int i = 0; i < subkeysAmount; i++)
	{
		currentSubkeyLen = maxSubkeyLen;
		result = RegEnumKeyEx(currentKey, i, bufferName, &currentSubkeyLen, NULL, NULL, NULL, NULL);
		if (result == ERROR_SUCCESS)
		{
			if (!strcmp(bufferName, keyName))
			{
				return TRUE;
			}
			HKEY innerKey;
			result = RegOpenKey(currentKey, bufferName, &innerKey);
			if (result == ERROR_SUCCESS)
			{
				result = FindKey(innerKey, keyName);
				if (result)
				{
					RegCloseKey(innerKey);
					return result;
				}
			}
			RegCloseKey(innerKey);
		}
	}
	return FALSE;
}

const char* ConvertAceStrToStr(char* source)
{
	string strSource(source);
	string* strKeyAccess = new string("");
	int strLen = strSource.length();
	int i = 0;
	int semicolonCounter = 0;
	while (i < strLen)
	{
		if (source[i] == ')')
		{
			semicolonCounter = 0;
		}
		if (source[i] == ';')
		{
			semicolonCounter++;
		}
		if (semicolonCounter == 2)
		{
			int start = i + 1;
			do
			{
				i++;
			} while (source[i] != ';');
			strKeyAccess->append(strSource.substr(start, i - start));
			semicolonCounter++;
		}
		if (semicolonCounter == 5)
		{
			int start = i + 1;
			while (source[i] != ')')
			{
				i++;
			}
			strKeyAccess->append(" <-" + strSource.substr(start, i - start) + "\n");
			semicolonCounter = 0;
		}
		i++;
	}
	return strKeyAccess->c_str();
}

void CloseEvents()
{
	CloseHandle(hKeyChangedEvent);
}

DWORD WINAPI OnKeyChanged(LPVOID lpParam)
{
	WaitForSingleObject(hKeyChangedEvent, INFINITE);
	printf("Key changed.\n");
	return 0;
}

int main()
{
	string start = "0 - Close\n1 - Create key\n2 - Find key\n3 - Read key flags\n4 - Key change notify\n5 - Read dword value\n6 - Write dword value\n7 - Read string value\n8 - Write string value\n";
	
	printf("%s\n", start.c_str());
	int isContinue = 1;
	char buffer[1024];
	char secondBuffer[1024];
	DWORD dwValue;
	DWORD dwRes;
	LPCSTR strRes;
	char subkey[1024];
	while (isContinue)
	{
		int comm;
		scanf("%d", &comm);
		switch (comm)
		{
			case EXIT:
				isContinue = 0;
				CloseEvents();
				break;
			case CREATE_KEY:
				printf("Enter key name:\n");
				scanf("%s", buffer);
				CreateRegKey(HKEY_CURRENT_USER, buffer);
				break;
			case FIND_REG_KEY:
				printf("Enter key to find:\n");
				scanf("%s", buffer);
				if (FindKey(HKEY_CURRENT_USER, buffer))
					printf("Found!\n");
				else
					printf("Not found.\n");
				break;
			case READ_KEY_FLAG:
			{
				HKEY currKey;
				printf("Enter key name:\n");
				scanf("%s", buffer);
				dwRes = RegOpenKey(HKEY_CURRENT_USER, buffer, &currKey);
				if (dwRes != ERROR_SUCCESS)
					printf("Can't open key.\n");
				else
				{
					ReadKeyFlags(currKey);
					RegCloseKey(currKey);
				}
			}
				break;
			case NOTIFY_KEY_CHANGED:
			{
				printf("Enter key name:\n");
				scanf("%s", buffer);
				HKEY currKey;
				dwRes = RegOpenKey(HKEY_CURRENT_USER, buffer, &currKey);
				if (dwRes != ERROR_SUCCESS)
					printf("Can't open key.\n");
				else
					NotifyKeyChanged(currKey);
			}
				break;
			case READ_REG_DWORD:
				printf("Enter subkey name:\n");
				scanf("%s", subkey);
				printf("Enter dword name:\n");
				scanf("%s", buffer);
				dwRes = ReadDwordFromReg(HKEY_CURRENT_USER, subkey, buffer);
				if (dwRes != -1)
					printf("Value: %d\n", dwRes);
				break;
			case WRITE_REG_DWORD:
				printf("Enter subkey name:\n");
				scanf("%s", subkey);
				printf("Enter dword name:\n");
				scanf("%s", buffer);
				printf("Enter value:\n");
				scanf("%d", &dwValue);
				WriteDwordInReg(HKEY_CURRENT_USER, subkey, buffer, dwValue);
				break;
			case READ_REG_STRING:
				printf("Enter subkey name:\n");
				scanf("%s", subkey);
				printf("Enter string name:\n");
				scanf("%s", buffer);
				strRes = ReadStrFromReg(HKEY_CURRENT_USER, subkey, buffer);
				if (strRes != NULL)
					printf("Value: %s\n", strRes);
				break;
			case WRITE_REG_STRING:
				printf("Enter subkey name:\n");
				scanf("%s", subkey);
				printf("Enter string name:\n");
				scanf("%s", buffer);
				printf("Enter value:\n");
				scanf("%s", secondBuffer);
				WriteStrInReg(HKEY_CURRENT_USER, subkey, buffer, secondBuffer);
				break;
			default:
				break;
		}
	}
	return 0;
}