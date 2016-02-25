BUILDER ?= gprbuild -p
all: cleanmain buildmain
	arm-eabi-objcopy -O binary obj/main obj/main.bin

cleanmain:
	gprclean -P hello

buildmain:
	${BUILDER} -P hello



