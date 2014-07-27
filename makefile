
all: cleanrts cleanmain buildmain
	arm-eabi-objcopy -O binary obj/main obj/main.bin

cleanmain:
	gprclean -P test

buildmain: buildrts
	gprbuild -P test -p

cleanrts:
	gprclean -P ravenscar-sfp-stm32f4/runtime_build

buildrts:
	gprbuild -P ravenscar-sfp-stm32f4/runtime_build -XBUILD=Debug
	
