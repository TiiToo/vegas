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

/** RectanglePen
	
	AUTHOR
	
		Name : RectanglePen
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2005-05-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		var rec:Rectangle = new Rectangle(target:MovieClip, isNew:Boolean) ;

	PROPERTY SUMMARY
	
		- align:String [R/W]
		
		- round:Number [R/W]
		
		- rotation [R/W]
		
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
		
		- getRound():Number
	
		- getRotation():Number
			
		- getTarget():MovieClip
		
		- initialize(target:MovieClip , bNew:Boolean):Void
		
		- lineStyle(t:Number, lc:Number, la:Number):Void
		
		- lineTo(x:Number, y:Number):Void 
		
		- moveTo(x:Number, y:Number):Void
		
		- run():Void
		
		- setRectangle(p_w:Number, p_h:Number, p_round:Number, p_rotation:Number, p_x:Number, p_y:Number, p_align:String):Void
		
		- setAlign (str:String, noDraw:Boolean):Void
		
		- setRound(n:Number, noDraw:Boolean):Void
		
		- setRotation(n:Number, noDraw:Boolean):Void
		
		- setTarget(target:MovieClip):Void
		
		- toString():String

	INHERIT
	
		AbstractPen > EasyPen > Rectangle

	IMPLEMENT
	
		ICloneable, Pen, IRunnable, Shape, IFormattable

----------  */

import asgard.display.StageAlign ;
import asgard.draw.AbstractPen ;

import asgard.geom.Trigo ;

class asgard.draw.RectanglePen extends AbstractPen {

	// -----o Constructor

	public function RectanglePen(target:MovieClip, isNew:Boolean) {
		initialize(target, isNew) ;
	}

	// -----o Public Properties

	public var h:Number ;
	public var w:Number ;
	public var x:Number ;
	public var y:Number ;
		
	// -----o Public Methods
	
	public function clone() {
		var rec:RectanglePen = new RectanglePen(_target) ;
		rec.setRectangle(w, h, round, rotation, x, y, align) ;
		return rec ;
	}
	
	public function draw(p_w:Number, p_h:Number, p_round:Number, p_rotation:Number, p_x:Number, p_y:Number, p_align:String):Void {
		
		if (arguments.length > 0) setRectangle.apply(this, [].concat(arguments)) ;
		
		_initPos() ;
		
		var nX:Number = _nX ;
		var nY:Number = _nY ;
		var nW:Number = w ;
		var nH:Number = h ;
		
		var nRound:Number = _round ;
		var nRotation:Number = _rotation ;
		
		if (nW < (nRound * 2)) nW = nRound * 2 ;
		if (nH < (nRound * 2)) nH = nRound * 2 ;
		
		var nR:Number = Math.sqrt( ((nW/2) * (nW/2)) + ((nH/2) * (nH/2)) );

		var nRx:Number = Math.sqrt(Math.pow(nW/2, 2) + Math.pow((nH/2) - nRound, 2));
		var nRy:Number = Math.sqrt(Math.pow((nW/2) - nRound, 2) + Math.pow(nH/2, 2));
		
		var nR1Angle:Number = Math.atan( ((nH/2) - nRound) /( nW/2) );
		var nR2Angle:Number = Math.atan( (nH/2) / (nW/2) ) - nR1Angle;
		var nR4Angle:Number = Math.atan( ((nW/2) - nRound) / (nH/2) );
		var nR3Angle:Number = (Math.PI/2) - nR1Angle - nR2Angle - nR4Angle;

		var nCtrlDist:Number = Math.sqrt(2 * Math.pow(nRound, 2)) ;

		var nCtrlX:Number ;
		var nCtrlY:Number ;
		var _nX1:Number ;
		var _nY1:Number ;
		
		nRotation += nR1Angle + nR2Angle + nR3Angle;
		
		_nX1 = _nX + nRy * Math.cos(nRotation);
		_nY1 = _nY + nRy * Math.sin(nRotation);
		moveTo(_nX1, _nY1);
		
		nRotation += 2 * nR4Angle;
		_nX1 = _nX + nRy * Math.cos(nRotation);
		_nY1 = _nY + nRy * Math.sin(nRotation);
		lineTo(_nX1, _nY1);
		
		nRotation += nR3Angle + nR2Angle ;
		_nX1 = _nX + nRx * Math.cos(nRotation) ;
		_nY1 = _nY + nRx * Math.sin(nRotation) ;
		
		if (nRound > 0) {
			nCtrlX = _nX + nR * Math.cos(nRotation - nR2Angle);
			nCtrlY = _nY + nR * Math.sin(nRotation - nR2Angle);
			curveTo(nCtrlX, nCtrlY, _nX1, _nY1);
		}
		
		nRotation += 2 * nR1Angle;
		_nX1 = _nX + nRx * Math.cos(nRotation);
		_nY1 = _nY + nRx * Math.sin(nRotation);
		lineTo(_nX1, _nY1);

		nRotation += nR2Angle + nR3Angle;
		_nX1 = _nX + nRy * Math.cos(nRotation);
		_nY1 = _nY + nRy * Math.sin(nRotation);

		if (nRound > 0) {
			nCtrlX = _nX + nR * Math.cos(nRotation - nR3Angle);
			nCtrlY = _nY + nR * Math.sin(nRotation - nR3Angle);
			curveTo(nCtrlX, nCtrlY, _nX1, _nY1);
		}

		nRotation += 2 * nR4Angle;
		_nX1 = _nX + nRy * Math.cos(nRotation);
		_nY1 = _nY + nRy * Math.sin(nRotation);
		lineTo(_nX1, _nY1);

		nRotation += nR3Angle + nR2Angle;
		_nX1 = _nX + nRx * Math.cos(nRotation);
		_nY1 = _nY + nRx * Math.sin(nRotation);

		if (nRound > 0) {
			nCtrlX = _nX + nR * Math.cos(nRotation - nR2Angle);
			nCtrlY = _nY + nR * Math.sin(nRotation - nR2Angle);
			curveTo(nCtrlX, nCtrlY, _nX1, _nY1);
		}

		nRotation += 2 * nR1Angle;
		_nX1 = _nX + nRx * Math.cos(nRotation);
		_nY1 = _nY + nRx * Math.sin(nRotation);
		lineTo(_nX1, _nY1);

		nRotation += nR3Angle + nR2Angle;
		_nX1 = _nX + nRy * Math.cos(nRotation);
		_nY1 = _nY + nRy * Math.sin(nRotation);
		if (nRound > 0) {
			nCtrlX = _nX + nR * Math.cos(nRotation - nR3Angle);
			nCtrlY = _nY + nR * Math.sin(nRotation - nR3Angle);
			curveTo(nCtrlX, nCtrlY, _nX1, _nY1);
		}
	}

