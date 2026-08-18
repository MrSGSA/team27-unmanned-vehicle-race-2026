CC ?= gcc
CFLAGS ?= -O2 -std=gnu99 -Wall -Wextra
LDLIBS ?= -lwiringPi -lm -lpthread
TARGET := team27_car
MODEL := for_code_JGB520_Team27
SOURCES := $(MODEL).c $(MODEL)_data.c team27_main.c $(wildcard extern_inc/*.c)

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(SOURCES)
	$(CC) $(CFLAGS) -I. -o $@ $(SOURCES) $(LDLIBS)

clean:
	rm -f $(TARGET)
