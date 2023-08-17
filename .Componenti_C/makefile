CC=gcc
CFLAGS=-Wall -g -std=c11	#-g serve ad attivare la compilazione per debug
A=$(wildcard *.c)
B=$(A:.c=)
all: $(B)
%: %.c
	$(CC) $(CFLAGS) $< -o $@
