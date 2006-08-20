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

/** BasicColor

	AUTHOR

		Name : BasicColor
		Package : asgard.colors
		Version : 1.0.0.0
		Date :  2004-11-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY

		- getTarget() : renvoie l'instance de l'objet controlé par la couleur courante.
		
		- invert() : inverse la couleur de l'objet.
		
		- reset() : réinitialise la couleur d'origine de l'objet.
		
		- toString():String

	INHERIT
	
		Color > BasicColor
		
	IMPLEMENTS
	
		IFormattable, IHashable

*/

import asgard.colors.ColorUtil;

import vegas.core.HashCode;
import vegas.core.IFormattable;
import vegas.core.IHashable;
import vegas.util.ConstructorUtil;

class asgard.colors.BasicColor extends Color implements IFormattable, IHashable {

	// -----o Constructor

	public function BasicColor (mc:MovieClip) { 
		super (mc) ;
		_mc = mc ;
	}

	// ----o Init HashCode
	
	static private var _initHashCode:Boolean = HashCode.initialize(BasicColor.prototype) ;

	// -----o Public Methods

	public function getTarget():MovieClip { 
		return _mc ;
	}
	
	public function hashCode():Number {
		return null ;
	}
	
	public function invert():Void { 
		ColorUtil.invert(this) ; 
	}

	public function reset():Void { 
		ColorUtil.reset(this) ;
	}
	
	public function toString():String {
		return "[" + ConstructorUtil.getName(this) + "]" ;
	}

	// -----o Private MovieClip

	private var _mc:MovieClip ;

}

