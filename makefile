COMPILER_DIR = /opt/gnatarm/bin
PATH := ${COMPILER_DIR}:${PATH}

BUILDER ?= gprbuild -p
CLEANER ?= gprclean 

all: cleanmain buildmain
	${COMPILER_DIR}/arm-eabi-objcopy -O binary obj/main obj/main.bin

cleanmain:
	${CLEANER} -P hello

buildmain:
	${BUILDER} -P hello



