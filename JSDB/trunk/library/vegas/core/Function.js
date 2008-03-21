/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

require("vegas.core.Object") ;

/**
 * This function apply an inherit of the current constructor with the constructor passed in argument.
 * <p><b>Example :</b></p>
 * {@code
 * 
 * ConstructorA = function (a) 
 * {
 *     this.a = a ;
 * }
 * 
 * ConstructorA.prototype.methodA = function () 
 * {
 *     trace ("methodA") ;
 * }
 * 
 * ConstructorA.prototype.toString = function () 
 * {
 *     return "{" + this.a + "}" ;
 * }
 * 
 * ConstructorB = function (a, b) 
 * {
 *     this.__constructor__.call(this, a) ; // super
 *     this.b = b ;
 * }
 * 
 * proto = ConstructorB.extend(ConstructorA) ;
 * 
 * ConstructorB.prototype.toString = function () 
 * {
 *     return "{" + this.a + "," + this.b + "}" ;
 * }
 * 
 * }
 * @param superConstructor the function to extend the current constructor.
 * @return the prototype of the constructor.
 * @author eKameleon
 */
Function.prototype.extend = function ( superConstructor ) 
{
	if ( typeof(superConstructor) == "function" ) 
	{
		this.prototype.__proto__ = superConstructor.prototype ;
		this.prototype.__constructor__ = superConstructor ;
	}
	return this.prototype ;
}

/**
 * Returns the string representation of the object.
 * @return the string representation of the object.
 */
Function.prototype.toString = function () 
{
	return "[Type Function]" ;
}

Function.prototype.dontEnumAllProperties() ;