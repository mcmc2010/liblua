--
print(string.format("%s Hello world %s", "_T", "T_"));

-- Test function.
function Helloworld()
	flash.trace(flash.gettimer());
	flash.trace(flash.getnumber(__this, "_test_number"));
	--flash.trace("Lua ->:", flash.getint(__this, "_test_int"));
	--flash.trace("Lua ->:", flash.getstring(__this, "_test_string"));		
	return 123, "abcdef";
end