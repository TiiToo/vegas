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

/**	StringFormatter

	AUTHOR
	
		Name : StringFormatter
		Package : vegas.string
		Version : 1.0.0.0
		Date :  2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Replaces the pattern item in a specified String with the text 
		equivalent of the value of a specified Object instance.

	USAGE
	
		var f:StringFormatter = new StringFormatter() ;
		f.pattern = "Brad's dog has {0,-4:_} fleas." ;
		var result:String = f.format(42) ;
		trace (">> " + result) ;

		f.pattern = "Brad's dog has {0,6:#} fleas.";
		var result:String = f.format(41) ;
		trace (">> " + result) ;

		f.pattern = "Brad's dog has {0,-8} fleas." ;
		var result:String = f.format(12) ;
		trace (">> " + result) ;

		f.pattern = "{3} {2} {1} {0}" ;
		var result:String = f.format("a", "b", "c", "d") ;
		trace (">> " + result) ;

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
	
		CoreObject → AbstractFormatter → StringFormatter

	IMPLEMENT
	
		IFormattable, IFormatter, IHashable, ISerializable

*/

package vegas.string
{
	
	import vegas.util.AbstractFormatter;
	import vegas.util.StringUtil ;
	
	public class StringFormatter extends AbstractFormatter
	{
		
		// ----o Constructor
		
		public function StringFormatter( pattern:String )
		{
			super(pattern)
		}
		
		// ----o Public Methods
		
		override public function format(...arguments:Array):String 
		{
			return StringUtil.format.apply(null, [pattern].concat(arguments)) ; 
		}
		
	}
}