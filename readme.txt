flash lua (flash c++ compile)
The library file format *.swc;
Lua operation flash divided into two modes:

1: use flash interface (examples):
	flash.trace(...)
	flash.call(...)
2: use lua metatable (examples):
	__script:Logout(...)


Note: AS3 code need add prefix "script_", method only with prefix, can be identified.