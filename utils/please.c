#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main(int, char *argv[]) {
    pid_t pid = fork();
    if (pid == -1) {
        perror("fork");
        return 1;
    }

    if (pid == 0) {
        execlp("notify-send", "-u normal", "password needed", NULL);
        perror("execlp");
    } else {
        return 0;
        argv[0] = "sudo";
        execvp(argv[0], argv);
        perror("execvp");
    }

    return 0;
}
