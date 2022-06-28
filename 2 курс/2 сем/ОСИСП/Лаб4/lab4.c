#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <dirent.h>
#include <sys/stat.h>
#include <libgen.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>
#include <sys/time.h>

char *module;
int X = 0, Y = 0;
pid_t pid0 = 0, pid1 = 0, pid2 = 0, pid3 = 0, pid4 = 0, pid5 = 0, pid6 = 0, pid7 = 0, pid8 = 0;

void printErr(const char *module, const char *errmsg, const char *filename){
	fprintf(stderr, "%d %s: %s %s\n", getpid(), module, errmsg, filename ? filename : "");
}

long getTime() {
	struct timeval tv;
	if(gettimeofday(&tv, NULL) == -1) printErr(module, strerror(errno), NULL);
	return tv.tv_usec % 1000;
}

void handler1(int sig, siginfo_t *info, void *ucontext) {
	static int received = 0;
	received++;
	printf("1 %d %d получил USR2 %ld\n", getpid(), getppid(), getTime());
	fflush(stdout);

	if (received == 101){
		if (kill(-pid2, SIGTERM) == -1) printErr(module, strerror(errno), NULL);
		int children = 2;
		while (children--) wait(NULL);
		printf("1 %d %d завершил работу после %d-го сигнала SIGUSR1 и %d-го сигнала SIGUSR2\n", getpid(), getppid(), X, Y);
		fflush(stdout);
		exit(0);
	} else {
		if (kill(-pid6, SIGUSR1) == -1) printErr(module, strerror(errno), NULL);
		printf("1 %d %d послал USR1 %ld\n", getpid(), getppid(), getTime());
		fflush(stdout);
		X += 3;
	}
}

void handler2(int sig, siginfo_t *info, void *ucontext){
	printf("2 %d %d получил USR1 %ld\n", getpid(), getppid(), getTime());
	if (kill(pid1, SIGUSR2) == -1) printErr(module, strerror(errno), NULL);
	printf("2 %d %d послал USR2 %ld\n", getpid(), getppid(), getTime());
	fflush(stdout);
	Y++;
}

void handler3(int sig, siginfo_t *info, void *ucontext){
	printf("3 %d %d получил USR1 %ld\n", getpid(), getppid(), getTime());
	fflush(stdout);
}

void handler41(int sig, siginfo_t *info, void *ucontext){
	printf("4 %d %d получил USR1 %ld\n", getpid(), getppid(), getTime());
	if (kill(-pid2, SIGUSR1) == -1) printErr(module, strerror(errno), NULL);
	printf("4 %d %d послал USR1 %ld\n", getpid(), getppid(), getTime());
	fflush(stdout);
	X++;
}

void handler42(int sig, siginfo_t *info, void *ucontext){
	printf("4 %d %d получил USR2 %ld\n", getpid(), getppid(), getTime());
	if (kill(-pid2, SIGUSR1) == -1) printErr(module, strerror(errno), NULL);
	printf("4 %d %d послал USR1 %ld\n", getpid(), getppid(), getTime());
	fflush(stdout);
	X++;
}

void handler6(int sig, siginfo_t *info, void *ucontext){
	printf("6 %d %d получил USR1 %ld\n", getpid(), getppid(), getTime());
	if (kill(-pid4, SIGUSR1) == -1) printErr(module, strerror(errno), NULL);
	printf("6 %d %d послал USR1 %ld\n", getpid(), getppid(), getTime());
	fflush(stdout);
	X++;
}

void handler7(int sig, siginfo_t *info, void *ucontext){
	printf("7 %d %d получил USR1 %ld\n", getpid(), getppid(), getTime());
	if (kill(-pid4, SIGUSR2) == -1) printErr(module, strerror(errno), NULL);
	printf("7 %d %d послал USR2 %ld\n", getpid(), getppid(), getTime());
	fflush(stdout);
	Y++;
}

