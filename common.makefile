# Flash c++ compile Make file
# 20160803
#

$?OSX_FLASCC_SDK 	= ~/Documents/flash_cpp_sdk/flascc/sdk
$?OSX_FLEX_SDK		= ~/Documents/flash_cpp_sdk/flex/sdk

$?OS_PLATFORM 	= X

# 自动变量取当前信息
$?UNAME 		= $(shell uname -s)

# 存在不为空
ifneq (,$(findstring Darwin, $(UNAME))) 
	OS_PLATFORM = OSX
else
	OS_PLATFORM = UNKNOW
endif


# 判断系统
ifneq (,$(findstring UNKNOW, $(OS_PLATFORM))) 
	echo "The unknow platform not supported.";
	exit 1 ;
endif

ifneq (,$(findstring OSX, $(OS_PLATFORM)))
	FLASCC_SDK 	:= $(OSX_FLASCC_SDK)
	FLEX_SDK 	:= $(OSX_FLEX_SDK)
endif

check:
	@echo "-----------------------"
	@echo "Check platform : $(OS_PLATFORM)"
	@echo "FLASCC SDK: $(FLASCC_SDK)"
	@echo "FLEX SDK: $(FLEX_SDK)"
	@echo "-----------------------"

