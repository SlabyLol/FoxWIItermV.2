# Einfaches Makefile für Wii (erstellt boot.dol)
DEVKITPRO ?= /opt/devkitpro
DEVKITPPC  ?= $(DEVKITPRO)/devkitPPC

CC       := powerpc-eabi-gcc
OBJCOPY  := powerpc-eabi-objcopy
STRIP    := powerpc-eabi-strip
ELF2DOL  := elf2dol

TARGET   := boot
SOURCES  := main.c
OBJECTS  := $(SOURCES:.c=.o)

CFLAGS   := -O2 -Wall -mno-altivec -mcpu=750 -meabi -mhard-float -fno-common \
            -I$(DEVKITPRO)/libogc/include -DHW_RVL
LDFLAGS  := -L$(DEVKITPRO)/libogc/lib -logc -lpad -lm

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
