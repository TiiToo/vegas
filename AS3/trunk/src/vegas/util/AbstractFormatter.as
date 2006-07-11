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

/* AbstractFormatter

	AUTHOR
	
		Name : AbstractFormatter
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- pattern:String [R/W]

	METHOD SUMMARY

		- clone():*
		
		- copy():*

		- format(...arguments:Array):String

		- hashCode():Number
		
		- toSource(indent : Number, indentor : String):String
		
		- toString():String

	INHERIT
	
		CoreObject → AbstractFormatter

	IMPLEMENT
	
		IFormatter, IFormattable, IHashable, ISerializable

**/

package vegas.util
{

	import vegas.core.CoreObject;
	import vegas.core.ICloneable ;
	import vegas.core.ICopyable ;
	import vegas.core.IFormatter;
	import vegas.util.Serializer 
	import flash.utils.getDefinitionByName;

	public class AbstractFormatter extends CoreObject implements ICloneable, ICopyable, IFormatter
	{
		
		// ----o Constructor
		
		public function AbstractFormatter( pattern:String )
		{
			_pattern = pattern
		}
		
		// ----o Public Methods
		
		public function clone():*
		{
			var clazz:* = getDefinitionByName( ClassUtil.getPath(this) ) ;
			return new clazz( pattern)  ;
		}

		public function copy():*
		{
			var clazz:* = getDefinitionByName(ClassUtil.getPath(this)) ;
			return new clazz( pattern.valueOf() ) ;
		}

		public function format(...arguments:Array):String 
		{
			return null ; // override this method
		}
			
		override public function toSource(...arguments:Array):String
		{
			return "new " + ClassUtil.getPath(this) + "(" + Serializer.toSource(pattern) + ")" ;
		}
		
		// ----o Virtual Properties
		
		public function get pattern():String 
		{
			return _pattern ;
		}
	
		public function set pattern(pattern:String):void 
		{
			this._pattern = pattern ;
		}
		
		// ----o Private Properties	
		
		private var _pattern:String ; // pattern
		
	}
}