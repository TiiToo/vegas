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

/** CornerRectanglePen
	
	AUTHOR
	
		Name : CornerRectanglePen
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2006-03-28
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		Private
		
	PROPERTY SUMMARY
	
		- align:String [R/W]
		
		- corner:Corner [R/W]
		
		- la:Number
		
			line alpha
		
		- lc:Number
		
			line color
		
		- fa:Number
		
			fill alpha
		
		- fc:Number
		
			fill color
	
		- t:Number
		
			thickness
		
		- C:Function 
		
			curveTo
			
		- CL:Function 
		
			clear
		
		- EF:Function
		
			endFill
			
		- F:Function
		
			beginFill
		
		- GF:Function
		
			GradientFill
		
		- L:Function
		
			lineTo
		
		- M:Function
		
			moveTo
		
		- S:Function
		
			lineStyle
	
	METHOD SUMMARY

		- beginFill(fc:Number, fa:Number):Void
		
		- beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix):Void
		
		- clear():Void
		
		- clone():Rectangle
		
		- curveTo(x1:Number, y1:Number, x2:Number, y2:Number):Void
		
		- draw(p_w:Number, p_h:Number, p_round:Number, p_rotation:Number, p_x:Number, p_y:Number, p_align:String):Void
		
		- endFill():Void
		
		- getAlign():String
		
		- getCorner():Corner
		
		- getRectangle():Rectangle
		
		- getTarget():MovieClip
		
		- initialize(target:MovieClip , bNew:Boolean):Void
		
		- lineStyle(t:Number, lc:Number, la:Number):Void
		
		- lineTo(x:Number, y:Number):Void 
		
		- moveTo(x:Number, y:Number):Void
		
		- run():Void
		
		- setCorner(c:Corner , noDraw:Boolean):Void
		
		- setRectangle(p_w:Number, p_h:Number, p_round:Number, p_rotation:Number, p_x:Number, p_y:Number, p_align:String):Void
		
		- setAlign (str:String, noDraw:Boolean):Void
		
		- setTarget(target:MovieClip):Void
		
		- toString():String

	INHERIT
	
		CoreObject 
			> AbstractPen
				> EasyPen
					> RectanglePen
						> CornerRectangle

	IMPLEMENT
	
		ICloneable, IFormattable, IHashCode, IPen, IRunnable, IShape

**/

import asgard.draw.Corner;
import asgard.draw.RectanglePen;

class asgard.draw.CornerRectanglePen extends RectanglePen {

	// -----o Constructor

	private function CornerRectanglePen(target:MovieClip, isNew:Boolean) {
		super(target, isNew) ;
	}

	// -----o Public Properties

	// public var corner:Corner ; // [R/W]

	// -----o Public Methods

	public function getCorner():Corner {
		return _corner || new Corner() ;
	}
	
	public function setCorner(c:Corner , noDraw:Boolean):Void {
		_corner = c ;
		if (!noDraw) draw() ;
	}
	
	// ----o Virtual Properties
	
	public function get corner():Corner {
		return getCorner() ;
	}
	
	public function set corner(c:Corner):Void {
		setCorner(c) ;
	}
		
	// ----o Private  Properties

	private var _corner:Corner ;
}