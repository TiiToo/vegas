
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is core2: ECMAScript core objects 2nd gig. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2003-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
	- eKameleon (vegas@ekameleon.net)
	
		in SSAS version, add global.$GLOBAL_PRIVATE_POLICY property.
		I use this hack in global.GetObjectPath method with FCS(1). 
		
		Protected all private objects if global.$GLOBAL_PRIVATE_POLICY is 'true'.
	
*/

// ----o Init global object

_global = this ;
	
_global.$CORE2_FIXGETYEAR = false;

_global.$CORE2_ERROR_CTOR = false;

_global.$CORE2_FCTNSTRING = true;

_global.$GLOBAL_RESERVED = 
[
	//
] ;

/**
 * ### WARNING - not original Core2 script !!! see contributors !
 * @see global.js : global.GetObjectPath method.
 */
_global.$GLOBAL_PRIVATE_POLICY = true ;


// ---

_introspectGlobal = function() 
{
    for( var o in _global ) 
    {
        if( (o == "_introspectGlobal") | (o == "$GLOBAL_RESERVED") ) 
        {
        	continue ;
        }
        _global.$GLOBAL_RESERVED.push( o );
    }
}

_introspectGlobal() ;

delete _introspectGlobal ;

// ----o load core2 framework

load( "library/buRRRn/core2/_global.js" ) ;
load( "library/buRRRn/core2/Array.js" ) ;
load( "library/buRRRn/core2/Boolean.js" ) ;
load( "library/buRRRn/core2/Date.js" ) ;
load( "library/buRRRn/core2/Error.js" ) ;
load( "library/buRRRn/core2/Function.js" ) ;
load( "library/buRRRn/core2/ICloneable.js" ) ;
load( "library/buRRRn/core2/IComparable.js" ) ;
load( "library/buRRRn/core2/IConvertible.js" ) ;
load( "library/buRRRn/core2/ICopyable.js" ) ;
load( "library/buRRRn/core2/IEquality.js" ) ;
load( "library/buRRRn/core2/IFormattable.js" ) ;
load( "library/buRRRn/core2/ISerializable.js" ) ;
load( "library/buRRRn/core2/NullObject.js" ) ;
load( "library/buRRRn/core2/Number.js" ) ;
load( "library/buRRRn/core2/Object.js" ) ;
load( "library/buRRRn/core2/String.js" ) ;