	public function getAlign():String {
		return _align ;
	}
	
	public function getRound():Number {
		return _round ;
	}
	
	public function getRotation():Number {
		return _rotation ;
	}

	public function setRectangle(p_w:Number, p_h:Number, p_rnd:Number, p_rot:Number, p_x:Number, p_y:Number, p_align:String):Void {
		if (p_w != null) w = p_w ;
		if (p_h != null) h = p_h ;
		if (p_x != null) x = p_x ;
		if (p_y != null) y = p_y ;
		if (p_rnd != null) setRound(p_rnd, true) ;
		if (p_rot != null) setRotation(p_rot, true) ;
		if (p_align != null) setAlign(p_align, true) ;
	}

	public function setAlign (str:String, noDraw:Boolean):Void {
		_align = StageAlign.getAlign(str, StageAlign.TOP_RIGHT) ;
		if (!noDraw) draw() ;
	}
	
	public function setRound(n:Number, noDraw:Boolean):Void {
		_round = isNaN(n) ? 0 : n ;
	}

	public function setRotation(n:Number, noDraw:Boolean):Void {
		_rotation = Trigo.degreesToRadians(isNaN(n) ? 0 : n) ;
	}

	// -----o Virtual Properties

	public function get align():String { 
		return getAlign() ;
	}

	public function set align(str:String) {
		setAlign(str) ;
	}
	
	public function get round():Number {
		return getRound() ;
	}
	
	public function set round(n:Number):Void {
		setRound(n) ;
	}
	
	public function get rotation():Number {
		return getRotation() ;
	}
	
	public function set rotation(n:Number):Void {
		setRotation(n) ;
	}
	
	// ----o Private  Properties

	private var _align:String ;
	private var _nX:Number ;
	private var _nY:Number ;
	private var _round:Number ;
	private var _rotation:Number ;
	
	// ----o Private Methods
	
	private function _initPos():Void {
		_nX = isNaN(x) ? 0 : x ;
		_nY = isNaN(y) ? 0 : y ;
		switch (_align) {
			case StageAlign.BOTTOM : // bottom
				_nY -= h/2 ;
				break ;
			case StageAlign.BOTTOM_LEFT : // bottom Left
				_nX += w/2 ;
				_nY -= h/2 ;
				break ;
			case StageAlign.BOTTOM_RIGHT : // bottom Right
				_nX -= w/2 ;
				_nY -= h/2 ;
				break ;
			case StageAlign.LEFT : // left
				_nX += w/2 ;
				break ;
			case StageAlign.RIGHT : // right
				_nX -= w/2 ;
				break ;
			case StageAlign.TOP : // top
				_nY += h/2;
				break ;
			case StageAlign.TOP_LEFT : // top Left
				_nX += w/2;
				_nY += h/2;
				break ;
			case StageAlign.TOP_RIGHT : // top Right
				_nX -= w/2 ;
				_nY += h/2 ;
				break ;
			default : // center
				break ;
		}
	}
	
}