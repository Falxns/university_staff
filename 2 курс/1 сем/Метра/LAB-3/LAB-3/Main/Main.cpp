#include<iostream>
#include<vector>
#include<string>
#include<fstream>
using namespace std;

char cur_path[] = "main.cpp";
char prev_path[] = "B.txt";

enum Status{
	P = 1,
	M = 2,
	C = 3,
	T = 4,
};

int p_count = 0;
int m_count = 0;
int c_count = 0;
int t_count = 0;

int p_io_count = 0;
int m_io_count = 0;
int c_io_count = 0;
int t_io_count = 0;


int q = 0;
int q_io = 0;

const int max_length = 256;

struct Node
{
	string operand;
	bool isIdle;
	bool isConst;
	bool isCin;
	bool isCout;
	bool isDefined;
	bool isUpdated;
	bool isRule;
	int count;
	Status state;
	Status state_io;
	Node(string temp)
	{
		count = 0;
		operand = temp;
		isIdle =	true;
		isConst =	false;
		isCin =		false;
		isCout =	false;
		isDefined = false;
		isUpdated = false;
		isRule =	false;
	}
};

vector<string> tags;

vector<Node> vars;

bool InAllowedSymbols(char );
void InitTags();
void AddTag(string tag);
bool IN(string str, string templ);
void ReverseString(string &str);

void InitTags()
{
	tags.clear();
	tags.push_back("int");
	tags.push_back("float");
	tags.push_back("char");
	tags.push_back("double");
	tags.push_back("short");
	tags.push_back("byte");
	tags.push_back("bool");
	tags.push_back("int64");
	tags.push_back("string");
}

void AddTag(string tag)
{
	for(int i = 0; i < tags.size(); i++)
		if(tags[i] == tag)
			return;
	tags.push_back(tag);
	return;
}

void ParseTags(string str)
{
	if(IN(str, "class") || IN(str, "struct"))
	{
		int i = 0;
		string temp = "";
		while(i < str.length() && str[i] != 'c' && str[i] != 's')
			i++;
		while(i < str.length() && str[i] != ' ')
			i++;
		while(i < str.length() && str[i] == ' ')
			i++;
		while(i < str.length() && str[i] != ' ')
			temp += str[i++];
		AddTag(temp);
		return;
	}
	if(IN(str, "typedef"))
	{
		int i = 0;
		string temp;
		while(i < str.length() && str[i] != ';')
			i++;
		i--;
		while(str[i] == ' ')
			i--;
		while(str[i] != ' ')
			temp += str[i--];
		ReverseString(temp);
		AddTag(temp);
		return;
	}
	return;
}

void FullTags()
{
	ifstream in(cur_path, std::ifstream::in);
	while (in.good())
	{
		string temp;
		std::getline(in, temp);
		ParseTags(temp);
	}
	in.close();
	return;
}

void ShowTags()
{
	cout << "------------------------------Tags-----------------------------" << endl;
	for(int i = 0; i < tags.size(); i++)
		cout << tags[i] << endl;
	cout << "---------------------------------------------------------------" << endl;
	return;
}


void ReverseString(string &str)
{
	for(int i = 0, j = str.length() - 1; i < str.length() / 2; i++, j--)
		swap(str[i], str[j]);
	return;
}


bool IN(string str, string templ)
{
	return str.find(templ) == -1 ? false : true;
}

bool isTag(string str, string tag)
{
	int begin = str.find(tag);
	int end = begin + str.length() - 1;
	if(begin == -1 || end + 1 == -1)
		return false;
	if((begin == 0 || !InAllowedSymbols(str[begin - 1])) && (end >= str.length() - 1 || !InAllowedSymbols(str[end])))
		return true;
	return false;
}

void ParseVars(string str)
{
	for(int i = 0; i < tags.size(); i++)
	{
		if(IN(str, tags[i]) && !IN(str, "struct") && !IN(str, "class") && !IN(str, "typedef") && str[str.length() - 1] != ')' && str[str.length() - 1] != '{' && isTag(str, tags[i]))
		{
			int k = vars.size();
			int pos = str.find(tags[i]);
			while (str[pos] != ' ')
				pos++;
			while(str[pos] == ' ' || pos == '*' || pos == '&')
				pos++;
			string temp;
			while(InAllowedSymbols(str[pos]))
				temp += str[pos++];
			vars.push_back(Node(temp));
			while(str[pos] != ';')
			{
				temp.clear();
				while(!InAllowedSymbols(str[pos]) && str[pos] != ';' && str[pos] != '=')
					pos++;
				if(str[pos] == '='){
					while (str[pos] != ',' && str[pos] != ';')
						pos++;
					vars[vars.size() - 1].isDefined = true;
					continue;
				}
				while(InAllowedSymbols(str[pos]))
					temp += str[pos++];
				vars.push_back(Node(temp));
			}
			bool is_const = IN(str, "const");
			for(int j = k; j < vars.size(); j++)
				vars[j].isConst = is_const;
			return;
		}
		if(IN(str, tags[i]) && isTag(str, tags[i]) && (str[str.length() - 1] == ')' || str[str.length() - 1] == '{'))
		{
			if(str.find(tags[i]) <  str.find("("))
				str[str.find(tags[i])] = '#';
			while (str.find(tags[i]) != -1)
			{
				int pos = str.find(tags[i]) + tags[i].length();
				str[pos - 1] = '#';
				while(!InAllowedSymbols(str[pos]))
					pos++;
				string temp;
				
				while(InAllowedSymbols(str[pos]))
					temp += str[pos++];
				Node t(temp);
				while(str[pos] != ',' && str[pos] != ')'){
					if(str[pos] == '=')
						t.isDefined = true;
					pos++;
				}
				vars.push_back(Node(t));
			}
		}
	}
}