void handler8(int sig, siginfo_t *info, void *ucontext){
	printf("8 %d %d получил USR1 %ld\n", getpid(), getppid(), getTime());
	if (kill(-pid4, SIGUSR1) == -1) printErr(module, strerror(errno), NULL);
	printf("8 %d %d послал USR1 %ld\n", getpid(), getppid(), getTime());
	fflush(stdout);
	X++;
}

void handlerTerm2(int sig, siginfo_t *info, void *ucontext){
	if (kill(-pid4, SIGTERM) == -1) printErr(module, strerror(errno), NULL);
	if (kill(-pid5, SIGTERM) == -1) printErr(module, strerror(errno), NULL);
	int children = 2;
	while (children--) wait(NULL);
	printf("2 %d %d завершил работу после %d-го сигнала SIGUSR1 и %d-го сигнала SIGUSR2\n", getpid(), getppid(), X, Y);
	fflush(stdout);
	exit(0);
}

void handlerTerm3(int sig, siginfo_t *info, void *ucontext){
	printf("3 %d %d завершил работу после %d-го сигнала SIGUSR1 и %d-го сигнала SIGUSR2\n", getpid(), getppid(), X, Y);
	fflush(stdout);
	exit(0);
}

void handlerTerm4(int sig, siginfo_t *info, void *ucontext){
	printf("4 %d %d завершил работу после %d-го сигнала SIGUSR1 и %d-го сигнала SIGUSR2\n", getpid(), getppid(), X, Y);
	fflush(stdout);
	exit(0);
}

void handlerTerm5(int sig, siginfo_t *info, void *ucontext){
	if (kill(pid6, SIGTERM) == -1) printErr(module, strerror(errno), NULL);
	wait(NULL);
	printf("5 %d %d завершил работу после %d-го сигнала SIGUSR1 и %d-го сигнала SIGUSR2\n", getpid(), getppid(), X, Y);
	fflush(stdout);
	exit(0);
}

void handlerTerm6(int sig, siginfo_t *info, void *ucontext){
	if (kill(pid7, SIGTERM) == -1) printErr(module, strerror(errno), NULL);
	if (kill(pid8, SIGTERM) == -1) printErr(module, strerror(errno), NULL);
	int children = 2;
	while (children--) wait(NULL);
	printf("6 %d %d завершил работу после %d-го сигнала SIGUSR1 и %d-го сигнала SIGUSR2\n", getpid(), getppid(), X, Y);
	fflush(stdout);
	exit(0);
}

void handlerTerm7(int sig, siginfo_t *info, void *ucontext){
	printf("7 %d %d завершил работу после %d-го сигнала SIGUSR1 и %d-го сигнала SIGUSR2\n", getpid(), getppid(), X, Y);
	fflush(stdout);
	exit(0);
}

void handlerTerm8(int sig, siginfo_t *info, void *ucontext){
	printf("8 %d %d завершил работу после %d-го сигнала SIGUSR1 и %d-го сигнала SIGUSR2\n", getpid(), getppid(), X, Y);
	fflush(stdout);
	exit(0);
}

void createFile(char N){
	char *filename = (char *)malloc(16);
	sprintf(filename, "/tmp/lab/%c.pid", N);
	FILE *f = NULL;
	f = fopen(filename, "w");
	if (f == NULL) {
		printErr(module, strerror(errno), filename);
		return;
	}
	errno = 0;
	if(fprintf(f, "%d", getpid()) < 0) printErr(module, strerror(errno), filename);
	if(fclose(f) == EOF) printErr(module, strerror(errno), filename);
	free(filename);
}

