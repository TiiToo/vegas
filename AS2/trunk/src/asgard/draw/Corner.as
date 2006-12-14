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

/** Corner
	
	AUTHOR
	
		Name : Corner
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2006-03-28
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION
	
		Cette classe permet de définir sur un Rectangle les coins qui peuvent subir une transformation.
	
	CONSTRUCTOR
	
		new Corner( tl:Boolean , br:Boolean, tr:Boolean, bl:Boolean) ;
		
	PROPERTY SUMMARY
	
		- bl:Boolean [Read Only]
	
		- br:Boolean [Read Only]
	
		- tl:Boolean [Read Only]
	
		- tr:Boolean [Read Only]
	
	METHOD SUMMARY

		- clone()

		- getBl():Boolean

		- getBr():Boolean
		
		- getTl():Boolean
	
		- getTr():Boolean

		- hashCode()
		
		- toString():String

	INHERIT
	
		CoreObject > Corner

	IMPLEMENT
	
		IFormattable, IHashCode

----------  */

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.util.ConstructorUtil;

/**
 * @author eKameleon
 */
class asgard.draw.Corner extends CoreObject implements ICloneable {
	
	// ----o Constructor
	
	public function Corner(tl:Boolean , tr:Boolean, br:Boolean, bl:Boolean) {
		super() ;
		if (tl != null) _tl = tl ;
		if (br!= null) _br = br ;
		if (tr!= null) _tr = tr ;
		if (bl!= null) _bl = bl ;
	}
	
	// ----o Public Properties
	
	// public var tl:Boolean ; // [Read Only]
	// public var tr:Boolean ; // [Read Only]
	// public var bl:Boolean ; // [Read Only]
	// public var br:Boolean ; // [Read Only]
	
	// ----o Public Methods

	public function clone() {
		return new Corner(getTl() , getTr(), getBr(), getBl()) ;	
	}

	public function getBl():Boolean {
		return _bl ;
	}

	public function getBr():Boolean {
		return _br ;
	}
	
	public function getTl():Boolean {
		return _tl ;
	}

	public function getTr():Boolean {
		return _tr ;
	}
	
	public function toSource():String {
		return "new Corner(" + getTl() + "," + getTr() + "," + getBr() + "," + getBl() + ")" ;
	}
	
	public function toString():String {
		return "[" + ConstructorUtil.getName(this) + " tl:" + _tl + ", br:" + _br + ", tr:" + _tr + ", bl:" + _bl + "]" ;
	}

	// ----o Virtual Properties

	public function get bl():Boolean {
		return getBl() ;	
	}
	
	public function get br():Boolean {
		return getBr() ;	
	}

	public function get tl():Boolean {
		return getTl() ;	
	}
	
	public function get tr():Boolean {
		return getTr() ;	
	}
	
	// ----o Public Methods
	
	private var _tl:Boolean = true ;
	private var _tr:Boolean = true ;
	private var _bl:Boolean = true ;
	private var _br:Boolean = true ;
	
}