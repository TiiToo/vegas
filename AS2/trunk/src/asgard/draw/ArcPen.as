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

/** ArcPen
	
	AUTHOR
	
		Name : ArcPen
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2005-05-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		var arc:Pen = new Arc(target:MovieClip, isNew:Boolean) ;
	
	CONSTANT SUMMARY
	
		- CHORD
		
		- PIE
	
	PROPERTY SUMMARY
	
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
		
		- clone():Arc
		
		- curveTo(x1:Number, y1:Number, x2:Number, y2:Number):Void
		
		- draw(p_angle:Number, p_startAngle:Number, p_x:Number, p_y:Number, p_align:String):Void
		
		- endFill():Void
		
		- getAlign():String
	
		- getAngle():Number
	
		- getStartAngle():Number
		
		- getTarget():MovieClip

		- init():Void 
	
		- initialize( target:MovieClip , bNew:Boolean):Void
		
		- lineStyle(t:Number, lc:Number, la:Number):Void
		
		- lineTo(x:Number, y:Number):Void 
		
		- moveTo(x:Number, y:Number):Void
		
		- run():Void
		
		- setAlign (s:String):Void
		
		- setAngle(n:Number):Void
		
		- setArc(p_angle:Number, p_startAngle:Number, p_x:Number, p_y:Number, p_align:String):Void
		
		- setStartAngle (n:Number):Void
		
		- setTarget(target:MovieClip):Void
		
		- toString():String

	INHERIT
	
		AbstractPen > EasyPen > Arc

	IMPLEMENT
	
		ICloneable, Pen, IRunnable, Shape, IFormattable, IHashable
	
----------  */

import asgard.display.StageAlign ;
import asgard.draw.AbstractPen ;
import asgard.geom.Trigo ;

class asgard.draw.ArcPen extends AbstractPen {

	// -----o Constructor

	public function ArcPen(target:MovieClip, isNew:Boolean) {
		initialize(target, isNew) ;
	}

	// -----o Constant
	
	static public var CHORD:String = "CHORD" ;
	
	static public var PIE:String = "PIE" ;

	static private var __ASPF__ = _global.ASSetPropFlags(ArcPen, null, 7, 7) ;

	// -----o Public Properties

	public var radius:Number = 100;
	public var x:Number = 0 ;
	public var y:Number = 0 ;
	public var yRadius:Number ;
	public var type:String = "CHORD" ; // CHORD || PIE
	
	// -----o Public Methods
	
	public function clone() {
		var arc:ArcPen = new ArcPen(_target) ;
		arc.radius = radius ;
		arc.x = x ;
		arc.y = y ;
		arc.yRadius = yRadius ;
		arc.type = ArcPen.CHORD ;
		arc.setAlign(_align, true) ;
		arc.setAngle(_angle, true) ;
		arc.setStartAngle(_startAngle, true) ;
		return arc ;
	}
	
	public function draw(p_angle:Number, p_startAngle:Number, p_x:Number, p_y:Number, p_align:String):Void {
		if (arguments.length > 0) setArc.apply(this, [].concat(arguments)) ;
		init() ;
		moveTo(_nX, _nY);
		var ax:Number ;
		var ay:Number ;
		var bx:Number ;
		var by:Number ;
		var cx:Number ;
		var cy:Number ;
		var angleMid:Number ;
		var nR:Number = isNaN(yRadius) ? radius : yRadius ;
		var segs:Number = Math.ceil ( Math.abs(_angle) / 45 ) ;
		var segAngle:Number = _angle / segs ;
		var theta:Number = - Trigo.degreesToRadians(segAngle) ;
		var a:Number = - _startAngle  ;
		if (segs>0) {
			ax = _nX + Math.cos (_startAngle) * radius ;
			ay = _nY + Math.sin (-_startAngle) * nR ;
			if (_angle < 360 && _angle > -360 && type == PIE) lineTo (ax, ay) ;
			moveTo (ax, ay) ;
			for (var i:Number = 0 ; i<segs ; i++) {
				a += theta ;
				angleMid = a - ( theta / 2 ) ;
				bx = _nX + Math.cos ( a ) * radius ;
				by = _nY + Math.sin ( a ) * nR ;
				cx = _nX + Math.cos( angleMid ) * ( radius / Math.cos ( theta / 2 ) ) ;
				cy = _nY + Math.sin( angleMid ) * ( nR / Math.cos( theta / 2 ) ) ;
				curveTo(cx, cy, bx, by) ;
			}
			if(type == PIE) {
				if (_angle < 360 && _angle > -360) lineTo(_nX, _nY);
			} else { // CHORD or other value
				lineTo(ax, ay);
			}
		}
	}

	public function getAlign():String {
		return _align ;
	}
	
	public function getAngle():Number { 
		return _angle ;
	}
	
	public function getStartAngle():Number { 
		return Trigo.radiansToDegrees(_startAngle)  ;
	}

	public function init():Void {
		if (isNaN(x)) x = 0 ;
		if (isNaN(y)) y = 0 ;
		_nX = x ; 
		_nY = y ;
		var nR:Number = (yRadius != undefined) ? yRadius : radius ;
		switch (_align) {
			case StageAlign.TOP : // Top
				_nY += nR ;
				break ;
			case StageAlign.BOTTOM : // Bottom
				_nY -= nR ;
				break ;
			case StageAlign.LEFT : // Left
				_nX += radius ;
				break ;
			case StageAlign.RIGHT : // Right
				_nX -= radius ;
				break ;
			case StageAlign.TOP_LEFT : // Top Left
				_nX += radius ;
				_nY = nR ;
				break ;
			case StageAlign.TOP_RIGHT : // Top Right
				_nX -= radius ;
				_nY = nR ;
				break ;
			case StageAlign.BOTTOM_LEFT : // Bottom Left
				_nX += radius ;
				_nY -=  nR ;
				break ;
			case StageAlign.BOTTOM_RIGHT : // Bottom Right
				_nX -= radius ;
				_nY -= nR ;
				break ;
			default : // Center
				break ;
		}
	}

	public function setAlign (s:String):Void {
		_align = StageAlign.getAlign(s) ;
	}

	public function setAngle(n:Number):Void {
		_angle = Trigo.fixAngle(n) ;
	}

	public function setArc(p_angle:Number, p_startAngle:Number, p_x:Number, p_y:Number, p_align:String):Void {
		if (p_angle != null) setAngle(p_angle, true) ;
		if (p_startAngle != null) setStartAngle(p_startAngle, true) ;
		if (p_x != null) x = p_x ;
		if (p_y != null ) y = p_y ;
		if (p_align != null) setAlign(p_align, true) ;
	}

	public function setStartAngle (n:Number):Void {
		_startAngle = Trigo.degreesToRadians(n) ;
	}

	// -----o Virtual Properties

	public function get align():String { 
		return getAlign() ;
	}
	
	public function set align(s:String):Void { 
		setAlign(s) ;
	}
	
	public function get angle():Number { 
		return getAngle() ;
	}
	
	public function set angle(n:Number):Void { 
		setAngle(n) ;
	}

	public function get startAngle():Number { 
		return getStartAngle() ;
	}

	public function set startAngle(n:Number):Void { 
		setStartAngle(n) ;
	}
   	
	// ----o Private  Properties

	private var _angle:Number = 0 ;
	private var _angleMid:Number ;
	private var _align:String = "" ;
	private var _nX:Number ;
	private var _nY:Number ;
	private var _startAngle:Number = 360 ;
	
	

	
}