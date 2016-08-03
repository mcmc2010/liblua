/*
** ADOBE SYSTEMS INCORPORATED
** Copyright 2012 Adobe Systems Incorporated
** All Rights Reserved.
**
** NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
** terms of the Adobe license agreement accompanying it.  If you have received this file from a
** source other than Adobe, then your use, modification, or distribution of it requires the prior
** written permission of Adobe.
*/
#ifdef SWIG

%module LuaLib_Module

%apply long{ unsigned long };
%apply int{ unsigned int };

%{
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include "AS3/AS3.h"

int 	main() 
{ 
	AS3_GoAsync(); 
}

%}

#else //SWIG

#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

#endif
