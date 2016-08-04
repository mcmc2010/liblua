# Flash c++ compile Make file
# 20160803
#

#當前項目目錄
#CYGWIN無法讓java識別路徑，必須轉換爲windows的路徑寫法
#OSX不需要轉換
LIBLUA_SOURCE 	= $(CURDIR)
LIBLUA_SOURCE_N	= $(LIBLUA_SOURCE)
ifneq (,$(findstring CYGWIN, $(OS_PLATFORM)))
	LIBLUA_SOURCE_N = $(shell cygpath -w -p $(CURDIR))
endif

#
LIBLUA_FILENAME	= liblua.a

#
GCC_COMPILE		= $(FLASCC_SDK)/usr/bin/gcc
GPP_COMPILE		= $(FLASCC_SDK)/usr/bin/g++
AR_LINK		= $(FLASCC_SDK)/usr/bin/ar
RANLIB_LINK		= $(FLASCC_SDK)/usr/bin/ranlib
ifneq (,$(findstring OSX, $(OS_PLATFORM)))
	GCC_COMPILE		= $(FLASCC_SDK)/usr/bin/clang
	GPP_COMPILE		= $(FLASCC_SDK)/usr/bin/clang++
endif

#JAVA 在osx平台无法识别用户目录’~‘
SWIG_COMPILE		= $(FLASCC_SDK)/usr/bin/swig
AS3_COMPILE 		= java -jar "./usr/lib/asc2.jar"

#
CPP_FLAGS_BASE	= -O2 -Wall -Wno-write-strings -Wno-trigraphs
CPP_FLAGS_LUA	= -DLUA_COMPAT_ALL -DLUA_USE_POSIX -DLUA_32BITS
CPP_FLAGS_AS3	= -emit-llvm 
CPP_FLAGS_ALL	= $(CPP_FLAGS_BASE) $(CPP_FLAGS_LUA) $(CPP_FLAGS_AS3)

#
LIBLUA_CORE		= lapi.o lcode.o lctype.o ldebug.o ldo.o ldump.o lfunc.o lgc.o llex.o \
			    lmem.o lobject.o lopcodes.o lparser.o lstate.o lstring.o ltable.o \
			    ltm.o lundump.o lvm.o lzio.o
LIBLUA_LIBS		= lauxlib.o lbaselib.o lbitlib.o lcorolib.o ldblib.o liolib.o \
			    lmathlib.o loslib.o lstrlib.o ltablib.o lutf8lib.o loadlib.o linit.o
LIBLUA_OTHER		= lflashlib.o
LIBLUA_BASE		= $(LIBLUA_CORE) $(LIBLUA_LIBS)
LIBLUA_ALL		= $(LIBLUA_BASE) $(LIBLUA_OTHER)

#
flash:compile_cpp copy_include
	mkdir -p ./lib

	@echo "-> Compile the flash library c++ files."
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL)	-o ./tmp/lflashlib.o -I ./src -c ./flash/lflashlib.c  

	@echo "-> AR link to static library."
	cd ./tmp && $(AR_LINK) rcu ../lib/$(LIBLUA_FILENAME) $(LIBLUA_ALL)
	cd ./tmp && $(RANLIB_LINK) ../lib/$(LIBLUA_FILENAME)

	@echo "-> Generate SWIG wrappers around the functions in the library."
	$(SWIG_COMPILE) -DLUA_32BITS -I./include -as3 -module Lua -outdir ./lib -includeall -ignoremissing -o ./flash/lflashapi_wrapper.c ./flash/lflashapi.h

	@echo "-> Compile the SWIG wrapper to ABC."
	cd $(FLASCC_SDK) && $(AS3_COMPILE) -import "./usr/lib/builtin.abc" -import "./usr/lib/playerglobal.abc" "$(LIBLUA_SOURCE_N)/flash/Lua.as"

	@echo "-> Compile the wrapper files to link files."
	$(GCC_COMPILE)  $(CPP_FLAGS_ALL) -o ./tmp/lflashapi_wrapper.o -I ./include -c ./flash/lflashapi_wrapper.c 
	$(FLASCC_SDK)/usr/bin/nm -f posix "./tmp/lflashapi_wrapper.o" | awk '{print $$1}' | sed 's/_//' > "./flash/exports.txt" 	
	
	@echo "-> Compile the library into a SWC."
	$(GCC_COMPILE) $(CPP_FLAGS_ALL) ./tmp/lflashapi_wrapper.o ./lib/liblua.a ./flash/Lua.abc -jvmopt="-Xmx2000M" -emit-swc=mxlib.lua -o ./flash/mxliblua.swc
#
echo:
	@echo "SYS :$(OS_PLATFORM)"
	@echo "GCC :$(GCC_COMPILE)"
	@echo "G++ :$(GPP_COMPILE)"	
	@echo "AS3 :$(AS3_COMPILE)"
	@echo "SWIG:$(SWIG_COMPILE)"	
	@echo "FLASCC SDK: $(FLASCC_SDK)"
	@echo "FLEX SDK: $(FLEX_SDK)"
	@echo "FLASCC SDK N: $(FLASCC_SDK_N)"
	@echo "SOURCE DIRECTORY: $(LIBLUA_SOURCE_N)"
#
clean:
	@echo "Clean output files"
	rm -rf ./tmp
	rm -rf ./lib
	rm -rf ./flash/exports.txt
	rm -rf ./flash/lflashapi_wrapper.c
	rm -rf ./flash/*.abc

#
include compile.makefile

