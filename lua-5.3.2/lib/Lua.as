// This file was automatically generated by SWIG (http://www.swig.org).
// Version 2.0.4
//
// Do not make changes to this file unless you know what you are doing--modify
// the SWIG interface file instead.

/* Function pointers support */
package com.adobe.flascc.swig {
import flash.utils.Dictionary;
import com.adobe.flascc.CModule;

[Weak]
var _SWIG_AS3Func2Ptr:Dictionary = new Dictionary();
[Weak]
var _SWIG_AS3Ptr2Func:Dictionary = new Dictionary();
[Weak]
var _SWIG_AS3FreeFuncPtrs:Array = new Array();

[Weak]
public function SWIG_AS3RegASCallWrapper(ptr:int, wrapper:Function):void {
    if (_SWIG_AS3Ptr2Func[ptr]) {
        throw("tried to register AS-callable wrapper for existing AS wrapper");
    }
    _SWIG_AS3Func2Ptr[wrapper] = ptr;
    _SWIG_AS3Ptr2Func[ptr] = wrapper;
}

[Weak]
public function SWIG_AS3UnregASCallWrapper(wrapper:Function):void {
    var ptr:int = _SWIG_AS3Func2Ptr[wrapper];
    delete _SWIG_AS3Func2Ptr[wrapper];
    delete _SWIG_AS3Ptr2Func[ptr];
}

// Returns Function objects callable from AS
[Weak]
public function SWIG_AS3GetASCallWrapper(ptr:int):Function {
    if (_SWIG_AS3Ptr2Func[ptr]) {
        return _SWIG_AS3Ptr2Func[ptr];
    } else {
        return null;
    }
}

// Returns the number of wrapped C and AS functions
[Weak]
public function SWIG_AS3WrapperNum():uint {
    var num:uint = 0;
    for (var key:int in _SWIG_AS3Ptr2Func) {
        num++;
    }
    return num;
}

[Weak]
public function SWIG_AS3RegCCallWrapper(func:Function, wrapper:Function):void {
    var ptr:int;
    
    if (_SWIG_AS3Func2Ptr[func]) {
        throw("tried to register C-callable wrapper for native C function");
    }

    if (_SWIG_AS3FreeFuncPtrs.length) {
        ptr = _SWIG_AS3FreeFuncPtrs.pop();
    } else {
        ptr = CModule.allocFunPtrs(null, 1, 4);
    }
    CModule.regFun(ptr, wrapper);
    _SWIG_AS3Func2Ptr[func] = ptr;
    _SWIG_AS3Ptr2Func[ptr] = func;

}

[Weak]
public function SWIG_AS3UnregCCallWrapper(func:Function):void {
    var ptr:int = _SWIG_AS3Func2Ptr[func];
    delete _SWIG_AS3Func2Ptr[func];
    delete _SWIG_AS3Ptr2Func[ptr];
    _SWIG_AS3FreeFuncPtrs.push(ptr);
}

// Returns a C function pointer corresponding to an Actionscript-callable 
// wrapper Function. (The C function is callable from C, of course).
[Weak]
public function SWIG_AS3GetCCallPtr(func:Function):int {
    if (_SWIG_AS3Func2Ptr[func]) {
        return _SWIG_AS3Func2Ptr[func];
    } else {
        return 0;
    }
}
} /* package */


