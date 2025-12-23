# Makefile for building boot.dol for Wii homebrew
DEVKITPRO ?= /opt/devkitpro

CC       := powerpc-eabi-gcc
STRIP    := powerpc-eabi-strip
ELF2DOL  := $(DEVKITPRO)/tools/bin/elf2dol

TARGET   := boot
SOURCES  := main.c
OBJECTS  := $(SOURCES:.c=.o)

CFLAGS   := -O2 -Wall -mno-altivec -mcpu=750 -meabi -mhard-float -fno-common \
            -I$(DEVKITPRO)/libogc/include -DHW_RVL
# Ensure linker searches common libogc paths; add more -L if debug shows libs elsewhere
LDFLAGS  := -L$(DEVKITPRO)/libogc/lib -L$(DEVKITPRO)/libogc/lib/wii -logc -lpad -lwiiuse -lm

all: $(TARGET).dol

$(TARGET).elf: $(OBJECTS)
	$(CC) -o $@ $^ $(LDFLAGS)
	$(STRIP) --strip-unneeded $@

$(TARGET).dol: $(TARGET).elf
	$(ELF2DOL) $< $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	-rm -f $(OBJECTS) $(TARGET).elf $(TARGET).dol

.PHONY: all clean
