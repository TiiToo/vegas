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

/** URLVariables

	AUTHOR

		Name : URLVariables
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-03-23
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
	 	- decode():Void

		- hashCode():Number

		- toSource():String

		- toString():String
		
	INHERIT
	
		CoreObject → URLVariables
		
	IMPLEMENTS
	
		IFormattable, IHashable, ISerializable

**/

import vegas.core.CoreObject;
import vegas.core.ISerializable;

/**
 * @author eKameleon
 */
 
dynamic class asgard.net.URLVariables extends CoreObject implements ISerializable {
	
	// ----o Constructor
	
	public function URLVariables( source:String ) {
		super() ;
		if (source) decode(source)  ;
	}

	// ----o Public Methods
	
	public function decode(source:String):Void {
		LoadVars.prototype.decode.apply(this, [source]) ;
	}
	
	public function toSource(indent:Number, indentor:String):String {
		return "new URLVariables(" + toString() + ")" ;	
	}
	
	/*override*/ public function toString():String {
		return LoadVars.prototype.toString.call(this) ;
	}

}