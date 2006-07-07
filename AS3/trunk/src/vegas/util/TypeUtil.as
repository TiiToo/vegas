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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** TypeUtil

	AUTHOR

		Name : TypeUtil
		Package : vegas.util
		Version : 1.0.0.0
		Date : 2005-10-29
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTANT SUMMARY
	
		- const BOOLEAN:String
		
		- const COLOR:String
		
		- const DATE:String
		
		- const ERROR:String
		
		- const FUNCTION:String
		
		- const MOVIECLIP:String
		
		- const NULL:String
		
		- const NUMBER:String
		
		- const OBJECT:String
		
		- const STRING:String
		
		- const UNDEFINED:String
		
		- const XML:String
	
	METHOD SUMMARY
	
		- static compare(o1, o2) : Compares the type of 2 objects.
			
			Compares the types of two objects.
			
		- static isExplicitInstanceOf(o, class:Function)
			
			Checks if the passed-in object is an explicit instance of the passed-in class.
			
		- static isInstanceOf(o, type:Function)
			
			Checks if the passed-in object is an instance of the passed-in type.
		
		- static isPrimitive(o)
		
			Checks if the passed-in object is a primitive type.
			
		- static isTypeOf(o, type:String)
		
			Checks if the result of an execution of the typeof method on the passed-in object matches the passed-in type.
			
		- static typesMatch(o, type:Function)
		
			Checks if the type of the passed-in object matches the passed-in type
		
		- static toString(type:Function):String

**/

// TODO revoir complètement cette classe !!!

package vegas.util
{
    
    import vegas.util.ClassUtil;
    
    public class TypeUtil
    {
        
       	// ----o Constants

    	static public const BOOLEAN:String = "boolean" ;
    	static public const COLOR:String = "color" ;
    	static public const DATE:String = "date" ;
    	static public const ERROR:String = "error" ;
    	static public const FUNCTION:String = "function" ;
    	static public const INT:String = "int" ;
    	static public const DISPLAY:String = "display" ;
    	static public const MOVIECLIP:String = "movieclip" ;
    	static public const NULL:String = "null" ;
    	static public const NUMBER:String = "number" ;
    	static public const OBJECT:String = "object" ;
    	static public const STRING:String = "string" ;
    	static public const UINT:String = "uint" ;
    	static public const UNDEFINED:String = "undefined" ;
    	static public const XML:String = "xml" ; 
        
        // ----o Public Methods
        
        static public function compare(o1:*, o2:*):Boolean {
		    return typeof(o1) == typeof(o2) ;
    	}
        
	    static public function isExplicitInstanceOf(o:*, c:*):Boolean {
		    if (TypeUtil.isPrimitive(o)) {
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
    
    	static public function isInstanceOf(o:*, type:*):Boolean 
    	{
    		if (type === Function(Object)) return true ;
    		return (o is type) ;
    	}
    	
    	static public function isPrimitive(o:*):Boolean 
    	{
      		return (o is String || o is Number || o is Boolean) ;
    	}

    	static public function isTypeOf(o:*, type:String):Boolean 
    	{
	    	return typeof(o) == type ;
	    }

	    static public function typesMatch(o:*, type:*):Boolean 
	    {
		   return o is type ;
    	}

    }
}