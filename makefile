
all: cleanrts cleanmain buildmain
	arm-eabi-objcopy -O binary obj/main obj/main.bin

cleanmain:
	gprclean -P hello

buildmain: buildrts
	gprbuild -P hello -p

cleanrts:
	gprclean -P ravenscar-sfp-stm32f4/runtime_build

buildrts:
	gprbuild -P ravenscar-sfp-stm32f4/runtime_build -XBUILD=Debug
	
