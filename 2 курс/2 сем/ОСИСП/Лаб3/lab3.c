/* Написать программу подсчета количества слов в файлах заданного каталога его подкаталогов.
Пользователь задаёт имя каталога. Главный процесс открывает каталоги и запускает для каждого файла каталога
отдельный процесс подсчёта количества слов. Каждый процесс выводит на экран свой pid, полный путь к файлу,
общее число просмотренных байт и количество слов. Число одновременно работающих процессов
не должно превышать N (вводится пользователем). Проверить работу программы для каталога /etc. */
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <dirent.h>
#include <stdlib.h>
#include <string.h>
#include <libgen.h>
#include <errno.h>
#include <fcntl.h>

int counter = 0;

int walk(char module[], char dirName[], int limit)
{
	DIR *dir = opendir(dirName);
	if (!dir) {
		fprintf(stderr, "%s: %s %s\n", module, strerror(errno), dirName);
		return -1;
	}
	struct dirent *dirStruct;
	errno = 0;
	while (dirStruct = readdir(dir)) {
		if ((strcmp(dirStruct->d_name, ".") == 0 ) ||
		(strcmp(dirStruct->d_name, "..") == 0) || (dirStruct->d_type == DT_LNK)) {
			continue;
		}
		char *newDir = malloc(strlen(dirName) + strlen(dirStruct->d_name) + 2);
		sprintf(newDir, "%s/%s", dirName, dirStruct->d_name);
		if (dirStruct->d_type == DT_REG) {
			if (counter >= (limit - 1)) {
				wait(NULL);
				counter--;
			}
			counter++;
			pid_t pid;
			pid = fork();
			if (pid == 0) {
				char buff[1024];
				int bytes = 0;
				int words = 0;
				int isSpace = -1;
				int myFile = open(newDir, O_RDONLY);
				if (!myFile) {
					fprintf(stderr, "%s: %s %s\n", module, strerror(errno), newDir);
					exit(-1);
				}
				int counter = 0;
				while ((counter = read(myFile, &buff, 1024)) != 0) {
					if (counter == -1) {
						fprintf(stderr, "%s: %s %s\n", module, strerror(errno), newDir);
						exit(-1);
					}
					for (int i = 0; i < counter; i++) {
						bytes++;
						switch (buff[i]) {
							case ' ':
							case '\t':
							case '\n':
							case ',':
							case '.':
							case ';':
							case '\\':
							case '|':
							case '/':
							case '\'':
							case '"':
								isSpace = -1;
								break;
							default:
								if (isSpace == -1) {
									words++;
								}
								break;
						}
					}
				}
				if (close(myFile)) {
					fprintf(stderr, "%s: %s %s\n", module, strerror(errno), newDir);
					exit(-1);
				}
				printf("%d %s %d %d\n", getpid(), newDir, bytes, words);
				exit(0);
			}
		} else {
			if (dirStruct->d_type == DT_DIR) {
				walk(module, newDir, limit);
			}
		}
		free(newDir);
	}
	if (errno) {
		fprintf(stderr, "%s: %s %s\n", module, strerror(errno), dirName);
		return -1;
	}
	if (closedir(dir)) {
		fprintf(stderr, "%s: %s %s\n", module, strerror(errno), dirName);
		return -1;
	}
	return 0;
}

int main(int argc, char *argv[])
{
	if (argc == 3) {
		walk(basename(argv[0]), argv[1], atoi(argv[2]));
		while (counter--) {
			wait(NULL);
		}
	} else {
		fprintf(stderr, "%s: You should enter arguments like this: Folder N\n", basename(argv[0]));
		return -1;
	}
	return 0;
}
