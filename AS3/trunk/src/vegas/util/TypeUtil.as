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

// TODO need a full refactoring !!!!!

package vegas.util
{
    
    import vegas.util.ClassUtil;
    
    /**
     * The {@code TypeUtil} utility class is an all-static class with methods for checking and working with the type of the object in AS2.
     * @author eKameleon
     */
    public class TypeUtil
    {
        
       	/**
	     * The type of the 'boolean' objects.
	     */
    	static public const BOOLEAN:String = "boolean" ;
    	
    	/**
	     * The type of the 'date' objects.
	     */
    	static public const DATE:String = "date" ;

    	/**
	     * The type of the 'error' objects.
	     */
    	static public const ERROR:String = "error" ;
    	
    	/**
	     * The type of the 'function' objects.
	     */
    	static public const FUNCTION:String = "function" ;
    	
    	/**
	     * The type of the 'int' objects.
	     */
    	static public const INT:String = "int" ;

    	/**
	     * The type of the 'null' objects.
	     */
    	static public const NULL:String = "null" ;
    	
    	/**
	     * The type of the 'number' objects.
	     */
    	static public const NUMBER:String = "number" ;
    	
    	/**
	     * The type of the 'object' objects.
	     */
    	static public const OBJECT:String = "object" ;

    	/**
	     * The type of the 'string' objects.
	     */
    	static public const STRING:String = "string" ;
    	
    	/**
	     * The type of the 'uint' objects.
	     */
    	static public const UINT:String = "uint" ;
    	
    	/**
	     * The type of the 'undefined' objects.
	     */
    	static public const UNDEFINED:String = "undefined" ;
    	
    	/**
	     * The type of the 'xml' objects.
	     */
    	static public const XML:String = "xml" ; 
        
       	/**
	     * Compares the types of two objects.
	     * @return {@code true} if the two objects are the same primitive type.
	     */
        static public function compare(o1:*, o2:*):Boolean 
        {
		    return typeof(o1) == typeof(o2) ;
    	}
    	
        /**
    	 * Checks if the passed-in object is an explicit instance of the passed-in class.
    	 * @return {@code true} if the passed-in object is an explicit instance of the passed-in class.
    	 */
        static public function isExplicitInstanceOf(o:*, c:*):Boolean 
	    {
		    if (TypeUtil.isPrimitive(o)) 
		    {
    			var tof:String = typeof(o) ;
    			if (c == Function(String)) 
    			{
    			  return (tof == STRING) ;  
    			} 
    			else if (c == Function(Number)) 
    			{
    			    return (tof == NUMBER) ;
    			}
    			else if (c == Function(Boolean))
    			{
    			    return (tof == BOOLEAN) ;  
    			} 
    		} 
    		return o is c ;
    	}
    
	    /**
	     * Checks if the passed-in object is a generic object.
    	 * @return {@code true} if the passed-in object is a generic object.
    	 */
	    static public function isGenericObject( o:* ):Boolean
    	{
		    return o.constructor == Object ;
	    }    
    
    	/**
    	 * Checks if the passed-in object is an instance of the passed-in type.
    	 * @return {@code true} if the passed-in object is an instance of the passed-in type.
    	 */
    	static public function isInstanceOf(o:*, type:*):Boolean 
    	{
    		if (type === Function(Object)) return true ;
    		return (o is type) ;
    	}
    	
    	/**
	     * Checks if the passed-in object is a primitive type.
	     * @return {@code true} if the passed-in object is a primitive type.
	     */
    	static public function isPrimitive(o:*):Boolean 
    	{
      		return (o is String || o is Number || o is Boolean) ;
    	}

    	/**
    	 * Checks if the result of an execution of the typeof method on the passed-in object matches the passed-in type.
    	 * @return {@code true} if the result of an execution of the typeof method on the passed-in object matches the passed-in type.
    	 */
    	static public function isTypeOf(o:*, type:String):Boolean 
    	{
	    	return typeof(o) == type ;
	    }

    	/**
    	 * Checks if the type of the passed-in object matches the passed-in type.
    	 * <p><b>Example :</b>
    	 * {@code
    	 * import vegas.util.TypeUtil ;
    	 * 
    	 * var s1:String = "hello world" ;
    	 * var s2:String = new String("hello world") ;
	     * trace("s1 is string : " + TypeUtil.typesMatch( s1, String )) ; // output : 'true'
    	 * trace("s2 is string : " + TypeUtil.typesMatch( s2, String )) ; // output : 'true'
	     * }
    	 * </p>
	     */
	    static public function typesMatch(o:*, type:*):Boolean 
	    {
		   return o is type ;
    	}

    }
}