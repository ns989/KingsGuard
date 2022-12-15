#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdio.h>
#include <stdarg.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <errno.h>
#include <linux/fs.h>
#include <string.h>

#define DEBUG 0

int ioctl(int fd, unsigned long request, ...)
{
	if (DEBUG == 1) printf("[*] Hooked ioctl()\n");

	int (*orig_ioctl)(int fd, unsigned long request, ...);
	int orig_return;

	orig_ioctl = dlsym(RTLD_NEXT, "ioctl");

	va_list args;

	if (request == FS_IOC_SETFLAGS) {
		//printf("[*] Intercepted request to set file flags\n");
		errno = EPERM;
		return -1;
	} else {
		//printf("[*] Intercepted misc ioctl request\n");
		errno = EPERM;
		return -1;
	}

}