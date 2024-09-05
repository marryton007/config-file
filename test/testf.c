#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

static const char *direction_file = "/tmp/jx/test";
static unsigned long test_counts = 0;

int write_file_str(const char *filename, const char *buf) {
  int ret;
  int fd;

  fd = open(filename, O_WRONLY | O_CREAT, S_IRWXU | S_IRGRP | S_IROTH);
  if (fd < 0) {
    printf("failed open file: %s, %d, %s\n", filename, errno, strerror(errno));
    return fd;
  }

  write(fd, buf, strlen(buf) + 1);

  close(fd);
  return 0;
}

int write_file(const char *filename, int direction) {
  int ret;
  char buf[8] = {0};

  memset(buf, 0, sizeof(buf));
  sprintf(buf, "%d", direction);

  write_file_str(direction_file, buf);

  return 0;
}

int motor_turn(int direction) {
  write_file(direction_file, direction);
  usleep(700 * 1000);

  return 0;
}

int main(int argc, char *argv[]) {
  char log_file[100] = {0};
  char buf[40] = {0};
  time_t now;
  struct tm *tm_info;

  while (1) {
    // turn left
    motor_turn(1);
    // turn right
    motor_turn(0);
    test_counts++;
    if (test_counts % 10 == 0) {
      memset(buf, 0, sizeof(buf));
      sprintf(buf, "counts: %lu\n", test_counts);
    }
  }

  return 0;
}
