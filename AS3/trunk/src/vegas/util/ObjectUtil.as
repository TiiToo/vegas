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

package vegas.util
{
    
    import flash.utils.ByteArray;
    import vegas.util.Copier ;
    
    /**
     * The {@code ObjectUtil} utility class is an all-static class with methods for working with object.
     * @author eKameleon
     */
    public class ObjectUtil
    {
        
       	/**
	     * Returns the shallow copy of the object.
    	 * @return the shallow copy of the object.
    	 */
        static public function clone(o:Object):Object 
        {
		    return o ;	
        }
        
    	/**
    	 * Returns the deep copy of the object.
    	 * @return the deep copy of the object.
	     */ 
	    static public function copy(o:*):*
        {
			var obj:Object = {} ;
			var prop:String ;
			for (prop in o) 
			{
				if( ! o.hasOwnProperty( prop ) ) 
				{
				  	continue ;
			  	}
			  	else if ( o[prop] == undefined ) 
			  	{
			  		obj[prop] = undefined ;
			  	} 
			  	else if ( o[prop] == null ) 
			  	{
			  		obj[prop] = null ;
				}
				else 
				{
			  		obj[prop] = Copier.copy(obj[prop]) ; 
			  	}
			}
			return obj ;
        }
        
        /**
         * Copy the primitive object passed-in argument.
         */
        static public function copyPrimitive(o:Object):Object
        {
            var buffer:ByteArray = new ByteArray();
            buffer.writeObject(o);
            buffer.position = 0;
            return buffer.readObject();
        }

    	/**
    	 * Returns {@code true} if the passed object is empty of enumerable property.
    	 * @return {@code true} if the passed object is empty of enumerable property.
    	 */
        static public function isEmpty(o:Object):Boolean 
        {
            for (var each:String in o) 
        	{
        	    return false ;	
            }
        	return true ;
        }
        
        /**
         * Returns {@code true} if the specified object is a simple object.
         * @return {@code true} if the specified object is a simple object.
         */ 
		static public function isSimple(value:Object):Boolean 
		{
			
			var tof:String = typeof(value);
        	switch (tof)
        	{
            	case "number":
	            case "string":
    	        case "boolean":
        	    	{
	            	    return true;
            		}
	            case "object":
            		{
    	            	return (value is Date) || (value is Array) ;
    		        }
                default :
					{
	    	            return false 
					}            	
        	}

		}
    
    	/**
	     * Creates a shallow copy of the current Object.
    	 */
	    static public function memberwiseClone( o:* ):Object 
    	{
    	    var obj:Object = {} ;
            for( var prop:String in o ) 
        	{
               	obj[prop] = o[prop];
            }
        	return obj;
        }
	
	    /**
    	 * Converts an object to an equivalent Boolean value.
    	 */
        static public function toBoolean(o:*):Boolean 
        {
        	return (new Boolean( o.valueOf() )).valueOf() ;
        }

    	/**
    	 * Converts an object to an equivalent Number value.
    	 */
    	static public function toNumber(o:*):Number 
	    {
            return (new Number( o.valueOf() )).valueOf() ;
    	}

    	/**
	     * Converts an object to an equivalent Object value.
    	 */
   	    static public function toObject(o:*):Object 
        {
      		return o.valueOf() as Object ;
    	}
    
       /**
        * Returns the string representation of the source of the specified object.
        * @return the string representation of the source of the specified object.
        */	
 	   static public function toSource( ...arguments ):String 
 	   {
 	        var o:Object = arguments[0] ;
 	        var indent:Number = arguments[1] ;
 	        var indentor:String = arguments[2] ;
		    var each:String ;
    		var source:Array = [] ;
    		if (isNaN(indent)) indent ++ ;
    		for (each in o) 
    		{
    			if ( o.hasOwnProperty(each) ) 
    			{
    				if (o[each] === undefined) source.push( each + ":" + "undefined") ;
    				else if (o[each] === null) source.push( each + ":" + "null") ;
    				else source.push( each + ":" + Serializer.toSource(o[each], indent, indentor) ) ;
    			}
    		}
    		if (isNaN(indent)) return "{" + source.join(",") + "}" ;
    		if (indentor == null) indentor = "    " ;
    		if(isNaN(indent)) indent = 0;
    		var decal:String = "\n" + ArrayUtil.initialize( indent, indentor ).join( "" ) ;
    		return decal + "{" + decal + source.join( "," + decal ) + decal + "}" ;
        }
        
    }
}