void FullVars()
{
	ifstream in(cur_path, std::ifstream::in);
	while (in.good())
	{
		string temp;
		std::getline(in, temp);
		ParseVars(temp);
	}
	for(int i = 0; i < vars.size(); i++)
		if(vars[i].operand == "")
			vars.erase(vars.erase(vars.begin() + i, vars.begin() + i));
	in.close();
	return;

}

bool InAllowedSymbols(char symb)
{
	if((symb >= 'a' && symb <= 'z') || (symb >= 'A' && symb <= 'Z') || (symb >= '0' && symb <= '9'))
		return true;
	return false;
}

string WriteStatus(bool flag)
{
	return flag ? "YES" : "NO";
}

void ShowVars()
{
	cout << "--------------------Variables-----------------" << endl;
	for(int i = 0; i < vars.size(); i++){
		cout << "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" << endl;
		cout << vars[i].operand << endl;
		cout << "Cin     : " << WriteStatus(vars[i].isCin) << endl;
		cout << "Cout    : " << WriteStatus(vars[i].isCout) << endl;
		cout << "Defined : " << WriteStatus(vars[i].isDefined) << endl;
		cout << "Updated : " << WriteStatus(vars[i].isUpdated) << endl;
		cout << "Const   : " << WriteStatus(vars[i].isConst) << endl;
		cout << "Idle    : " << WriteStatus(vars[i].isIdle) << endl;
		cout << "Rule    : " << WriteStatus(vars[i].isRule) << endl;
		cout << "Amount  : " << vars[i].count << endl;
	}
	return;
}

bool IN_VAR(string str, string templ)
{
	int begin = str.find(templ);
	int end = begin + templ.size() - 1;
	if(begin != 0 && InAllowedSymbols(str[begin - 1]))
		return false;
	if(end != str.length() - 1 && InAllowedSymbols(str[end + 1]))
		return false;
	return true;
}

int FindVar(string str, string temp)
{
	if(!IN(str, temp))
		return -1;
	if(!IN_VAR(str, temp))
		str[str.find(temp)] = '#';
	else
		return str.find(temp);
	return FindVar(str, temp);
}

void ParseString(string str)
{
	if(IN(str, "class") || IN(str, "struct") || IN(str, "typedef"))
		return;

	for(int i = 0; i < tags.size(); i++)
		if(IN(str, tags[i]))
			return;

	bool existVar = false;
	for(int i = 0; i < vars.size(); i++)
		if(FindVar(str, vars[i].operand) != -1)
			existVar = true;
	
	if(existVar)
	{
		for(int i = 0; i < vars.size(); i++)
			if(FindVar(str, vars[i].operand) != -1)
			{
				
				int pos = FindVar(str, vars[i].operand);

				while(pos != -1){
					vars[i].count++;
					if(IN(str, "cin") && IN(str, ">>")){
						vars[i].isCin = true;
						vars[i].isIdle = false;
					}
					if(IN(str, "cout") && IN(str, "<<")){
						vars[i].isCout = true;
						vars[i].isIdle = false;
					}
					if(IN(str, "=") && pos < str.find("="))
						vars[i].isUpdated = true;
					else
						if(IN(str, "="))
							vars[i].isIdle = false;
					if(isTag(str, "while") || isTag(str, "if") || isTag(str, "switch")){
						vars[i].isRule = true;
						vars[i].isIdle = false;
					}
					if(IN(str, "for") && isTag(str, "for") && FindVar(str, vars[i].operand) < str.find('=')){
						vars[i].isRule = true;
						vars[i].isIdle = false;
					}
					str[pos] = '#';
					pos = FindVar(str, vars[i].operand);
				}
			}
	}

}

