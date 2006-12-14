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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/* ---------- Version

	AUTHOR

		Name : Version
		Package : asgard.system
		Version : 1.0.0.0
		Date : 2005-06-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION

		Represents a version number for a constructor, an environnement, a platform or other.
		
	DETAIL
		
			1 5 432 10
		0x  F F FFF FF
			| |  |   |
			| |  |   \revision (max 255)
			| |  \build (max 4095)
			| \minor (max 15)
			\major (max 15)
   
		max version number is v15.15.4095.255

	CONSTRUCTOR
	
		new Version( major:Number, minor:Number, build:Number, revision:Number ) ;

   	PROPERY SUMMARY
	
		- build:Number [RW]
		
		- major:Number [R/W]
		
		- minor:Number [R/W]
		
		- revision:Number [R/W]

	METHOD SUMMARY

		- compareTo(o):Number
		
		- equals(o):Boolean
		
		- fromString(str:String):Version
		
		- getBuild():Number
		
		- getMajor():Number
		
		- getMinor():Number
		
		- getRevision():Number 
	
		- setBuild(value:Number):Void
		
		- setMajor(value::Number):Void
		
		- setMinor(value::Number):Void
	
		- setRevision(value::Number):Void
		
		- toSource(indent:Number, indentor:String):String
		
		- toString():String
		
		- valueOf()

	IMPLEMENTS

		IComparable
   
	NOTE
		value ranges are:
			0xF    - 0 ->    15
			0xFF   - 0 ->   255
			0xFFF  - 0 ->  4095
	
			max total value = 0xFFFFFFF
   
	THANKS 
	
		Zwetan : http://www.zwetan.com/
		[ML] Burrrn :: [FMX] coding session 05 (FCNG.buRRRn.com)
	
----------  */

import vegas.core.CoreObject;
import vegas.core.IComparable;
import vegas.core.IEquality;
import vegas.core.ISerializable;
import vegas.util.factory.PropertyFactory;
import vegas.util.MathsUtil;


class asgard.system.Version extends CoreObject implements IComparable, IEquality, ISerializable {
	
	// -----o Constructor
	
	public function Version( p_major:Number, p_minor:Number, p_build:Number, p_revision:Number ) {
		major = _checkValue( p_major, 0xF ) ; // max : 15
		minor = _checkValue( p_minor, 0xF ) ; // max : 15
		build = _checkValue( p_build, 0xFFF ) ; // max : 4095
		revision = _checkValue( p_revision, 0xFF ) ;  // max : 255
		_value = major << 24 | minor << 20 | build << 8 | revision ;
	}
	
	// ----o Public Properties
	
	public var build:Number ; // [RW]
	public var major:Number ; // [RW]
	public var minor:Number ; // [RW]
	public var revision:Number ; // [RW]

	// -----o Public Methods
	
	public function compareTo(o):Number {
		if( o == null ) return 1 ;
        if( equals( o )  ) return 0 ;
        else if ( valueOf() > o.valueOf() ) return 1 ; 
		return -1;
    }

	public function equals(o):Boolean {
		if( o == null ) return false ;
        if( !(o instanceof Version) ) return false;
		return( valueOf() == o.valueOf() );
    }

	public function fromString(str:String):Version {
		var args:Array = str.split(".") ;
		var ver:Version  = new Version( 
			parseInt( args[0] ) ,
            parseInt( args[1] ) ,
            parseInt( args[2] ) ,
            parseInt( args[3] ) 
		) ;
		return ver ;
    }

	public function getBuild():Number {
		return( (_value & 0x00FFF00) >> 8 ) ;
    }
	
	
	public function getMajor():Number {
		return( (_value & 0xF000000) >> 24 );
    }
	

	public function getMinor():Number {
		return( (_value & 0x0F00000) >> 20 ) ;
    }

	public function getRevision():Number {
		return( _value & 0x00000FF ) ;
    }

	public function setBuild( value:Number ):Void {
		var n:Number = _checkValue( value, 0xFFF );
		_value = ( (_value & 0xFF000FF) | (n << 8) );
    }

	public function setMajor( value:Number ):Void {
		var n:Number = _checkValue( value, 0xF );
		_value = ( (_value & 0x0FFFFFF) | (n << 24) ) ;
    }

	public function setMinor( value:Number ):Void {
		var n:Number = _checkValue( value, 0xF );
		_value = ( (_value & 0xF0FFFFF) | (n << 20) );
    }

	public function setRevision( value:Number ) {
		var n:Number = _checkValue( value, 0xFF );
		_value = ( (_value & 0xFFFFF00) | n );
    }

	public function toSource(indent:Number, indentor:String):String {
		return "new Version(" + major + "," + minor + "," + build + "," + revision + ")" ;
	}

	public function toString():String {
		return [major, minor, build, revision].join(".") ;
    }

	public function valueOf():Number {
		return _value ;
    }
	
	// -----o Virtual Properties
	
	static private var __BUILD__:Boolean = PropertyFactory.create(Version, "build", true) ;
	static private var __MAJOR__:Boolean = PropertyFactory.create(Version, "major", true) ;
	static private var __MINOR__:Boolean = PropertyFactory.create(Version, "minor", true) ;
	static private var __REVISION__:Boolean = PropertyFactory.create(Version, "revision", true) ;;
	
	// -----o Private Properties
	
	private var _value:Number ;
	
	// -----o Private Methods
	
	private function _checkValue( value:Number, max:Number) {
		return MathsUtil.clamp(value, 0, max) ;
	}

}