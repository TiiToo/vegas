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

/** AbstractPen

	AUTHOR
	
		Name : AbstractPen
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2005-05-12
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
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
		
		- clone()
		
		- curveTo(x1:Number, y1:Number, x2:Number, y2:Number):Void
		
		- draw():Void
		
		- endFill():Void
		
		- getTarget():MovieClip
		
		- initialize( target:MovieClip , bNew:Boolean):Void
		
		- lineStyle(t:Number, lc:Number, la:Number):Void
		
		- lineTo(x:Number, y:Number):Void 
		
		- moveTo(x:Number, y:Number):Void
		
		- run():Void
		
		- setTarget(target:MovieClip):Void
		
		- toString():String

	INHERIT
	
		Object > AbstractPen
	
	IMPLEMENT
	
		ICloneable, IFormattable, IHashCode, IPen, IRunnable, IShape
		
----------  */

import asgard.draw.IPen;

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.IRunnable;
import vegas.util.ConstructorUtil;

class asgard.draw.AbstractPen extends CoreObject implements ICloneable, IPen, IRunnable {

	// -----o Constructor

	private function AbstractPen() {
		//
	}

	// -----o Public Properties
	
	public var la:Number ; // line alpha
	public var lc:Number ; // line color
	public var fa:Number ; // fill alpha	
	public var fc:Number ; // fill color
	public var t:Number ; // thickness

	public var C:Function = MovieClip.prototype.curveTo ;
	public var CL:Function = MovieClip.prototype.clear ;
	public var EF:Function = MovieClip.prototype.endFill ;
	public var F:Function = MovieClip.prototype.beginFill ;
	public var GF:Function = MovieClip.prototype.beginGradientFill ;
	public var L:Function = MovieClip.prototype.lineTo ;
	public var M:Function = MovieClip.prototype.moveTo ;
	public var S:Function = MovieClip.prototype.lineStyle ;

	public var default_la = null ; // line alpha
	public var default_lc:Number = null ; // line color
	public var default_fa:Number = null ; // fill alpha	
	public var default_fc:Number = null ; // fill color
	public var default_t:Number = null ; // thickness

	// -----o Public Methods

	public function beginFill(color:Number, alpha:Number):Void {
		fa = isNaN(alpha) ? default_fc : alpha ;
		fc = isNaN(color) ? default_fa : color ;
		F.apply(_target, [fc, fa]) ;
	}

	public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix):Void {
		GF.apply(_target, arguments) ;
	}

	public function clear():Void {
		CL.apply(_target) ;
	}

	public function clone() {
		return null ;
	}

	public function curveTo(x1:Number, y1:Number, x2:Number, y2:Number):Void {
		C.apply(_target, arguments);
	}	

	public function draw():Void {
		//
	}

	public function endFill():Void {
		EF.apply(_target) ;
	}

	public function getTarget():MovieClip {
		return _target ;
	}

	public function initialize(target:MovieClip, isNew:Boolean):Void {
		if(isNew) {
			var depth:Number = target.getNextHighestDepth() ;
			target = target.createEmptyMovieClip("__child__" + depth, depth) ;
		}
		_target = target ;
	}

	public function lineStyle(thickness:Number, color:Number, alpha:Number):Void {
		t = isNaN(thickness) ? default_t : thickness ;
		lc = isNaN(color) ? default_lc : color ;
		la = isNaN(alpha) ? default_la : alpha ;
		S.apply(_target, [t, lc, la].concat(arguments.slice(3)) ) ;
	}

	public function lineTo(x:Number, y:Number):Void {
		L.apply(_target, arguments);
	}

	public function moveTo(x:Number, y:Number):Void {
		M.apply(_target, arguments);
	}

	public function run():Void {
		draw() ;
	}
	
	public function setTarget(target:MovieClip):Void {
		_target = target ;
	}
	
	public function toString():String {
		var name:String = ConstructorUtil.getName(this) ;
		var m:MovieClip = getTarget() ;
		var txt:String = "[" + name ;
		if (m) txt += ":" + m ;
		txt += "]" ;
		return txt ;
	}

	// -----o Private Properties

	private var _target:MovieClip ;
  
}