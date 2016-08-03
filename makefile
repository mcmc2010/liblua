# Flash c++ compile Make file
# 20160803
#
# ----------------------------------------------------------------
# OSX System Platform:
#
# project directory:
# ~/Documents/flash_cpp/liblua
# Flash C++ Compile SDK directory:
# ~/Documents/flash_cpp_sdk/flascc/sdk
# ~/Documents/flash_cpp_sdk/flex/sdk

#
LUA_VERSION_PATH	= lua-5.3.2

#
FLASCC_SDK 	= X
FLEX_SDK	= X


flash: check
	@echo "-----------------------"
	@echo "The $(OS_PLATFORM) platform: compile starting ..."
	@echo "-----------------------"

	cd $(LUA_VERSION_PATH) && make flash $(MAKEFILE_COMMAND)
	
	@echo "The $(OS_PLATFORM) platform: compile ending ..."
	@echo "-----------------------"
echo: 
	cd $(LUA_VERSION_PATH) && make echo $(MAKEFILE_COMMAND)

clean:
	cd $(LUA_VERSION_PATH) && make clean $(MAKEFILE_COMMAND)

#
include common.makefile
