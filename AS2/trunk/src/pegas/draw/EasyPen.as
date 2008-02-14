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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import pegas.draw.AbstractPen;
import pegas.draw.Align;

/**
 * This pen is the basic tool to draw in a MovieClip reference.
 * @author eKameleon
 */
class pegas.draw.EasyPen extends AbstractPen 
{

	/**
	 * Creates a new EasyPen instance.
	 * @param target The target reference of this pen.
	 * @param isNew This optional flag indicates if the pen must draw the shape in a child movieclip reference or not.
	 */
	public function EasyPen(target:MovieClip, isNew:Boolean) 
	{
		initialize(target, isNew) ;
	}
	
	/**
	 * (read-write) Determinates the align value of the pen.
	 */
	public function get align():Number 
	{
		return getAlign() ;	
	}
	
	/**
	 * @private
	 */
	public function set align(nAlign:Number):Void 
	{
		setAlign(nAlign) ;	
	}

	/**
	 * Indicates if the endFill() method is invoked at the end of the draw method.
	 */
	public var isEndFill:Boolean = true ;

	/**
	 * Returns the align number value of this shape.
	 * @return the align number value of this shape.
	 * @see Align
	 */
	public function getAlign():Number 
	{
		return _align ;
	}
	
	/**
	 * Sets the align number value of this shape.
	 * @see Align
	 */
	public function setAlign ( nAlign:Number , noDraw:Boolean):Void 
	{
		_align = (Align.validate(nAlign)) ? nAlign : Align.TOP_LEFT ;
		if (!noDraw) draw() ;
	}
	
	/**
	 * @private
	 */
	private var _align:Number ;
	
}