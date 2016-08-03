# Flash c++ compile Make file
# 20160803
#


compile_cpp:
	mkdir -p ./tmp
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lapi.o -I ./src -c ./src/lapi.c  	
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lauxlib.o -I ./src -c ./src/lauxlib.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lbaselib.o -I ./src -c ./src/lbaselib.c 	
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lbitlib.o -I ./src -c ./src/lbitlib.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lcode.o -I ./src -c ./src/lcode.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lcorolib.o -I ./src -c ./src/lcorolib.c
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lctype.o -I ./src -c ./src/lctype.c
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/ldblib.o -I ./src -c ./src/ldblib.c
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/ldebug.o -I ./src -c ./src/ldebug.c
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/ldo.o -I ./src -c ./src/ldo.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/ldump.o -I ./src -c ./src/ldump.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lfunc.o -I ./src -c ./src/lfunc.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lgc.o -I ./src -c ./src/lgc.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/linit.o -I ./src -c ./src/linit.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/liolib.o -I ./src -c ./src/liolib.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/llex.o -I ./src -c ./src/llex.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lmathlib.o -I ./src -c ./src/lmathlib.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lmem.o -I ./src -c ./src/lmem.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/loadlib.o -I ./src -c ./src/loadlib.c 	
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lobject.o -I ./src -c ./src/lobject.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lopcodes.o -I ./src -c ./src/lopcodes.c
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/loslib.o -I ./src -c ./src/loslib.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lparser.o -I ./src -c ./src/lparser.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lstate.o -I ./src -c ./src/lstate.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lstring.o -I ./src -c ./src/lstring.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lstrlib.o -I ./src -c ./src/lstrlib.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/ltable.o -I ./src -c ./src/ltable.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/ltablib.o -I ./src -c ./src/ltablib.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/ltm.o -I ./src -c ./src/ltm.c
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lua.o -I ./src -c ./src/lua.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/luac.o -I ./src -c ./src/luac.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lundump.o -I ./src -c ./src/lundump.c
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lutf8lib.o -I ./src -c ./src/lutf8lib.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lvm.o -I ./src -c ./src/lvm.c 
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lzio.o -I ./src -c ./src/lzio.c 

copy_include:
	mkdir -p ./include
	cp -rf ./src/lua.hpp ./include
	cp -rf ./src/lua.h ./include
	cp -rf ./src/luaconf.h ./include
	cp -rf ./src/lualib.h ./include
	cp -rf ./src/lauxlib.h ./include