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

/* ------- Attribute

	AUTHOR

		Name : Attribute
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2006-01-02
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Define a basic attribute structure.

	PROPERTY SUMMARY

		- dontDelete:Boolean
		
		- dontEnum:Boolean
		
		- readOnly:Boolean

	METHOD SUMMARY
	
		- static getAttribute(obj:Object, property:String):Attribute
		
		- static isDontEnum(obj, property:String):Boolean
		
		- static isDontDelete(obj, property:String):Boolean
		
		- static isReadOnly(obj, property:String):Boolean
		
		- setAttribute(obj:Object, property, attrib, override):Void
		
		- toString():String
		
		- valueOf():Number
	
	IMPLEMENT
	
		IFormattable
	
	THANKS
	
		* SSAS FMS Framework inspiration
		* Zwetan : Core2 AS2 Framework inspiration for refactoring !
		
----------  */

import vegas.core.IFormattable;
import vegas.util.AttributeType;

class vegas.util.Attribute implements IFormattable {

	// ----o Construtor
	
	public function Attribute(dontEnum:Boolean, dontDelete:Boolean, readOnly:Boolean) {
		dontEnum = dontEnum || false ;
        dontDelete = dontDelete || false ;
		readOnly = readOnly || false ;
	}

	// ----o Public Property
	
	public var dontEnum:Boolean ;
	public var dontDelete:Boolean ;
	public var readOnly:Boolean ;

	// ----o Public Methods

    static public function getAttribute(obj:Object, property:String):Attribute {
        var dontEnum:Boolean = Attribute.isDontEnum(obj, property);
        var readOnly:Boolean = Attribute.isReadOnly(obj, property);
        var dontdelete:Boolean = Attribute.isDontDelete(obj, property);
        var attrib:Attribute = new Attribute( dontEnum, dontdelete, readOnly ) ;
        Attribute.setAttribute( obj, property, attrib ) ;
        return attrib ;
	}

    static public function isDontDelete(obj, property:String):Boolean {
        var save = obj[property] ;
		delete obj[property] ;
        if( obj[property] === undefined ) {
            obj[property] = save ;
            return false;
		}
        return true;
	}
	
    static public function isDontEnum(obj, property:String):Boolean {
        return !obj.isPropertyEnumerable(obj) ;
	}
    
    static public function isReadOnly(obj, property:String):Boolean {
        var dummy:String = "__\uFFFC\uFFFD\uFFFC\uFFFD__"; // we use ORC char to prevent string colision
        var save = obj[property] ;
        obj[property] = dummy ;
        if( obj[property] == dummy ) {
            obj[property] = save ;
            return false ;
		}
        return true ;
	}
	
	static public function setAttribute(obj:Object, property, attrib, override):Void {
        if( attrib == null ) attrib = AttributeType.NONE ;
		if( override == null ) override = AttributeType.NONE ;
		if( attrib instanceof Attribute ) attrib = attrib.valueOf() ;
        if( override instanceof Attribute ) override = override.valueOf();
        _global.ASSetPropFlags( obj, property, attrib, override );
    }
    
	public function toString():String {
        var data:Array = [];
        var sep:String = ",";
        if(readOnly) data.push( "readOnly" ) ;
		if(dontDelete) data.push( "dontDelete" ) ;
		if(dontEnum) data.push( "dontEnum" ) ;
        if(data.length == 0) data.push("none") ;
        return "[Attribute : " + data.join( sep ) + "]";
	}
	
	public function valueOf():Number {
        return ((Number(readOnly) << 2) | (Number(dontDelete) << 1) | Number(dontEnum) );
	}
	
	
}