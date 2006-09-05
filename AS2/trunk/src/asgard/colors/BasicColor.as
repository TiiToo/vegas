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
  
	- Nicolas Coevoet <http://niko.informatif.org/> (Documentation)

*/

/* BasicColor

	AUTHOR

		Name : BasicColor
		Package : asgard.colors
		Version : 1.0.0.0
		Date :  2004-11-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/

import asgard.colors.ColorUtil;

import vegas.core.HashCode;
import vegas.core.IFormattable;
import vegas.core.IHashable;
import vegas.util.ConstructorUtil;

/**
 * <code>BasicColor</code> extends the Color Object.
 * 
 * @usage <pre>
 * import asgard.colors.BasicColor;
 * var c : BasicColor = new BasicColor (this); // assuming 'this' is a MovieClip;
 * c.setRGB(0xFF9900);
 * </pre>
 * 
 * @author 		Ekameleon
 * @version     1.0.0.0
 * @since       1.0.0.0
 */
class asgard.colors.BasicColor extends Color implements IFormattable, IHashable 
{

	// ----o Constructor

	/**
	 * Creates an instance of a BasicColor.
	 * @since Flash 6
	 * @usage new BasicColor(mc);
	 * @param mc a MovieClip
	 * @return nothing
	 */
	public function BasicColor (mc:MovieClip) { 
		super (mc) ;
		_mc = mc ;
	}

	// ----o Init HashCode
	
	static private var _initHashCode:Boolean = HashCode.initialize(BasicColor.prototype) ;

	// -----o Public Methods

	/**
	 * Return the BasicColor target MovieClip.
	 * @since Flash 6
	 * @usage getTarget();
	 * @return mc a MovieClip
	 */	
	public function getTarget():MovieClip { 
		return _mc ;
	}

	/**
	* This method is overrided !
	* @return a Number
	* @see vegas.core.HashCode
	*/		
	public function hashCode():Number {
		return null ;
	}

	/**
	* Invert color of the MovieClip
	* @example <pre>
	* import asgard.colors.BasicColor;
	* var c : BasicColor = new BasicColor (this);
	* c.invert();
	* </pre>
	* @see asgard.colors.ColorUtil#invert
	*/
	public function invert():Void { 
		ColorUtil.invert(this) ; 
	}

	/**
	* Reset color of the MovieClip
	* @example <pre>
	* import asgard.colors.BasicColor;
	* var c : BasicColor = new BasicColor (this);
	* c.reset();
	* </pre>
	* @see asgard.colors.ColorUtil#reset
	*/
	public function reset():Void { 
		ColorUtil.reset(this) ;
	}

	/**
	* Return current instance name
	* @example <pre>
	* import asgard.colors.BasicColor;
	* var c : BasicColor = new BasicColor (this);
	* trace (c.toString());
	* </pre>
	* @return a String, the current instance string name
	* @see vegas.util.ConstructorUtil#getName
	*/	
	public function toString():String {
		return "[" + ConstructorUtil.getName(this) + "]" ;
	}

	// -----o Private MovieClip

	private var _mc:MovieClip ;

}

