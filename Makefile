TARGET := FoxWIIterm
BUILD := build
SOURCES := source

CFLAGS := -O2 -Wall
LIBS := -logc -lwiiuse

include $(DEVKITPPC)/wii_rules
