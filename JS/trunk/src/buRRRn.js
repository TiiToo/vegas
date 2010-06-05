/*!--
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
    - eKameleon - SSAS version <ekameleon@gmail.com>
  
*/

// ----o Load core2 Library.

load( "./buRRRn/core2.js") ;

// ----o Create buRRRn namespace.

if( !_global.hasOwnProperty( "buRRRn" ) )
{
    /* NameSpace: buRRRn
       This is the folder and namespace
       containing all the libraries and frameworks
       released by buRRRn.
    */
    _global.buRRRn = {};
}

// ----o Load ASTUce Library.

load( "./buRRRn/ASTUce.js") ;

// ----o Load eden Library.

load( "./buRRRn/eden.js") ;