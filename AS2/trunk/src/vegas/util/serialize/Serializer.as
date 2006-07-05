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

/** Serializer

	AUTHOR
	
		Name : Serializer
		Package : vegas.util.serialize
		Version : 0.0.0.0
		Date : 2005-12-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION
	
		  Allows an object to control its own serialization.
	
	METHOD SUMMARY
	
		- static getSourceOf(o, params:Array):String
		
		- static toSource( o, [indent:Number], [indentor:String] ) ;
		
			PARAMETERS
			
				- indent : optional the starting of the indenting
				- indentor : the string value used to do the indentation
		
			RETURN
			
				a string representing the source code of the object.

	NOTE
	
		To add a diffrent syntax formating it should be possible to add a 3rd *formater* argument
		and override the implementation of the method in all core objects.

	THANKS
	
		Zwetan Core2 framework inspired by Mozilla SpiderMonkey.

	TODO : voir si on peut transformer l'objet en objet généric ou en primitif directement ?	
	TODO : voir si il est préférable de gérer une SerializeError ??
	TODO : finir le remplissage des propriétés dans le constructeur de la source

**/

import vegas.core.ISerializable;
import vegas.util.ConstructorUtil;
import vegas.util.serialize.ArraySerializer;
import vegas.util.serialize.BooleanSerializer;
import vegas.util.serialize.DateSerializer;
import vegas.util.serialize.ErrorSerializer;
import vegas.util.serialize.FunctionSerializer;
import vegas.util.serialize.NumberSerializer;
import vegas.util.serialize.ObjectSerializer;
import vegas.util.serialize.StringSerializer;
import vegas.util.TypeUtil;
import vegas.util.ArrayUtil;

class vegas.util.serialize.Serializer {

	// ----o Construtor
	
	private function Serializer() {
		//
	}
	
	// ----o Properties
	
	static public var GLOBAL_RESERVED:Array = ["_global"] ;
	
	// ----o Methods

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
    	
    	var target, member, source;
    	source = [];
    
    	if( indent != null ) indent++;
    
	    for( member in _global ) {
        	
        	if( isGlobalReserved( member ) )
            {
            continue;
            }
        
			if( member == "__path__" )
            	{
            	continue;
            	}
        
        	if( _global.hasOwnProperty( member ) ) {
				      
            	if( _global[member] === undefined )
	                {
                	source.push( member + ":" + "undefined" );
	                continue;
                	}
	            
            	if( _global[member] === null )
	                {
                	source.push( member + ":" + "null" );
	                continue;
                	}
	            
            	source.push( member + ":" + _global[member].toSource( indent, indentor ) );
            	}
	        }
    	
	   	 	if( indent == null )
        		{
	        	return( "{" + source.join( "," ) + "}" );
        		}
		
	    	if( indentor == null )
	        	{
        		indentor = "    ";
	        	}
		    
	    	if(indent == null )
	        	{
        		indent = 0;
        		}
		    
	    	var decal = "\n" + (ArrayUtil.initialize( indent, indentor )).join( "" );
	    	return( decal + "{" + decal + source.join( "," + decal ) + decal + "}" );
	    }

	static public function getSourceOf(o, params:Array):String {
		var path:String = ConstructorUtil.getPath(o) ;
		var source:String = "new " + path + "(" ;
		var l:Number = params.length ;
		if (l > 0) {
			var i:Number = 0 ;
			while (i < l) {
				source += params[i] ;
				i++ ;
				if (i<l) source += "," ;
			}
		}
		source += ")" ;
		return source ;
	}

	static public function toSource( o, indent:Number, indentor:String):String {
		if (o === undefined) return "undefined" ;
		if (o === null) return "null" ;
		if (o instanceof ISerializable) return o.toSource.apply(o, arguments.slice(1)) ;
		else if (TypeUtil.typesMatch(o, Array)) return ArraySerializer.toSource.apply(o, arguments.slice()) ;
		else if (TypeUtil.typesMatch(o, Boolean)) return BooleanSerializer.toSource.apply(o, arguments.slice()) ;
		else if (TypeUtil.typesMatch(o, Date)) return DateSerializer.toSource.apply(o, arguments.slice()) ;
		else if (TypeUtil.typesMatch(o, Error)) return ErrorSerializer.toSource.apply(o, arguments.slice()) ;
		else if (TypeUtil.typesMatch(o, Function)) return FunctionSerializer.toSource.apply(o, arguments.slice()) ;
		else if (TypeUtil.typesMatch(o, Number)) return NumberSerializer.toSource.apply(o, arguments.slice()) ;
		else if (TypeUtil.typesMatch(o, String)) return StringSerializer.toSource.apply(o, arguments.slice()) ;
		else if (typeof(o) === "object") return ObjectSerializer.toSource.apply(o, arguments.slice()) ;
		else return "undefined" ;
	}
	

		
}