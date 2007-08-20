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
    
    import vegas.core.ISerializable;

    public class Serializer
    {
        
	    /**
    	 * Global reserved words in an array.
    	 */
	    static public var GLOBAL_RESERVED:Array = ["_global"] ;
	
    	/**
    	 * Returns {@code true} if the current word if a global word reserved.
    	 */
    	static public function isGlobalReserved( name:String ):Boolean 
	    {
		    var l:Number = GLOBAL_RESERVED.length ;
            while(--l > -1) 
        	{
                if( GLOBAL_RESERVED[l] == name ) return true ;
        	}
            return false;
		}
 
        static public function globalToSource( indent:Number, indentor:String ):String  
	    {
    	
    	    //var target, member;
        	var source:Array = [];
    
    	    if( !isNaN(indent) ) indent++;
    
	        for( var member:String in global ) 
	        {
        	
        	    if( isGlobalReserved( member ) )
                {
                    continue ;
                }
        
			    if( member == "__path__" )
            	{
            	    continue;
            	}
        
        	    if( global.hasOwnProperty( member ) ) 
        	    {
				      
            	    if( global[member] === undefined )
	                {
                	    source.push( member + ":" + "undefined" );
    	                continue;
                	}
	            
                	if( global[member] === null )
	                {
                    	source.push( member + ":" + "null" );
	                    continue;
                	}
	            
            	    source.push( member + ":" + global[member].toSource( indent, indentor ) );
            	}
	        }
    	
	   	 	if( isNaN(indent) )
        	{
	        	return( "{" + source.join( "," ) + "}" );
        	}
		
	    	if( indentor == null )
	        {
        		indentor = "    ";
	        }
		    
	    	if( isNaN(indent) )
	        {
        		indent = 0;
        	}
		    
	    	var decal:String = "\n" + (ArrayUtil.initialize( indent, indentor )).join( "" );
	    	return decal + "{" + decal + source.join( "," + decal ) + decal + "}" ;
	    }
	    
		static public function getSourceOf(o:*, params:Array):String {
		    var path:String = ClassUtil.getPath(o) ;
    		var source:String = "new " + path + "(" ;
    		var l:uint = params.length ;
    		if (l > 0) {
    			var i:uint = 0 ;
    			while (i < l) {
    				source += Serializer.toSource(params[i]) ;
    				i++ ;
    				if (i<l) source += "," ;
    			}
    		}
    		source += ")" ;
    		return source ;
	    }

	    static public function toSource( ...arguments ):String 
	    {
		    
		    var o:* = arguments[0] ;
		    var indent:* = arguments[1] ;
		    var indentor:* = arguments[2] ;
		    
		    if (o === undefined)
		    {
		        return "undefined" ;
		    }
    		if (o === null) 
    		{
    		return "null" ;
    		}
    		if (o is ISerializable) 
    		{
    		    return o.toSource.apply(o, arguments.slice(1)) ;
    		}
    		else if (o is Array) 
    		{
    		    return ArrayUtil.toSource.apply(o, arguments.slice()) ;
    		}
    		else if (o is Boolean) 
    		{
    		    return BooleanUtil.toSource.apply(o, arguments.slice()) ;
    		}
    		else if (o is Date)
    		{
    		    return DateUtil.toSource(o) ;
    		}
    		else if (o is Error) return ErrorUtil.toSource.apply(o, arguments.slice()) ;
    		
    		else if (o is Function) return FunctionUtil.toSource.apply(o, arguments.slice()) ;

    		else if (o as uint) return ("new uint(" + o + ")") ;

    		else if (o as int) return ("new int(" + o + ")") ;
    		
    		else if (o is Number) return NumberUtil.toSource.apply(o, arguments.slice()) ;
    		
    		else if (o is String) return StringUtil.toSource.apply(o, arguments.slice()) ;
    		
    		else if (o is Object) return ObjectUtil.toSource.apply(o, arguments.slice()) ;
	    	
	    	else return "undefined" ;
	    	
	    }    
  
    }
}

