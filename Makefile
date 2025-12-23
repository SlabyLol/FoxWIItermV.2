TARGET := FoxWIIterm
BUILD := build
SOURCES := source
DATA := data
INCLUDES :=

CFLAGS := -O2 -Wall
CXXFLAGS := $(CFLAGS)

LIBS := -logc -lm

include $(DEVKITPPC)/wii_rules
