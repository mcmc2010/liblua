# Flash c++ compile Make file
# 20160803
#

$?OSX_FLASCC_SDK 		= ~/Documents/flash_cpp_sdk/flascc/sdk
$?OSX_FLEX_SDK		= ~/Documents/flash_cpp_sdk/flex/sdk
$?CYGWIN_FLASCC_SDK 	= E:\EngineDevelop\Flash_C_Compile\flascc_sdk
$?CYGWIN_FLEX_SDK		= E:\EngineDevelop\Flash_C_Compile\flex_sdk

#
$?OS_PLATFORM 		= X

#
MAKEFILE_FILENAME		= flash.makefile
MAKEFILE_PARAMBASE	= FLASCC_SDK="$(FLASCC_SDK)" FLEX_SDK="$(FLEX_SDK)"
MAKEFILE_COMMAND	= X

# 自动变量取当前信息
$?UNAME 		= $(shell uname -s)

# 存在不为空
ifneq (,$(findstring Darwin, $(UNAME))) 
	OS_PLATFORM = OSX
endif
ifneq (,$(findstring CYGWIN, $(UNAME)))
	OS_PLATFORM = CYGWIN
else
	OS_PLATFORM = UNKNOW
endif


# 判断系统
ifneq (,$(findstring UNKNOW, $(OS_PLATFORM))) 
#	echo "The unknow platform not supported.";
#	exit 1 ;
endif
ifneq (,$(findstring OSX, $(OS_PLATFORM)))
	FLASCC_SDK 	:= $(OSX_FLASCC_SDK)
	FLEX_SDK 	:= $(OSX_FLEX_SDK)
	MAKEFILE_COMMAND = -f  "$(MAKEFILE_FILENAME)"  $(MAKEFILE_PARAMBASE) 
endif
ifneq (,$(findstring CYGWIN, $(OS_PLATFORM)))
	FLASCC_SDK 	:= $(subst :,,/cygdrive/$(subst \,/,$(CYGWIN_FLASCC_SDK)))
	FLEX_SDK 	:= $(subst :,,/cygdrive/$(subst \,/,$(CYGWIN_FLEX_SDK)))
	MAKEFILE_COMMAND = -f "$(MAKEFILE_FILENAME)"  $(MAKEFILE_PARAMBASE) FLASCC_SDK_N="$(CYGWIN_FLASCC_SDK)"
endif

check:
	@echo "-----------------------"
	@echo "Check platform : $(OS_PLATFORM)"
	@echo "FLASCC SDK: $(FLASCC_SDK)"
	@echo "FLEX SDK: $(FLEX_SDK)"
	@echo "-----------------------"

