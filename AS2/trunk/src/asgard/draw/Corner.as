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

/** Corner
	
	AUTHOR
	
		Name : Corner
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2006-03-28
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		new Corner( tl:Boolean , br:Boolean, tr:Boolean, bl:Boolean) ;
		
	PROPERTY SUMMARY
	
	METHOD SUMMARY

		- hashCode()
		
		- toString():String

	INHERIT
	
		CoreObject > Corner

	IMPLEMENT
	
		IFormattable, IHashCode

----------  */

import vegas.core.CoreObject;
import vegas.util.ConstructorUtil;
import vegas.util.factory.PropertyFactory;

/**
 * @author eKameleon
 */
class asgard.draw.Corner extends CoreObject {
	
	// ----o Constructor
	
	public function Corner(tl:Boolean , br:Boolean, tr:Boolean, bl:Boolean) {
		super() ;
		if (tl != null) _tl = tl ;
		if (br!= null) _br = br ;
		if (tr!= null) _tr = tr ;
		if (bl!= null) _bl = bl ;
	}
	
	// ----o Public Properties
	
	public var tl:Boolean ; // [Read Only]
	public var tr:Boolean ; // [Read Only]
	public var bl:Boolean ; // [Read Only]
	public var br:Boolean ; // [Read Only]
	
	// ----o Public Methods

	public function getBl():Boolean {
		return _bl || true ;
	}

	public function getBr():Boolean {
		return _br || true ;
	}
	
	public function getTl():Boolean {
		return _tl || true ;
	}

	public function getTr():Boolean {
		return _tr || true ;
	}
	
	public function toString():String {
		return "[" + ConstructorUtil.getName(this) + " tl:" + _tl + ", br:" + _br + ", tr:" + _tr + ", bl:" + _bl + "]" ;
	}

	// ----o Virtual Properties

	static private var __BL__:Boolean = PropertyFactory.create(Corner, "bl", true, true) ;
	static private var __BR__:Boolean = PropertyFactory.create(Corner, "bt", true, true) ;
	static private var __TL__:Boolean = PropertyFactory.create(Corner, "tl", true, true) ;
	static private var __TR__:Boolean = PropertyFactory.create(Corner, "tr", true, true) ;
	
	// ----o Public Methods
	
	private var _tl:Boolean = true ;
	private var _tr:Boolean = true ;
	private var _bl:Boolean = true ;
	private var _br:Boolean = true ;
	

}