pid_t getPidFromFile(char N){
	char *filename = (char *)malloc(16);
	if (filename == NULL) printErr(module, strerror(errno), filename);
	sprintf(filename, "/tmp/lab/%c.pid", N);
	bool red = false;
	pid_t result = 0;
	while (result == 0) {
		FILE *f = NULL;
		while ((f = fopen(filename, "r")) == NULL);
		if(fscanf(f, "%d", &result) == EOF) printErr(module, strerror(errno), filename);
		if(fclose(f) == EOF) printErr(module, strerror(errno), filename);
	}
	free(filename);
	return result;
}

int main(int argc, char *argv[], char *envp[]){
	pid0 = getpid();
	module = basename(argv[0]);
	char *dirname = "/tmp/lab";

	if (mkdir(dirname, 0777) == -1){
		printErr(module, strerror(errno), dirname);
		exit(1);
	}

	pid1 = fork();

	if (!pid1){
		pid1 = getpid();
		pid2 = fork();
		if (!pid2) pid2 = getpid();
		else if (pid2 < 0) printErr(module, strerror(errno), NULL);
	} else if (pid1 < 0) printErr(module, strerror(errno), NULL);

	if (getpid() == pid1){
		pid3 = fork();
		if (!pid3) pid3 = getpid();
		else if (pid3 < 0) printErr(module, strerror(errno), NULL);
	}

	if (getpid() == pid2){
		pid4 = fork();
		if (!pid4) pid4 = getpid();
		else if (pid4 < 0) printErr(module, strerror(errno), NULL);
	}

	if (getpid() == pid2){
		pid5 = fork();
		if (!pid5) pid5 = getpid();
		else if (pid5 < 0) printErr(module, strerror(errno), NULL);
	}

	if (getpid() == pid5){
		pid6 = fork();
		if (!pid6) pid6 = getpid();
		else if (pid6 < 0) printErr(module, strerror(errno), NULL);
	}

	if (getpid() == pid6){
		pid7 = fork();
		if (!pid7) pid7 = getpid();
		else if (pid7 < 0) printErr(module, strerror(errno), NULL);
	}

	if (getpid() == pid6){
		pid8 = fork();
		if (!pid8) pid8 = getpid();
		else if (pid8 < 0) printErr(module, strerror(errno), NULL);
	}

	struct sigaction sg;
	sigemptyset(&sg.sa_mask);
	sg.sa_flags = SA_SIGINFO;

	struct sigaction sg42;
	sigemptyset(&sg42.sa_mask);
	sg42.sa_flags = SA_SIGINFO;

	struct sigaction sgTerm;
	sigemptyset(&sgTerm.sa_mask);
	sgTerm.sa_flags = SA_SIGINFO;

	if (getpid() == pid1){
		if (setpgid(pid2, pid2) == -1){
			printErr(module, strerror(errno), NULL);
			exit(1);
		}
		if (setpgid(pid3, pid2) == -1){
			printErr(module, strerror(errno), NULL);
			exit(1);
		}

		sg.sa_sigaction = handler1;
		if (sigaction(SIGUSR2, &sg, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		pid2 = getPidFromFile('2');
		pid6 = getPidFromFile('6');
		createFile('1');

		const int required = 8;
		int curr = 0;
		while (curr != required){
			curr = 0;
			DIR *currdir;
			if (!(currdir = opendir(dirname))) {
				printErr(module, strerror(errno), dirname);
				exit(1);
			}

			struct dirent *cdirent;
			errno = 0;

			while ((cdirent = readdir(currdir))) {
				if (!strcmp(".", cdirent->d_name) || !strcmp("..", cdirent->d_name)) {
					continue;
				}
				curr++;
			}
			if (errno) printErr(module, strerror(errno), dirname);
			if (closedir(currdir) == -1) printErr(module, strerror(errno), dirname);
		}
		if (kill(-pid6, SIGUSR1) == -1) printErr(module, strerror(errno), NULL);
		printf("1 %d %d послал USR1 %ld\n", getpid(), getppid(), getTime());
		X += 3;
	}

	if (getpid() == pid2){
		if (setpgid(pid4, pid4) == -1){
			printErr(module, strerror(errno), NULL);
			exit(1);
		}
		if (setpgid(pid5, pid5) == -1){
			printErr(module, strerror(errno), NULL);
			exit(1);
		}

		sg.sa_sigaction = handler2;
		if (sigaction(SIGUSR1, &sg, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		sgTerm.sa_sigaction = handlerTerm2;
		if (sigaction(SIGTERM, &sgTerm, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		pid4 = getPidFromFile('4');
		pid5 = getPidFromFile('5');
		createFile('2');
	}

	if (getpid() == pid3){
		sg.sa_sigaction = handler3;
		if (sigaction(SIGUSR1, &sg, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		sgTerm.sa_sigaction = handlerTerm3;
		if (sigaction(SIGTERM, &sgTerm, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		createFile('3');
	}

	if (getpid() == pid4){
		sg.sa_sigaction = handler41;
		if (sigaction(SIGUSR1, &sg, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		sg42.sa_sigaction = handler42;
		if (sigaction(SIGUSR2, &sg42, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		sgTerm.sa_sigaction = handlerTerm4;
		if (sigaction(SIGTERM, &sgTerm, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		createFile('4');
	}

	if (getpid() == pid5){
		if (setpgid(pid6, pid6) == -1){
			printErr(module, strerror(errno), NULL);
			exit(1);
		}
		sgTerm.sa_sigaction = handlerTerm5;
		if (sigaction(SIGTERM, &sgTerm, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    		exit(1);
 		}
		pid6 = getPidFromFile('6');
		createFile('5');
	}

	if (getpid() == pid6){
		if (setpgid(pid7, pid6) == -1){
			printErr(module, strerror(errno), NULL);
			exit(1);
		}
		if (setpgid(pid8, pid6) == -1){
			printErr(module, strerror(errno), NULL);
			exit(1);
		}
		sg.sa_sigaction = handler6;
		if (sigaction(SIGUSR1, &sg, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		sgTerm.sa_sigaction = handlerTerm6;
		if (sigaction(SIGTERM, &sgTerm, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		pid7 = getPidFromFile('7');
		pid8 = getPidFromFile('8');
		createFile('6');
	}

	if (getpid() == pid7){
		sg.sa_sigaction = handler7;
		if (sigaction(SIGUSR1, &sg, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		sgTerm.sa_sigaction = handlerTerm7;
		if (sigaction(SIGTERM, &sgTerm, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		createFile('7');
	}

	if (getpid() == pid8){
		sg.sa_sigaction = handler8;
		if (sigaction(SIGUSR1, &sg, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		sgTerm.sa_sigaction = handlerTerm8;
		if (sigaction(SIGTERM, &sgTerm, NULL) == -1) {
			printErr(module, strerror(errno), NULL);
    			exit(1);
 		}
		createFile('8');
	}

	if (getpid() == pid0) {
		wait(NULL);
		DIR *currdir;
		if (!(currdir = opendir(dirname))) {
		    printErr(module, strerror(errno), dirname);
		    exit(1);
		}

		struct dirent *cdirent;
		errno = 0;

		while ((cdirent = readdir(currdir))) {
		    if (!strcmp(".", cdirent->d_name) || !strcmp("..", cdirent->d_name)) {
		        continue;
		    }
			char *filename = (char *)malloc(strlen(dirname) + 7);
			if(filename == NULL) printErr(module, strerror(errno), filename);
			sprintf(filename, "%s/%s", dirname, cdirent->d_name);
			if (remove(filename) == -1) printErr(module, strerror(errno), filename);
			free(filename);
		}
		if (errno) printErr(module, strerror(errno), dirname);
		if (closedir(currdir) == -1) printErr(module, strerror(errno), dirname);
		if (rmdir(dirname) == -1){
			printErr(module, strerror(errno), dirname);
			exit(1);
		}
	}
	else while(1) pause();

    exit(0);
}
