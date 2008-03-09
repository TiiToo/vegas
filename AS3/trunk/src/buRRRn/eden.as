/*
  
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
  	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2007-2008)
	  Use this version only with Vegas AS3 Framework Please.

*/
package buRRRn
{
	import buRRRn.eden.ECMAScript;
	import buRRRn.eden.Serializer;
	
	import system.ISerializable;					

	/**
	 * The main eden serialize/deserialize class.
	 */
	public class eden
	{
		
		/**
		 * Indicates the indentor string representation.
		 */
		public static function get indentor():String
		{
			return _indentor;
		}
		
		/**
		 * @private
		 */
		public static function set indentor( value:String ):void
		{
			_indentor = value;
		}
		
		/**
		 * Indicates the pretty indent value.
		 */
		public static function get prettyIndent():int
		{
			return _prettyIndent;
		}
	
		/**
		 * @private
		 */
		public static function set prettyIndent( value:int ):void
		{
			_prettyIndent = value;
		}

		/**
		 * Indicates the pretty printing value.
		 */
		public static function get prettyPrinting():Boolean
		{
			return _prettyPrinting;
		}

		/**
		 * @private
		 */
		public static function set prettyPrinting( value:Boolean ):void
		{
			_prettyPrinting = value;
		}
		
		/**
		 * Parse a string and interpret the source code to the correct ECMAScript construct.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * "undefined" --> undefined
		 * "0xFF"      --> 255
		 * "{a:1,b:2}" --> {a:1,b:2}
		 * </pre>
		 */
		public static function deserialize( source:String ):*
		{
			return ECMAScript.evaluate( source );
		}

		/**
		 * Serialize the specified value object passed-in argument.
		 */
		public static function serialize( value:* = undefined ):String
		{
			if( value === undefined )
			{
				return "undefined";
			}
            
			if( value === null )
			{
				return "null";
			}
            
			if( value is ISerializable )
			{
				return value.toSource( prettyIndent );
			}
            
			if( value is String )
			{
				return Serializer.emitString( value );
			}
            
			if( value is Boolean )
			{
				return value ? "true" : "false";
			}
            
			if( value is Number )
			{
				return value.toString( );
			}
            
			if( value is Date )
			{
				return Serializer.emitDate( value );
			}
            
			/* TODO:
			- add RegExp serializer
			cf: new RegExp( "abc", "i" );
			- add XML serializer
			cf: new XML( "<data><node>xyz</node></data>" );
			 */
			if( value is Array )
			{
				return Serializer.emitArray( value );
			}
            
			if( value is Object )
			{
				return Serializer.emitObject( value );
			}            
            
			return "<unknown>";
		}

		/**
		 * @private
		 */
		private static var _prettyIndent:int = 0 ;

		/**
		 * @private
		 */
		private static var _prettyPrinting:Boolean = false ;

		/**
		 * @private
		 */
		private static var _indentor:String = "    " ;
	}
}