void DefineVars()
{
	for(int i = 0; i < vars.size(); i++)
	{
		Node vertex = vars[i];
		if(vertex.isCin && !vertex.isUpdated && !vertex.isRule)
		{
			vars[i].state = P;
			++p_count;
			continue;
		}
		if((vertex.isUpdated || vertex.isConst) && !vertex.isRule)
		{
			vars[i].state = M;
			++m_count;
			continue;
		}
		if(vertex.isRule)
		{
			vars[i].state = C;
			++c_count;
			continue;
		}
		vars[i].state = T;
		++t_count;
		continue;
	}
	for(int i = 0; i < vars.size(); i++)
	{
		Node vertex = vars[i];
		if(vertex.isCin || vertex.isCout)
		{
			if(vertex.isCin && !vertex.isUpdated && !vertex.isRule)
			{
				vars[i].state_io = P;
				++p_io_count;
				continue;
			}
			if((vertex.isUpdated || vertex.isConst) && !vertex.isRule)
			{
				vars[i].state_io = M;
				++m_io_count;
				continue;
			}
			if(vertex.isRule)
			{
				vars[i].state_io = C;
				++c_io_count;
				continue;
			}
			vars[i].state_io = T;
			++t_io_count;
			continue;
		}
	}
}

void CountQ()
{
	q = p_count + 2 * m_count + 3 * c_count + t_count / 2;
	q_io = p_io_count + 2 * m_io_count + 3 * c_io_count + t_io_count / 2;
}

void show()
{
	cout << "Number of different vars: " << vars.size() << endl;
	int spen = 0;
	cout << "===========================================================================" << endl;
	for(int i = 0; i < vars.size(); i++)
		spen += vars[i].count;
	cout << "Spen: " << spen << endl;
	for(int i = 0; i < vars.size(); i++){
		cout << vars[i].operand << "  :  ";
		cout << vars[i].count << endl;
	}
	cout << endl;
	cout << "===========================================================================" << endl;
	cout << "Full Chepyn metric Q: " << q << endl;

	cout << "---------------------------------------------------------------------------" << endl;
	cout << "P: ";
	for(int i = 0; i < vars.size(); i++)
		if(vars[i].state == P) 
			cout << vars[i].operand << ",  ";
	cout << endl << "Number of P metrics: " << p_count << endl;
	cout << "---------------------------------------------------------------------------" << endl;

	cout << "M: ";
	for(int i = 0; i < vars.size(); i++)
		if(vars[i].state == M) 
			cout << vars[i].operand << ",   ";
	cout << endl << "Number of M metrics: " << m_count << endl;
	cout << "---------------------------------------------------------------------------" << endl;

	cout << "C: ";
	for(int i = 0; i < vars.size(); i++)
		if(vars[i].state == C) 
			cout << vars[i].operand << ",   ";
	cout << endl << "Number of C metrics: " << c_count << endl;
	cout << "---------------------------------------------------------------------------" << endl;

	cout << "T: ";
	for(int i = 0; i < vars.size(); i++)
		if(vars[i].state == T) 
			cout << vars[i].operand << ",  ";
	cout << endl << "Number of T metrics: " << t_count << endl;
	cout << "===========================================================================" << endl;
	cout << "===========================================================================" << endl;
	cout << "IO Chepyn metric Q: " << q_io << endl;

	cout << "---------------------------------------------------------------------------" << endl;
	cout << "P: ";
	for(int i = 0; i < vars.size(); i++)
		if(vars[i].state_io == P) 
			cout << vars[i].operand << ",  ";
	cout << endl << "Number of P metrics: " << p_io_count << endl;
	cout << "---------------------------------------------------------------------------" << endl;

	cout << "M: ";
	for(int i = 0; i < vars.size(); i++)
		if(vars[i].state_io == M) 
			cout << vars[i].operand << ",   ";
	cout << endl << "Number of M metrics: " << m_io_count << endl;
	cout << "---------------------------------------------------------------------------" << endl;

	cout << "C: ";
	for(int i = 0; i < vars.size(); i++)
		if(vars[i].state_io == C) 
			cout << vars[i].operand << ",   ";
	cout << endl << "Number of C metrics: " << c_io_count << endl;
	cout << "---------------------------------------------------------------------------" << endl;

	cout << "T: ";
	for(int i = 0; i < vars.size(); i++)
		if(vars[i].state_io == T) 
			cout << vars[i].operand << ",  ";
	cout << endl << "Number of T metrics: " << t_io_count << endl;
	cout << "===========================================================================" << endl;

}

int main()
{
	InitTags();
	FullTags();
	FullVars();
	
	
	
	ifstream in(cur_path, std::ifstream::in);
	while (in.good())
	{
		string temp;
		std::getline(in, temp);
		ParseString(temp);
	}
	DefineVars();
	CountQ();
	in.close();
	system("copy a.txt b.txt");
	freopen("a.txt", "w", stdout);

	ShowTags();
	ShowVars();
	show();
	return 0;
}