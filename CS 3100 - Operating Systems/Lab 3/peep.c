#include "types.h"
#include "user.h"
#include "stat.h"

int main(int argc, char *argv[]) {

	int i, n, startingCount, endingCount;

	if(argc != 2) {
		printf(1, "Usage: peep COUNT\n");
		exit();
	}

	n = atoi(argv[1]);					// get the loop count
	startingCount = getsyscallinfo();	// get the initial syscall count
	for (i = 0;i < n-1;i++) {			// loop one less, because getsyscallinfo() is counted later
		getpid();						// call a harmless system call
	}
	endingCount = getsyscallinfo();		// get the ending syscall count (causes count++)

	if ((startingCount + n) == endingCount) {
		printf(1, "Success!\n");
	} else {
		printf(1, "Failure: starting:%d ending:%d count:%d\n",
			startingCount, endingCount, n);
	}

	exit();
}