package {
import C_Run.*;
import com.adobe.flascc.swig.*;
import flash.utils.ByteArray;

public class Lua_DebugValue {
	public static const size:int = 100;

	private const _ba:ByteArray;
	private const _offs:int;

	public function Lua_DebugValue(ba:ByteArray = null, offs:int = 0) {
		if (!ba) {
			ba = new ByteArray();
			ba.endian = "littleEndian";
			ba.length = 100;
		}
		_ba = ba;
		_offs = offs;
	}

	public function addressOf():int {
		import C_Run.ram;
		if (_ba != ram) {
			throw new Error("Cannot take address of object not in domainMemory");
		}
		return _offs;
	}

	public function get event():int {
		_ba.position = _offs + 0;
		return _ba.readInt();
	}

	public function set event(v:int):void {
		_ba.position = _offs + 0;
		_ba.writeInt(v);
	}

	public function get name():int {
		_ba.position = _offs + 4;
		return _ba.readInt();
	}

	public function set name(v:int):void {
		_ba.position = _offs + 4;
		_ba.writeInt(v);
	}

	public function get namewhat():int {
		_ba.position = _offs + 8;
		return _ba.readInt();
	}

	public function set namewhat(v:int):void {
		_ba.position = _offs + 8;
		_ba.writeInt(v);
	}

	public function get what():int {
		_ba.position = _offs + 12;
		return _ba.readInt();
	}

	public function set what(v:int):void {
		_ba.position = _offs + 12;
		_ba.writeInt(v);
	}

	public function get source():int {
		_ba.position = _offs + 16;
		return _ba.readInt();
	}

	public function set source(v:int):void {
		_ba.position = _offs + 16;
		_ba.writeInt(v);
	}

	public function get currentline():int {
		_ba.position = _offs + 20;
		return _ba.readInt();
	}

	public function set currentline(v:int):void {
		_ba.position = _offs + 20;
		_ba.writeInt(v);
	}

	public function get linedefined():int {
		_ba.position = _offs + 24;
		return _ba.readInt();
	}

	public function set linedefined(v:int):void {
		_ba.position = _offs + 24;
		_ba.writeInt(v);
	}

	public function get lastlinedefined():int {
		_ba.position = _offs + 28;
		return _ba.readInt();
	}

	public function set lastlinedefined(v:int):void {
		_ba.position = _offs + 28;
		_ba.writeInt(v);
	}

	public function get nups():uint {
		_ba.position = _offs + 32;
		return _ba.readUnsignedByte();
	}

	public function set nups(v:uint):void {
		_ba.position = _offs + 32;
		_ba.writeByte(v);
	}

	public function get nparams():uint {
		_ba.position = _offs + 33;
		return _ba.readUnsignedByte();
	}

	public function set nparams(v:uint):void {
		_ba.position = _offs + 33;
		_ba.writeByte(v);
	}

	public function get isvararg():int {
		_ba.position = _offs + 34;
		return _ba.readByte();
	}

	public function set isvararg(v:int):void {
		_ba.position = _offs + 34;
		_ba.writeByte(v);
	}

	public function get istailcall():int {
		_ba.position = _offs + 35;
		return _ba.readByte();
	}

	public function set istailcall(v:int):void {
		_ba.position = _offs + 35;
		_ba.writeByte(v);
	}

	public function get short_src():ByteArray {
		var ret = new ByteArray();
		ret.endian = "littleEndian";
		_ba.position = _offs + 36;
		_ba.readBytes(ret, 0, 60);
		return ret;
	}

	public function set short_src(v:ByteArray):void {
		v.readBytes(_ba, _offs + 36, 60);
	}

	public function get i_ci():int {
		_ba.position = _offs + 96;
		return _ba.readInt();
	}

	public function set i_ci(v:int):void {
		_ba.position = _offs + 96;
		_ba.writeInt(v);
	}

	public function read(ptr:int):void {
		import C_Run.ram;
		_ba.position = _offs;
		_ba.readBytes(ram, ptr, size);
	}

	public function write(ptr:int, ba:ByteArray = null):void {
		import C_Run.ram;
		if (!ba) {
			ba = C_Run.ram;
		}
		ba.position = ptr;
		ba.writeBytes(_ba, _offs, size);
	}
}

public class LuaL_RegValue {
	public static const size:int = 8;

	private const _ba:ByteArray;
	private const _offs:int;

	public function LuaL_RegValue(ba:ByteArray = null, offs:int = 0) {
		if (!ba) {
			ba = new ByteArray();
			ba.endian = "littleEndian";
			ba.length = 8;
		}
		_ba = ba;
		_offs = offs;
	}

	public function addressOf():int {
		import C_Run.ram;
		if (_ba != ram) {
			throw new Error("Cannot take address of object not in domainMemory");
		}
		return _offs;
	}

	public function get name():int {
		_ba.position = _offs + 0;
		return _ba.readInt();
	}

	public function set name(v:int):void {
		_ba.position = _offs + 0;
		_ba.writeInt(v);
	}

	public function get func():int {
		_ba.position = _offs + 4;
		return _ba.readInt();
	}

	public function set func(v:int):void {
		_ba.position = _offs + 4;
		_ba.writeInt(v);
	}

	public function read(ptr:int):void {
		import C_Run.ram;
		_ba.position = _offs;
		_ba.readBytes(ram, ptr, size);
	}

	public function write(ptr:int, ba:ByteArray = null):void {
		import C_Run.ram;
		if (!ba) {
			ba = C_Run.ram;
		}
		ba.position = ptr;
		ba.writeBytes(_ba, _offs, size);
	}
}

public class LuaL_BufferValue {
	public static const size:int = 8208;

	private const _ba:ByteArray;
	private const _offs:int;

	public function LuaL_BufferValue(ba:ByteArray = null, offs:int = 0) {
		if (!ba) {
			ba = new ByteArray();
			ba.endian = "littleEndian";
			ba.length = 8208;
		}
		_ba = ba;
		_offs = offs;
	}

	public function addressOf():int {
		import C_Run.ram;
		if (_ba != ram) {
			throw new Error("Cannot take address of object not in domainMemory");
		}
		return _offs;
	}

	public function get b():int {
		_ba.position = _offs + 0;
		return _ba.readInt();
	}

	public function set b(v:int):void {
		_ba.position = _offs + 0;
		_ba.writeInt(v);
	}

	public function get size():uint {
		_ba.position = _offs + 4;
		return _ba.readUnsignedInt();
	}

	public function set size(v:uint):void {
		_ba.position = _offs + 4;
		_ba.writeInt(v);
	}

	public function get n():uint {
		_ba.position = _offs + 8;
		return _ba.readUnsignedInt();
	}

	public function set n(v:uint):void {
		_ba.position = _offs + 8;
		_ba.writeInt(v);
	}

	public function get L():int {
		_ba.position = _offs + 12;
		return _ba.readInt();
	}

	public function set L(v:int):void {
		_ba.position = _offs + 12;
		_ba.writeInt(v);
	}

	public function get initb():ByteArray {
		var ret = new ByteArray();
		ret.endian = "littleEndian";
		_ba.position = _offs + 16;
		_ba.readBytes(ret, 0, 8192);
		return ret;
	}

	public function set initb(v:ByteArray):void {
		v.readBytes(_ba, _offs + 16, 8192);
	}

	public function read(ptr:int):void {
		import C_Run.ram;
		_ba.position = _offs;
		_ba.readBytes(ram, ptr, size);
	}

	public function write(ptr:int, ba:ByteArray = null):void {
		import C_Run.ram;
		if (!ba) {
			ba = C_Run.ram;
		}
		ba.position = ptr;
		ba.writeBytes(_ba, _offs, size);
	}
}

public class LuaL_StreamValue {
	public static const size:int = 8;

	private const _ba:ByteArray;
	private const _offs:int;

	public function LuaL_StreamValue(ba:ByteArray = null, offs:int = 0) {
		if (!ba) {
			ba = new ByteArray();
			ba.endian = "littleEndian";
			ba.length = 8;
		}
		_ba = ba;
		_offs = offs;
	}

	public function addressOf():int {
		import C_Run.ram;
		if (_ba != ram) {
			throw new Error("Cannot take address of object not in domainMemory");
		}
		return _offs;
	}

	public function get f():int {
		_ba.position = _offs + 0;
		return _ba.readInt();
	}

	public function set f(v:int):void {
		_ba.position = _offs + 0;
		_ba.writeInt(v);
	}

	public function get closef():int {
		_ba.position = _offs + 4;
		return _ba.readInt();
	}

	public function set closef(v:int):void {
		_ba.position = _offs + 4;
		_ba.writeInt(v);
	}

	public function read(ptr:int):void {
		import C_Run.ram;
		_ba.position = _offs;
		_ba.readBytes(ram, ptr, size);
	}

	public function write(ptr:int, ba:ByteArray = null):void {
		import C_Run.ram;
		if (!ba) {
			ba = C_Run.ram;
		}
		ba.position = ptr;
		ba.writeBytes(_ba, _offs, size);
	}
}

public class Lua {
	public static function get LUAI_BITSINT():int{
		return _wrap_LUAI_BITSINT();
	}

	public static function get LUA_INT_INT():int{
		return _wrap_LUA_INT_INT();
	}

	public static function get LUA_INT_LONG():int{
		return _wrap_LUA_INT_LONG();
	}

	public static function get LUA_INT_LONGLONG():int{
		return _wrap_LUA_INT_LONGLONG();
	}

	public static function get LUA_FLOAT_FLOAT():int{
		return _wrap_LUA_FLOAT_FLOAT();
	}

	public static function get LUA_FLOAT_DOUBLE():int{
		return _wrap_LUA_FLOAT_DOUBLE();
	}

	public static function get LUA_FLOAT_LONGDOUBLE():int{
		return _wrap_LUA_FLOAT_LONGDOUBLE();
	}

	public static function get LUA_INT_TYPE():int{
		return _wrap_LUA_INT_TYPE();
	}

	public static function get LUA_FLOAT_TYPE():int{
		return _wrap_LUA_FLOAT_TYPE();
	}

	public static function get LUA_ROOT():String{
		return _wrap_LUA_ROOT();
	}

	public static function get LUA_DIRSEP():String{
		return _wrap_LUA_DIRSEP();
	}

	public static function get LUA_NUMBER_FRMLEN():String{
		return _wrap_LUA_NUMBER_FRMLEN();
	}

	public static function get LUA_NUMBER_FMT():String{
		return _wrap_LUA_NUMBER_FMT();
	}

	public static function get LUA_INTEGER_FRMLEN():String{
		return _wrap_LUA_INTEGER_FRMLEN();
	}

	public static function get LUAI_MAXSTACK():int{
		return _wrap_LUAI_MAXSTACK();
	}

	public static function get LUA_IDSIZE():int{
		return _wrap_LUA_IDSIZE();
	}

	public static function get LUAL_BUFFERSIZE():int{
		return _wrap_LUAL_BUFFERSIZE();
	}

	public static function get LUA_QS():String{
		return _wrap_LUA_QS();
	}

	public static function get LUA_VERSION_MAJOR():String{
		return _wrap_LUA_VERSION_MAJOR();
	}

	public static function get LUA_VERSION_MINOR():String{
		return _wrap_LUA_VERSION_MINOR();
	}

	public static function get LUA_VERSION_NUM():int{
		return _wrap_LUA_VERSION_NUM();
	}

	public static function get LUA_VERSION_RELEASE():String{
		return _wrap_LUA_VERSION_RELEASE();
	}

	public static function get LUA_VERSION():String{
		return _wrap_LUA_VERSION();
	}

	public static function get LUA_RELEASE():String{
		return _wrap_LUA_RELEASE();
	}

	public static function get LUA_COPYRIGHT():String{
		return _wrap_LUA_COPYRIGHT();
	}

	public static function get LUA_AUTHORS():String{
		return _wrap_LUA_AUTHORS();
	}

	public static function get LUA_SIGNATURE():String{
		return _wrap_LUA_SIGNATURE();
	}

	public static function get LUA_MULTRET():int{
		return _wrap_LUA_MULTRET();
	}

	public static function get LUA_REGISTRYINDEX():int{
		return _wrap_LUA_REGISTRYINDEX();
	}

	public static function get LUA_OK():int{
		return _wrap_LUA_OK();
	}

	public static function get LUA_YIELD():int{
		return _wrap_LUA_YIELD();
	}

	public static function get LUA_ERRRUN():int{
		return _wrap_LUA_ERRRUN();
	}

	public static function get LUA_ERRSYNTAX():int{
		return _wrap_LUA_ERRSYNTAX();
	}

	public static function get LUA_ERRMEM():int{
		return _wrap_LUA_ERRMEM();
	}

	public static function get LUA_ERRGCMM():int{
		return _wrap_LUA_ERRGCMM();
	}

	public static function get LUA_ERRERR():int{
		return _wrap_LUA_ERRERR();
	}

	public static function get LUA_TNONE():int{
		return _wrap_LUA_TNONE();
	}

	public static function get LUA_TNIL():int{
		return _wrap_LUA_TNIL();
	}

	public static function get LUA_TBOOLEAN():int{
		return _wrap_LUA_TBOOLEAN();
	}

	public static function get LUA_TLIGHTUSERDATA():int{
		return _wrap_LUA_TLIGHTUSERDATA();
	}

	public static function get LUA_TNUMBER():int{
		return _wrap_LUA_TNUMBER();
	}

	public static function get LUA_TSTRING():int{
		return _wrap_LUA_TSTRING();
	}

	public static function get LUA_TTABLE():int{
		return _wrap_LUA_TTABLE();
	}

	public static function get LUA_TFUNCTION():int{
		return _wrap_LUA_TFUNCTION();
	}

	public static function get LUA_TUSERDATA():int{
		return _wrap_LUA_TUSERDATA();
	}

	public static function get LUA_TTHREAD():int{
		return _wrap_LUA_TTHREAD();
	}

	public static function get LUA_NUMTAGS():int{
		return _wrap_LUA_NUMTAGS();
	}

	public static function get LUA_MINSTACK():int{
		return _wrap_LUA_MINSTACK();
	}

	public static function get LUA_RIDX_MAINTHREAD():int{
		return _wrap_LUA_RIDX_MAINTHREAD();
	}

	public static function get LUA_RIDX_GLOBALS():int{
		return _wrap_LUA_RIDX_GLOBALS();
	}

	public static function get LUA_RIDX_LAST():int{
		return _wrap_LUA_RIDX_LAST();
	}

	public static function get lua_ident():int {
		return _wrap_lua_ident_get();
	}

	public static function lua_newstate(f:Function, ud:Number):Number {
		return _wrap_lua_newstate(f, ud);
	}

	public static function lua_close(L:Number):void {
		_wrap_lua_close(L);
	}

	public static function lua_newthread(L:Number):Number {
		return _wrap_lua_newthread(L);
	}

	public static function lua_atpanic(L:Number, panicf:Function):Function {
		return _wrap_lua_atpanic(L, panicf);
	}

	public static function lua_version(L:Number):int {
		return _wrap_lua_version(L);
	}

	public static function lua_absindex(L:Number, idx:int):int {
		return _wrap_lua_absindex(L, idx);
	}

	public static function lua_gettop(L:Number):int {
		return _wrap_lua_gettop(L);
	}

	public static function lua_settop(L:Number, idx:int):void {
		_wrap_lua_settop(L, idx);
	}

	public static function lua_pushvalue(L:Number, idx:int):void {
		_wrap_lua_pushvalue(L, idx);
	}

	public static function lua_rotate(L:Number, idx:int, n:int):void {
		_wrap_lua_rotate(L, idx, n);
	}

	public static function lua_copy(L:Number, fromidx:int, toidx:int):void {
		_wrap_lua_copy(L, fromidx, toidx);
	}

	public static function lua_checkstack(L:Number, n:int):int {
		return _wrap_lua_checkstack(L, n);
	}

	public static function lua_xmove(from:Number, to:Number, n:int):void {
		_wrap_lua_xmove(from, to, n);
	}

	public static function lua_isnumber(L:Number, idx:int):int {
		return _wrap_lua_isnumber(L, idx);
	}

	public static function lua_isstring(L:Number, idx:int):int {
		return _wrap_lua_isstring(L, idx);
	}

	public static function lua_iscfunction(L:Number, idx:int):int {
		return _wrap_lua_iscfunction(L, idx);
	}

	public static function lua_isinteger(L:Number, idx:int):int {
		return _wrap_lua_isinteger(L, idx);
	}

	public static function lua_isuserdata(L:Number, idx:int):int {
		return _wrap_lua_isuserdata(L, idx);
	}

	public static function lua_type(L:Number, idx:int):int {
		return _wrap_lua_type(L, idx);
	}

	public static function lua_typename(L:Number, tp:int):String {
		return _wrap_lua_typename(L, tp);
	}

	public static function lua_tonumberx(L:Number, idx:int, isnum:int):Number {
		return _wrap_lua_tonumberx(L, idx, isnum);
	}

	public static function lua_tointegerx(L:Number, idx:int, isnum:int):int {
		return _wrap_lua_tointegerx(L, idx, isnum);
	}

	public static function lua_toboolean(L:Number, idx:int):int {
		return _wrap_lua_toboolean(L, idx);
	}

	public static function lua_tolstring(L:Number, idx:int, len:int):String {
		return _wrap_lua_tolstring(L, idx, len);
	}

	public static function lua_rawlen(L:Number, idx:int):uint {
		return _wrap_lua_rawlen(L, idx);
	}

	public static function lua_tocfunction(L:Number, idx:int):Function {
		return _wrap_lua_tocfunction(L, idx);
	}

	public static function lua_touserdata(L:Number, idx:int):Number {
		return _wrap_lua_touserdata(L, idx);
	}

	public static function lua_tothread(L:Number, idx:int):Number {
		return _wrap_lua_tothread(L, idx);
	}

	public static function lua_topointer(L:Number, idx:int):Number {
		return _wrap_lua_topointer(L, idx);
	}

	public static function get LUA_OPADD():int{
		return _wrap_LUA_OPADD();
	}

	public static function get LUA_OPSUB():int{
		return _wrap_LUA_OPSUB();
	}

	public static function get LUA_OPMUL():int{
		return _wrap_LUA_OPMUL();
	}

	public static function get LUA_OPMOD():int{
		return _wrap_LUA_OPMOD();
	}

	public static function get LUA_OPPOW():int{
		return _wrap_LUA_OPPOW();
	}

	public static function get LUA_OPDIV():int{
		return _wrap_LUA_OPDIV();
	}

	public static function get LUA_OPIDIV():int{
		return _wrap_LUA_OPIDIV();
	}

	public static function get LUA_OPBAND():int{
		return _wrap_LUA_OPBAND();
	}

	public static function get LUA_OPBOR():int{
		return _wrap_LUA_OPBOR();
	}

	public static function get LUA_OPBXOR():int{
		return _wrap_LUA_OPBXOR();
	}

	public static function get LUA_OPSHL():int{
		return _wrap_LUA_OPSHL();
	}

	public static function get LUA_OPSHR():int{
		return _wrap_LUA_OPSHR();
	}

	public static function get LUA_OPUNM():int{
		return _wrap_LUA_OPUNM();
	}

	public static function get LUA_OPBNOT():int{
		return _wrap_LUA_OPBNOT();
	}

	public static function lua_arith(L:Number, op:int):void {
		_wrap_lua_arith(L, op);
	}

	public static function get LUA_OPEQ():int{
		return _wrap_LUA_OPEQ();
	}

	public static function get LUA_OPLT():int{
		return _wrap_LUA_OPLT();
	}

	public static function get LUA_OPLE():int{
		return _wrap_LUA_OPLE();
	}

	public static function lua_rawequal(L:Number, idx1:int, idx2:int):int {
		return _wrap_lua_rawequal(L, idx1, idx2);
	}

	public static function lua_compare(L:Number, idx1:int, idx2:int, op:int):int {
		return _wrap_lua_compare(L, idx1, idx2, op);
	}

	public static function lua_pushnil(L:Number):void {
		_wrap_lua_pushnil(L);
	}

	public static function lua_pushnumber(L:Number, n:Number):void {
		_wrap_lua_pushnumber(L, n);
	}

	public static function lua_pushinteger(L:Number, n:int):void {
		_wrap_lua_pushinteger(L, n);
	}

	public static function lua_pushlstring(L:Number, s:String, len:uint):String {
		return _wrap_lua_pushlstring(L, s, len);
	}

	public static function lua_pushstring(L:Number, s:String):String {
		return _wrap_lua_pushstring(L, s);
	}

	public static function lua_pushvfstring(L:Number, fmt:String, argp:*):String {
		return _wrap_lua_pushvfstring(L, fmt, argp);
	}

	public static function lua_pushfstring(L:Number, fmt:String, arg3):String {
		return _wrap_lua_pushfstring(L, fmt, arg3);
	}

	public static function lua_pushcclosure(L:Number, fn:Function, n:int):void {
		_wrap_lua_pushcclosure(L, fn, n);
	}

	public static function lua_pushboolean(L:Number, b:int):void {
		_wrap_lua_pushboolean(L, b);
	}

	public static function lua_pushlightuserdata(L:Number, p:Number):void {
		_wrap_lua_pushlightuserdata(L, p);
	}

	public static function lua_pushthread(L:Number):int {
		return _wrap_lua_pushthread(L);
	}

	public static function lua_getglobal(L:Number, name:String):int {
		return _wrap_lua_getglobal(L, name);
	}

	public static function lua_gettable(L:Number, idx:int):int {
		return _wrap_lua_gettable(L, idx);
	}

	public static function lua_getfield(L:Number, idx:int, k:String):int {
		return _wrap_lua_getfield(L, idx, k);
	}

	public static function lua_geti(L:Number, idx:int, n:int):int {
		return _wrap_lua_geti(L, idx, n);
	}

	public static function lua_rawget(L:Number, idx:int):int {
		return _wrap_lua_rawget(L, idx);
	}

	public static function lua_rawgeti(L:Number, idx:int, n:int):int {
		return _wrap_lua_rawgeti(L, idx, n);
	}

	public static function lua_rawgetp(L:Number, idx:int, p:Number):int {
		return _wrap_lua_rawgetp(L, idx, p);
	}

	public static function lua_createtable(L:Number, narr:int, nrec:int):void {
		_wrap_lua_createtable(L, narr, nrec);
	}

	public static function lua_newuserdata(L:Number, sz:uint):Number {
		return _wrap_lua_newuserdata(L, sz);
	}

	public static function lua_getmetatable(L:Number, objindex:int):int {
		return _wrap_lua_getmetatable(L, objindex);
	}

	public static function lua_getuservalue(L:Number, idx:int):int {
		return _wrap_lua_getuservalue(L, idx);
	}

	public static function lua_setglobal(L:Number, name:String):void {
		_wrap_lua_setglobal(L, name);
	}

	public static function lua_settable(L:Number, idx:int):void {
		_wrap_lua_settable(L, idx);
	}

	public static function lua_setfield(L:Number, idx:int, k:String):void {
		_wrap_lua_setfield(L, idx, k);
	}

	public static function lua_seti(L:Number, idx:int, n:int):void {
		_wrap_lua_seti(L, idx, n);
	}

	public static function lua_rawset(L:Number, idx:int):void {
		_wrap_lua_rawset(L, idx);
	}

	public static function lua_rawseti(L:Number, idx:int, n:int):void {
		_wrap_lua_rawseti(L, idx, n);
	}

	public static function lua_rawsetp(L:Number, idx:int, p:Number):void {
		_wrap_lua_rawsetp(L, idx, p);
	}

	public static function lua_setmetatable(L:Number, objindex:int):int {
		return _wrap_lua_setmetatable(L, objindex);
	}

	public static function lua_setuservalue(L:Number, idx:int):void {
		_wrap_lua_setuservalue(L, idx);
	}

	public static function lua_callk(L:Number, nargs:int, nresults:int, ctx:*):void {
		_wrap_lua_callk(L, nargs, nresults, ctx);
	}

	public static function lua_pcallk(L:Number, nargs:int, nresults:int, errfunc:int, ctx:*):int {
		return _wrap_lua_pcallk(L, nargs, nresults, errfunc, ctx);
	}

	public static function lua_load(L:Number, reader:Function, dt:Number, chunkname:String, mode:String):int {
		return _wrap_lua_load(L, reader, dt, chunkname, mode);
	}

	public static function lua_dump(L:Number, writer:Function, data:Number, strip:int):int {
		return _wrap_lua_dump(L, writer, data, strip);
	}

	public static function lua_yieldk(L:Number, nresults:int, ctx:*):int {
		return _wrap_lua_yieldk(L, nresults, ctx);
	}

	public static function lua_resume(L:Number, from:Number, narg:int):int {
		return _wrap_lua_resume(L, from, narg);
	}

	public static function lua_status(L:Number):int {
		return _wrap_lua_status(L);
	}

	public static function lua_isyieldable(L:Number):int {
		return _wrap_lua_isyieldable(L);
	}

	public static function get LUA_GCSTOP():int{
		return _wrap_LUA_GCSTOP();
	}

	public static function get LUA_GCRESTART():int{
		return _wrap_LUA_GCRESTART();
	}

	public static function get LUA_GCCOLLECT():int{
		return _wrap_LUA_GCCOLLECT();
	}

	public static function get LUA_GCCOUNT():int{
		return _wrap_LUA_GCCOUNT();
	}

	public static function get LUA_GCCOUNTB():int{
		return _wrap_LUA_GCCOUNTB();
	}

	public static function get LUA_GCSTEP():int{
		return _wrap_LUA_GCSTEP();
	}

	public static function get LUA_GCSETPAUSE():int{
		return _wrap_LUA_GCSETPAUSE();
	}

	public static function get LUA_GCSETSTEPMUL():int{
		return _wrap_LUA_GCSETSTEPMUL();
	}

	public static function get LUA_GCISRUNNING():int{
		return _wrap_LUA_GCISRUNNING();
	}

	public static function lua_gc(L:Number, what:int, data:int):int {
		return _wrap_lua_gc(L, what, data);
	}

	public static function lua_error(L:Number):int {
		return _wrap_lua_error(L);
	}

	public static function lua_next(L:Number, idx:int):int {
		return _wrap_lua_next(L, idx);
	}

	public static function lua_concat(L:Number, n:int):void {
		_wrap_lua_concat(L, n);
	}

	public static function lua_len(L:Number, idx:int):void {
		_wrap_lua_len(L, idx);
	}

	public static function lua_stringtonumber(L:Number, s:String):uint {
		return _wrap_lua_stringtonumber(L, s);
	}

	public static function lua_getallocf(L:Number, ud:int):Function {
		return _wrap_lua_getallocf(L, ud);
	}

	public static function lua_setallocf(L:Number, f:Function, ud:Number):void {
		_wrap_lua_setallocf(L, f, ud);
	}

	public static function get LUA_HOOKCALL():int{
		return _wrap_LUA_HOOKCALL();
	}

	public static function get LUA_HOOKRET():int{
		return _wrap_LUA_HOOKRET();
	}

	public static function get LUA_HOOKLINE():int{
		return _wrap_LUA_HOOKLINE();
	}

	public static function get LUA_HOOKCOUNT():int{
		return _wrap_LUA_HOOKCOUNT();
	}

	public static function get LUA_HOOKTAILCALL():int{
		return _wrap_LUA_HOOKTAILCALL();
	}

	public static function get LUA_MASKCALL():int{
		return _wrap_LUA_MASKCALL();
	}

	public static function get LUA_MASKRET():int{
		return _wrap_LUA_MASKRET();
	}

	public static function get LUA_MASKLINE():int{
		return _wrap_LUA_MASKLINE();
	}

	public static function get LUA_MASKCOUNT():int{
		return _wrap_LUA_MASKCOUNT();
	}

	public static function lua_getstack(L:Number, level:int, ar:int):int {
		return _wrap_lua_getstack(L, level, ar);
	}

	public static function lua_getinfo(L:Number, what:String, ar:int):int {
		return _wrap_lua_getinfo(L, what, ar);
	}

	public static function lua_getlocal(L:Number, ar:int, n:int):String {
		return _wrap_lua_getlocal(L, ar, n);
	}

	public static function lua_setlocal(L:Number, ar:int, n:int):String {
		return _wrap_lua_setlocal(L, ar, n);
	}

	public static function lua_getupvalue(L:Number, funcindex:int, n:int):String {
		return _wrap_lua_getupvalue(L, funcindex, n);
	}

	public static function lua_setupvalue(L:Number, funcindex:int, n:int):String {
		return _wrap_lua_setupvalue(L, funcindex, n);
	}

	public static function lua_upvalueid(L:Number, fidx:int, n:int):Number {
		return _wrap_lua_upvalueid(L, fidx, n);
	}

	public static function lua_upvaluejoin(L:Number, fidx1:int, n1:int, fidx2:int, n2:int):void {
		_wrap_lua_upvaluejoin(L, fidx1, n1, fidx2, n2);
	}

	public static function lua_sethook(L:Number, func:Function, mask:int, count:int):void {
		_wrap_lua_sethook(L, func, mask, count);
	}

	public static function lua_gethook(L:Number):Function {
		return _wrap_lua_gethook(L);
	}

	public static function lua_gethookmask(L:Number):int {
		return _wrap_lua_gethookmask(L);
	}

	public static function lua_gethookcount(L:Number):int {
		return _wrap_lua_gethookcount(L);
	}

	public static function get LUA_ERRFILE():int{
		return _wrap_LUA_ERRFILE();
	}

	public static function luaL_checkversion_(L:Number, ver:Number, sz:uint):void {
		_wrap_luaL_checkversion_(L, ver, sz);
	}

	public static function luaL_getmetafield(L:Number, obj:int, e:String):int {
		return _wrap_luaL_getmetafield(L, obj, e);
	}

	public static function luaL_callmeta(L:Number, obj:int, e:String):int {
		return _wrap_luaL_callmeta(L, obj, e);
	}

	public static function luaL_tolstring(L:Number, idx:int, len:int):String {
		return _wrap_luaL_tolstring(L, idx, len);
	}

	public static function luaL_argerror(L:Number, arg:int, extramsg:String):int {
		return _wrap_luaL_argerror(L, arg, extramsg);
	}

	public static function luaL_checklstring(L:Number, arg:int, l:int):String {
		return _wrap_luaL_checklstring(L, arg, l);
	}

	public static function luaL_optlstring(L:Number, arg:int, def:String, l:int):String {
		return _wrap_luaL_optlstring(L, arg, def, l);
	}

	public static function luaL_checknumber(L:Number, arg:int):Number {
		return _wrap_luaL_checknumber(L, arg);
	}

	public static function luaL_optnumber(L:Number, arg:int, def:Number):Number {
		return _wrap_luaL_optnumber(L, arg, def);
	}

	public static function luaL_checkinteger(L:Number, arg:int):int {
		return _wrap_luaL_checkinteger(L, arg);
	}

	public static function luaL_optinteger(L:Number, arg:int, def:int):int {
		return _wrap_luaL_optinteger(L, arg, def);
	}

	public static function luaL_checkstack(L:Number, sz:int, msg:String):void {
		_wrap_luaL_checkstack(L, sz, msg);
	}

	public static function luaL_checktype(L:Number, arg:int, t:int):void {
		_wrap_luaL_checktype(L, arg, t);
	}

	public static function luaL_checkany(L:Number, arg:int):void {
		_wrap_luaL_checkany(L, arg);
	}

	public static function luaL_newmetatable(L:Number, tname:String):int {
		return _wrap_luaL_newmetatable(L, tname);
	}

	public static function luaL_setmetatable(L:Number, tname:String):void {
		_wrap_luaL_setmetatable(L, tname);
	}

	public static function luaL_testudata(L:Number, ud:int, tname:String):Number {
		return _wrap_luaL_testudata(L, ud, tname);
	}

	public static function luaL_checkudata(L:Number, ud:int, tname:String):Number {
		return _wrap_luaL_checkudata(L, ud, tname);
	}

	public static function luaL_where(L:Number, lvl:int):void {
		_wrap_luaL_where(L, lvl);
	}

	public static function luaL_error(L:Number, fmt:String, arg3):int {
		return _wrap_luaL_error(L, fmt, arg3);
	}

	public static function luaL_checkoption(L:Number, arg:int, def:String, lst:int):int {
		return _wrap_luaL_checkoption(L, arg, def, lst);
	}

	public static function luaL_fileresult(L:Number, stat:int, fname:String):int {
		return _wrap_luaL_fileresult(L, stat, fname);
	}

	public static function luaL_execresult(L:Number, stat:int):int {
		return _wrap_luaL_execresult(L, stat);
	}

	public static function get LUA_NOREF():int{
		return _wrap_LUA_NOREF();
	}

	public static function get LUA_REFNIL():int{
		return _wrap_LUA_REFNIL();
	}

	public static function luaL_ref(L:Number, t:int):int {
		return _wrap_luaL_ref(L, t);
	}

	public static function luaL_unref(L:Number, t:int, ref:int):void {
		_wrap_luaL_unref(L, t, ref);
	}

	public static function luaL_loadfilex(L:Number, filename:String, mode:String):int {
		return _wrap_luaL_loadfilex(L, filename, mode);
	}

	public static function luaL_loadbufferx(L:Number, buff:String, sz:uint, name:String, mode:String):int {
		return _wrap_luaL_loadbufferx(L, buff, sz, name, mode);
	}

	public static function luaL_loadstring(L:Number, s:String):int {
		return _wrap_luaL_loadstring(L, s);
	}

	public static function luaL_newstate():Number {
		return _wrap_luaL_newstate();
	}

	public static function luaL_len(L:Number, idx:int):int {
		return _wrap_luaL_len(L, idx);
	}

	public static function luaL_gsub(L:Number, s:String, p:String, r:String):String {
		return _wrap_luaL_gsub(L, s, p, r);
	}

	public static function luaL_setfuncs(L:Number, l:int, nup:int):void {
		_wrap_luaL_setfuncs(L, l, nup);
	}

	public static function luaL_getsubtable(L:Number, idx:int, fname:String):int {
		return _wrap_luaL_getsubtable(L, idx, fname);
	}

	public static function luaL_traceback(L:Number, L1:Number, msg:String, level:int):void {
		_wrap_luaL_traceback(L, L1, msg, level);
	}

	public static function luaL_requiref(L:Number, modname:String, openf:Function, glb:int):void {
		_wrap_luaL_requiref(L, modname, openf, glb);
	}

	public static function luaL_buffinit(L:Number, B:int):void {
		_wrap_luaL_buffinit(L, B);
	}

	public static function luaL_prepbuffsize(B:int, sz:uint):String {
		return _wrap_luaL_prepbuffsize(B, sz);
	}

	public static function luaL_addlstring(B:int, s:String, l:uint):void {
		_wrap_luaL_addlstring(B, s, l);
	}

	public static function luaL_addstring(B:int, s:String):void {
		_wrap_luaL_addstring(B, s);
	}

	public static function luaL_addvalue(B:int):void {
		_wrap_luaL_addvalue(B);
	}

	public static function luaL_pushresult(B:int):void {
		_wrap_luaL_pushresult(B);
	}

	public static function luaL_pushresultsize(B:int, sz:uint):void {
		_wrap_luaL_pushresultsize(B, sz);
	}

	public static function luaL_buffinitsize(L:Number, B:int, sz:uint):String {
		return _wrap_luaL_buffinitsize(L, B, sz);
	}

	public static function get LUA_FILEHANDLE():String{
		return _wrap_LUA_FILEHANDLE();
	}

	public static function luaopen_base(L:Number):int {
		return _wrap_luaopen_base(L);
	}

	public static function get LUA_COLIBNAME():String{
		return _wrap_LUA_COLIBNAME();
	}

	public static function luaopen_coroutine(L:Number):int {
		return _wrap_luaopen_coroutine(L);
	}

	public static function get LUA_TABLIBNAME():String{
		return _wrap_LUA_TABLIBNAME();
	}

	public static function luaopen_table(L:Number):int {
		return _wrap_luaopen_table(L);
	}

	public static function get LUA_IOLIBNAME():String{
		return _wrap_LUA_IOLIBNAME();
	}

	public static function luaopen_io(L:Number):int {
		return _wrap_luaopen_io(L);
	}

	public static function get LUA_OSLIBNAME():String{
		return _wrap_LUA_OSLIBNAME();
	}

	public static function luaopen_os(L:Number):int {
		return _wrap_luaopen_os(L);
	}

	public static function get LUA_STRLIBNAME():String{
		return _wrap_LUA_STRLIBNAME();
	}

	public static function luaopen_string(L:Number):int {
		return _wrap_luaopen_string(L);
	}

	public static function get LUA_UTF8LIBNAME():String{
		return _wrap_LUA_UTF8LIBNAME();
	}

	public static function luaopen_utf8(L:Number):int {
		return _wrap_luaopen_utf8(L);
	}

	public static function get LUA_BITLIBNAME():String{
		return _wrap_LUA_BITLIBNAME();
	}

	public static function luaopen_bit32(L:Number):int {
		return _wrap_luaopen_bit32(L);
	}

	public static function get LUA_MATHLIBNAME():String{
		return _wrap_LUA_MATHLIBNAME();
	}

	public static function luaopen_math(L:Number):int {
		return _wrap_luaopen_math(L);
	}

	public static function get LUA_DBLIBNAME():String{
		return _wrap_LUA_DBLIBNAME();
	}

	public static function luaopen_debug(L:Number):int {
		return _wrap_luaopen_debug(L);
	}

	public static function get LUA_LOADLIBNAME():String{
		return _wrap_LUA_LOADLIBNAME();
	}

	public static function luaopen_package(L:Number):int {
		return _wrap_luaopen_package(L);
	}

	public static function luaL_openlibs(L:Number):void {
		_wrap_luaL_openlibs(L);
	}

	public static function lua_pop(L:Number, n:int):void {
		_wrap_lua_pop(L, n);
	}

	public static function lua_tonumber(L:Number, i:int):Number {
		return _wrap_lua_tonumber(L, i);
	}

	public static function lua_tostring(L:Number, i:int):String {
		return _wrap_lua_tostring(L, i);
	}

	public static function lua_tointeger(L:Number, i:int):int {
		return _wrap_lua_tointeger(L, i);
	}

	public static function lua_newtable(L:Number):void {
		_wrap_lua_newtable(L);
	}

	public static function lua_call(L:Number, n:int, r:int):void {
		_wrap_lua_call(L, n, r);
	}

	public static function lua_pcall(L:Number, n:int, r:int, f:int):int {
		return _wrap_lua_pcall(L, n, r, f);
	}

	public static function luaL_loadfile(L:Number, f:String):int {
		return _wrap_luaL_loadfile(L, f);
	}

	public static function luaL_getmetatable(L:Number, n:String):int {
		return _wrap_luaL_getmetatable(L, n);
	}

	public static function flash_newclassmeta(L:Number, name:String):void {
		_wrap_flash_newclassmeta(L, name);
	}

	public static function flash_pushreference(L:Number, name:String):Number {
		return _wrap_flash_pushreference(L, name);
	}

	public static function flash_newlocalmetafunc(L:Number, name:String):void {
		_wrap_flash_newlocalmetafunc(L, name);
	}

	public static function get LUA_FLASHLIBNAME():String{
		return _wrap_LUA_FLASHLIBNAME();
	}

	public static function luaopen_flash(L:Number):int {
		return _wrap_luaopen_flash(L);
	}

	public static function luaL_open_all_libs(L:Number):void {
		_wrap_luaL_open_all_libs(L);
	}

	public static function luaL_open_min_libs(L:Number):void {
		_wrap_luaL_open_min_libs(L);
	}

}
} /* package */
