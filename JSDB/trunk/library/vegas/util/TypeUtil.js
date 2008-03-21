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

/**
 * The {@code TypeUtil} utility class is an all-static class with methods for checking and working with the type of the object in AS2.
 * @author eKameleon
 */
if (vegas.util.TypeUtil == undefined) 
{

	/**
	 * Creates the TypeUtil singleton.
	 */
	vegas.util.TypeUtil = {}

	/**
	 * The type of the 'boolean' objects.
	 */
	vegas.util.TypeUtil.BOOLEAN = "boolean" ;

	/**
	 * The type of the 'date' objects.
	 */
	vegas.util.TypeUtil.DATE = "date" ;

	/**
	 * The type of the 'error' objects.
	 */
	vegas.util.TypeUtil.ERROR = "error" ;
	
	/**
	 * The type of the 'function' objects.
	 */
	vegas.util.TypeUtil.FUNCTION = "function" ;

	/**
	 * The type of the 'null' objects.
	 */
	vegas.util.TypeUtil.NULL = "null" ;

	/**
	 * The type of the 'number' objects.
	 */
	vegas.util.TypeUtil.NUMBER = "number" ;

	/**
	 * The type of the 'object' objects.
	 */
	vegas.util.TypeUtil.OBJECT = "object" ;

	/**
	 * The type of the 'string' objects.
	 */
	vegas.util.TypeUtil.STRING = "string" ;

	/**
	 * The type of the 'undefined' objects.
	 */
	vegas.util.TypeUtil.UNDEFINED = "undefined" ;

	/**
	 * Compares the types of two objects.
	 * @return {@code true} if the two objects are the same primitive type.
	 */
	vegas.util.TypeUtil.compare = function(o1, o2) /*Boolean*/ 
	{
		return typeof(o1) == typeof(o2) ;
	}

	/**
	 * Checks if the passed-in object is an explicit instance of the passed-in class.
	 * @return {@code true} if the passed-in object is an explicit instance of the passed-in class.
	 */
	vegas.util.TypeUtil.isExplicitInstanceOf = function (o, c/*Function*/) /*Boolean*/ 
	{
		if (vegas.util.TypeUtil.isPrimitive(o)) 
		{
			var tof /*String*/ = typeof(o) ;
			if (c == String) return (tof == vegas.util.TypeUtil.STRING) ;
			else if (c == Number) return (tof == vegas.util.TypeUtil.NUMBER) ;
			else if (c == Boolean) return (tof == vegas.util.TypeUtil.BOOLEAN) ;
		} 
		return o instanceof c ;
	}

	/**
	 * Checks if the passed-in object is a generic object.
	 * <p><b>Example :</b></p>
	 * {@code
	 * TypeUtil = vegas.util.TypeUtil ;
	 * 
	 * trace( TypeUtil.isGenericObject( {} ) ) ; // true
	 * trace( TypeUtil.isGenericObject( new Object() ) ) ; // true
	 * trace( TypeUtil.isGenericObject( new Date() ) ) ; // false
	 * trace( TypeUtil.isGenericObject( new vegas.core.CoreObject() ) ) ; // false
	 * trace( TypeUtil.isGenericObject( new Number(2) ) ) ; // false
	 * trace( TypeUtil.isGenericObject( 2 ) ) ; // false
	 * }
	 * @return {@code true} if the passed-in object is a generic object.
	 */
	vegas.util.TypeUtil.isGenericObject = function(o) /*Boolean*/
	{
		return o.__proto__ == Object.prototype ;
	}
	
	/**
	 * Checks if the passed-in object is an instance of the passed-in type.
	 * @return {@code true} if the passed-in object is an instance of the passed-in type.
	 */
	vegas.util.TypeUtil.isInstanceOf = function (o, type/*Function*/) /*Boolean*/ 
	{
		if (type === Object) return true ;
		if (type == null) return false ;
		return (o instanceof type) ;
	}

	/**
	 * Checks if the passed-in object is a primitive type.
	 * @return {@code true} if the passed-in object is a primitive type.
	 */
	vegas.util.TypeUtil.isPrimitive = function(o) /*Boolean*/ 
	{
		var TU = vegas.util.TypeUtil ;
		var tof /*String*/ = typeof(o) ;
		return (tof == TU.STRING || tof == TU.NUMBER || tof == TU.BOOLEAN) ;
	}
	
	/**
	 * Checks if the result of an execution of the typeof method on the passed-in object matches the passed-in type.
	 * @return {@code true} if the result of an execution of the typeof method on the passed-in object matches the passed-in type.
	 */
	vegas.util.TypeUtil.isTypeOf = function (o, type /*String*/ ) /*Boolean*/ 
	{
		return typeof(o) == type ;
	}

	/**
	 * Checks if the type of the passed-in object matches the passed-in type.
	 * <p><b>Example :</b>
	 * {@code
	 * TypeUtil = vegas.util.TypeUtil ;
	 * 
	 * var s1 = "hello world" ;
	 * var s2 = new String("hello world") ;
	 * trace("s1 is string : " + TypeUtil.typesMatch( s1, String )) ; // output : 'true'
	 * trace("s2 is string : " + TypeUtil.typesMatch( s2, String )) ; // output : 'true'
	 * }
	 * </p>
	 * @see ConstructorUtil
	 */
	vegas.util.TypeUtil.typesMatch = function (o, type /*Function*/) /*Boolean*/ 
	{
		if (type === Object) 
		{
			return true ;
		}
		if ( vegas.util.TypeUtil.isPrimitive(o) ) 
		{
			var tof /*String*/ = typeof(o) ;
			if (tof == vegas.util.TypeUtil.STRING && (type === String || vegas.util.ConstructorUtil.isSubConstructorOf(type, String))) return true;
			else if (tof == vegas.util.TypeUtil.BOOLEAN && (type === Boolean || vegas.util.ConstructorUtil.isSubConstructorOf(type, Boolean))) return true;
			else if (tof == vegas.util.TypeUtil.NUMBER && (type === Number || vegas.util.ConstructorUtil.isSubConstructorOf(type, Number))) return true;
			else return false;
		}
		else 
		{
			return (vegas.util.TypeUtil.isInstanceOf(o, type));
		}
	}

	/**
	 * Returns the string representation of the constructor function passed in argument.
	 * <p>If the constructor function is a custom class the method use the ConstructorUtil class.</p>
	 * @return the string representation of the type function passed in argument.
	 * @see ConstructorUtil.
	 */
	vegas.util.TypeUtil.toString = function (type /*Function*/ ) /*String*/ 
	{
		if (type === undefined) 
		{
			return "undefined" ;
		}
		if (type === null) 
		{
			return "null" ;
		}
		var instance = vegas.util.ConstructorUtil.createBasicInstance(type) ;
		var path /*String*/  = instance.getConstructorPath() ;
		if ( path != null) 
		{
			return path ;
		}
		else if (type == Array) 
		{
			return "Array" ;
		}
		else if (type == Boolean)
		{ 
			return "Boolean" ;
		}
		else if (type == Date) 
		{
			return "Date" ;
		}
		else if (type == Error) 
		{
			return "Error" ;
		}
		else if (type == Number) 
		{
			return "Number" ;
		}
		else if (type == String) 
		{
			return "String" ;
		}
		else if (type == Function) 
		{
			return "Function" ;
		}
		else 
		{
			return "Object" ;
		}
	}

}