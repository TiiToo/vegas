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

/* ObjectUtil

	AUTHOR

		Name : ObjectUtil
		Package : vegas.util
		Version : 1.0.0.0
		Date : 2006-01-13
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- static clone(o)
		
		- static copy(o)
			
			Returns a copy by value of this object.
			
			See : ICopyable
			
    	- static isEmpty(o):Boolean

		- static isSimple(value:Object):Boolean

		- static memberwiseClone( o )
			 Creates a shallow copy of the current Object.
		
		- static toBoolean(o):Boolean
		
		- static toNumber(o):Number
		
		- static toObject(o):Object
		
		- static toSource(o):String
			
**/

package vegas.util
{
    
    import flash.utils.ByteArray;
    import vegas.util.Copier ;
    
    public class ObjectUtil
    {
        
        static public function clone(o:Object):Object 
        {
		    return o ;	
        }   

        static public function copy(o:*):*
        {
			var obj:Object = {} ;
			var prop:String ;
			for (prop in o) {
				if( ! o.hasOwnProperty( prop ) ) {
				  	continue ;
			  	} else if ( o[prop] == undefined ) {
			  		obj[prop] = undefined ;
			  	} else if ( o[prop] == null ) {
			  		obj[prop] = null ;
				} else {
			  		obj[prop] = Copier.copy(obj[prop]) ; 
			  	}
			}
			return obj ;
        }
        
        static public function copyPrimitive(o:Object):Object
        {
            var buffer:ByteArray = new ByteArray();
            buffer.writeObject(o);
            buffer.position = 0;
            return buffer.readObject();
        }

        static public function isEmpty(o:Object):Boolean 
        {
            for (var each:String in o) 
        	{
        	    return false ;	
            }
        	return true ;
        }

		static public function isSimple(value:Object):Boolean {
			
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

	    static public function memberwiseClone( o:* ):Object 
    	{
    	    var obj:Object = {} ;
            for( var prop:String in o ) 
        	{
               	obj[prop] = o[prop];
            }
        	return obj;
        }

        static public function toBoolean(o:*):Boolean 
        {
        	return (new Boolean( o.valueOf() )).valueOf() ;
        }

    	static public function toNumber(o:*):Number 
	    {
            return (new Number( o.valueOf() )).valueOf() ;
    	}

   	    static public function toObject(o:*):Object 
        {
      		return Object( o.valueOf() ) ;
    	}
    	
 	   static public function toSource( ...arguments ):String 
 	   {
 	        var o:Object = arguments[0] ;
 	        var indent:Number = arguments[1] ;
 	        var indentor:String = arguments[2] ;
		    var each:String ;
    		var source:Array = [] ;
    		if (isNaN(indent)) indent ++ ;
    		for (each in o) {
    			if ( o.hasOwnProperty(each) ) {
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