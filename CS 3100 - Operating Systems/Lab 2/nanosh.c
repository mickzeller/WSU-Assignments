/*
 CS 3100 Lab 2 - by Mick Zeller
*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <limits.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>

void cmdExit(int argc, char **argv)
{
	exit(0);
}

// getParameters returns the argc, the number of words found in cmd
//  while populating argv with pointers to each word
int getParameters(char *cmd, char **argv)
{

	char *token;
	int argc = 0;
	token = strtok(cmd, " \t\n");

	while (token != NULL) 
	{
		argv[argc] = token;
		argc++;
		token = strtok(NULL, " \t\n");
	}

	argv[argc] = NULL;    // set last + 1 argument to NULL
	return argc;
}

int main(int argc, char **argv)
{

	char cmd[1024];
	char *rc;
	int myArgc = 0;
	char *myArgv[1000];

	while (1)
	{
		printf("nanosh: ");
		fflush(stdout);
		rc = fgets(cmd, sizeof(cmd), stdin);
		if (rc == NULL) 
		{
			exit(0);
		}

		myArgc = getParameters(cmd, myArgv);

		// if no words typed: restart loop
		if (myArgc == 0)
		{
			continue;
		}
		// if the first word is "exit", terminate the program
		if (strcmp(myArgv[0], "exit") == 0)
		{
			//if any other word is included with "exit" display error
			if(myArgc > 1)
			{
				errno = EINVAL;
				perror("exit command failed");
				continue;
			}

			cmdExit(myArgc, myArgv);
			continue;
		}

		// add if statements here for the other internal commands

		if(strcmp(myArgv[0], "pwd") == 0)
		{

			if(myArgc > 1)
			{
        		errno = EINVAL;
				perror("Invalid number of arguments");
				continue;
      		}

			char path[1000];
			getcwd(path,sizeof(path));
			printf("%s\n",path);
			fflush(stdout);
			continue;
		}

		if(strcmp(myArgv[0],"cd") == 0)
		{
			if(myArgc > 2)
			{
        		errno = EINVAL;
        		perror("Invalid number of args");
				continue;
      		}

			if(myArgc == 1)
			{
				chdir(getenv("HOME"));
				continue;
			}

			int check = chdir(myArgv[1]);

			if(check != 0)
			{
				errno = ENOENT;
				perror("Invalid number of args");
			}
			continue;
		}

		//   and a default action that calls a function to fork()
		pid_t rv = fork();

		if(rv == 0)
		{
			execvp(myArgv[0],myArgv);
			perror("execvp() failed");
			exit(1);
		}

		if(rv < 0)
		{
			errno = EINVAL;
      		perror("Fork failed");
		}

		else
		{
			int *current = 0;
			waitpid(rv,current,0);
		}
	}
	return 0;
}