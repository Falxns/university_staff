/* Подсчитать суммарный размер файлов в заданном каталоге (аргумент 1-й командной строки) и для каждого
его подкаталога отдельно. Вывести на консоль и в файл (аргумент 2-й командной строки) название подкаталога,
количество файлов в нём, суммарный размер файлов, имя файла с наибольшим размером. */
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>
#include <libgen.h>
#include <errno.h>

struct info {
	int files;
	long int size;
	int maxsize;
	char name[512];
};

struct info walk(char module[], char dirName[], FILE *myFile)
{
	struct info needed;
	needed.files = 0;
	needed.size = 0;
	needed.maxsize = 0;
	sprintf(needed.name, "%s", "");
	DIR *dir = opendir(dirName);
	if (!dir) {
		fprintf(stderr, "%s: %s %s\n", module, strerror(errno), dirName);
		return needed;
	}
	struct stat St;
	struct dirent *dirStruct;
	errno = 0;
	while (dirStruct = readdir(dir)) {
		if ((strcmp(dirStruct->d_name, ".") == 0) ||
		(strcmp(dirStruct->d_name, "..") == 0) || (dirStruct->d_type == DT_LNK)) {
			continue;
		}
		char *newDir = malloc(strlen(dirName) + strlen(dirStruct->d_name) + 2);
		sprintf(newDir, "%s/%s", dirName, dirStruct->d_name);
		if (dirStruct->d_type == DT_REG) {
			if (stat(newDir, &St) == 0) {
				needed.size += St.st_size;
				needed.files++;
				if (St.st_size > needed.maxsize) {
					needed.maxsize = St.st_size;
					sprintf(needed.name, "%s", dirStruct->d_name);
				}
			} else {
				fprintf(stderr, "%s: %s %s\n", module, strerror(errno), dirName);
			}
		} else {
			if (dirStruct->d_type == DT_DIR) {
				struct info buff;
				buff = walk(module, newDir, myFile);
				needed.files += buff.files;
				needed.size += buff.size;
				if (buff.maxsize > needed.maxsize) {
					needed.maxsize = buff.maxsize;
					sprintf(needed.name, "%s", buff.name);
				}
			}
		}
		free(newDir);
	}
	if (errno) {
		fprintf(stderr, "%s: %s %s\n", module, strerror(errno), dirName);
		return needed;
	}
	if (needed.files == 0) {
		printf("%s 0 0 No files in this folder\n", dirName);
		fprintf(myFile, "%s 0 0 No files in this folder\n", dirName);
	} else {
		printf("%s %d %ld %s\n", dirName, needed.files, needed.size, needed.name);
		fprintf(myFile, "%s %d %ld %s\n", dirName, needed.files, needed.size, needed.name);
	}
	if (closedir(dir)) {
		fprintf(stderr, "%s: %s %s\n", module, strerror(errno), dirName);
		return needed;
	}
	return needed;
}

int main(int argc, char *argv[])
{
	if (argc == 3) {
		FILE *myFile = fopen(argv[2], "w");
		if (myFile == NULL)
			fprintf(stderr, "%s: %s %s\n", basename(argv[0]), strerror(errno), argv[2]);
		else {
			walk(basename(argv[0]), argv[1], myFile);
			if (fclose(myFile) != 0)
				fprintf(stderr, "%s: %s %s\n", basename(argv[0]), strerror(errno), argv[2]);
		}
	} else {
		fprintf(stderr, "%s: You must enter arguments like this: Folder Outputfile!\n", basename(argv[0]));
	}
	return 0;
}
