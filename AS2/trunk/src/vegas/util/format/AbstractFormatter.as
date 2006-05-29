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

/**	AbstractFormatter

	AUTHOR
	
		Name : AbstractFormatter
		Package : vegas.util.format
		Version : 1.0.0.0
		Date :  2005-11-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTU SUMMARY
	
		- pattern:String [R/W]

	METHOD SUMMARY
	
		- format():String
		
		- getPattern():String
		
		- setPattern( pattern:String ):Void
		
		- toString():String

	INHERIT
	
		CoreObject → AbstractFormatter

	IMPLEMENT
	
		IFormatter, IFormattable, IHashable

**/

import vegas.core.CoreObject;
import vegas.util.factory.PropertyFactory;
import vegas.util.format.IFormatter;

class vegas.util.format.AbstractFormatter extends CoreObject implements IFormatter {

	// ----o Construtor
	
	private function AbstractFormatter(pattern:String) {
		setPattern(pattern) ;
	}
	
	// ----o Public Properties
	
	public var pattern:String ; // [RW]
	
	// ----o Public Methods
	
	public function format():String {
		return null ;
	}
	
	public function getPattern():String {
		return _pattern ;
	}
	
	public function setPattern(pattern:String):Void {
		_pattern = new String(pattern) ;
	}
	
	// ----o Virtual Properties
	
	static private var __PATTERN__:Boolean = PropertyFactory.create(AbstractFormatter, "pattern", true) ;
	
	// ----o Private Properties
	
	private var _pattern:String ; // pattern

}