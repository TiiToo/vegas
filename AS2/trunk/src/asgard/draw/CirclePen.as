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

/** RectanglePen
	
	AUTHOR
	
		Name : CirclePen
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2005-05-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		var rec:RectanglePen = new CirclePen(target:MovieClip, isNew:Boolean) ;

	PROPERTY SUMMARY
	
		- align:String [R/W]
		
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
		
		- draw(x:Number, y:Number, width:Number, height:Number):Void
		
		- endFill():Void
		
		- getAlign():String
		
		- getTarget():MovieClip
		
		- initialize(target:MovieClip , bNew:Boolean):Void
		
		- lineStyle(t:Number, lc:Number, la:Number):Void
		
		- lineTo(x:Number, y:Number):Void 
		
		- moveTo(x:Number, y:Number):Void
		
		- run():Void
		
		- setAlign (str:String, noDraw:Boolean):Void
		
		- setPen(x:Number, y:Number, width:Number, height:Number):Void
 
		- setTarget(target:MovieClip):Void
		
		- toString():String

	INHERIT
	
		CoreObject > AbstractPen > EasyPen > CirclePen

	IMPLEMENT
	
		ICloneable, IFormattable, IHashCode, IPen, IRunnable, IShape

**/

import asgard.display.Align;
import asgard.draw.EasyPen;

/**
 * @author eKameleon
 */
class asgard.draw.CirclePen extends EasyPen {
	
	// ----o Constructor
	
	public function CirclePen(target : MovieClip, isNew : Boolean) 
	{
		super(target, isNew);
	}
	
	// ----o Constants
	
	static public var THETA:Number = Math.PI/4;
	
	// ----o Public Properties
	
	public var radius:Number ;
	public var x:Number ;
	public var y:Number ;
	
	// ----o Public Methods
	
	public function clone()
	{
		var pen:CirclePen = new CirclePen(getTarget()) ;
		pen.setPen(x, y, radius) ;
		return pen ;
	}
	
	public function draw(px:Number, py:Number, pradius:Number, palign:Number):Void
	{
		
		if (arguments.length > 0) 
		{
			setPen(px, py, pradius, palign) ;
		}
		
		var xrCtrl:Number = radius / Math.cos( THETA / 2 );
		var yrCtrl:Number = radius / Math.cos( THETA / 2 );
		
		var angle:Number = 0 ;
		var angleMid:Number ;
		
		var cx:Number ;
		var cy:Number ;
		
		moveTo( x + radius , y ) ;
		
		for (var i:Number = 0; i<8; i++) 
		{
			// increment our angles
			angle += THETA ;
			angleMid = angle - ( THETA / 2 );
			// calculate our control point
			cx = x + Math.cos(angleMid) * xrCtrl;
			cy = y + Math.sin(angleMid) * yrCtrl;
			
			px = x + Math.cos(angle) * this.radius ;
			py = y + Math.sin(angle) * this.radius ;
			
			curveTo(cx, cy, px, py) ;
		}
		
		if (isEndFill) endFill() ;	
		
	}

	public function setPen(nX:Number, nY:Number, nRadius:Number, nAlign:Number):Void
	{
		
		if (!isNaN(nAlign)) setAlign(nAlign, true) ;
		
		radius = isNaN(nRadius) ? 0 : nRadius ;
				
		x = isNaN(nX) ? 0 : nX ;
		y = isNaN(nY) ? 0 : nY ;
		
		var a:Number = getAlign() ;
		
		if (a == Align.CENTER) 
		{
			
		}
		else if (a == Align.BOTTOM) 
		{
			this.y -= radius ;
		}
		else if (a == Align.BOTTOM_LEFT) 
		{
			this.x += radius ;
			this.y -= radius ;
		}
		else if (a == Align.BOTTOM_RIGHT) 
		{
			this.x -= radius ;
			this.y -= radius ;
		}
		else if (a == Align.LEFT) 
		{
			this.x += radius ;
		}
		else if (a ==  Align.RIGHT) 
		{
			this.x -= radius ;
		}
		else if (a == Align.TOP) 
		{
			this.y += radius ;
		}
		else if (a == Align.TOP_RIGHT) 
		{
			this.x -= radius ;
			this.y += radius ;
		}
		else // TOP_LEFT
		{
			this.x += radius ;
			this.y += radius ;
		}
		
	}

}