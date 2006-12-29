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

import pegas.draw.IPen;

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.IRunnable;
import vegas.util.ConstructorUtil;

/**
 * @author eKameleon
 */
class pegas.draw.AbstractPen extends CoreObject implements ICloneable, IPen, IRunnable 
{

	/**
	 * Creates a new AbstractPen instance. This constructor must be overrides to be used.
	 */
	private function AbstractPen() 
	{
		//
	}

	/**
	 * The line alpha of the shape.
	 */
	public var la:Number ;

	/**
	 * The line color of the shape.
	 */
	public var lc:Number ; // line color

	/**
	 * The fill alpha of the shape.
	 */
	public var fa:Number ;	

	/**
	 * The fill color of the shape.
	 */
	public var fc:Number ;

	/**
	 * The line thickness of the shape.
	 */
	public var t:Number ;

	public var C:Function = MovieClip.prototype.curveTo ;
	
	public var CL:Function = MovieClip.prototype.clear ;
	
	public var EF:Function = MovieClip.prototype.endFill ;
	
	public var F:Function = MovieClip.prototype.beginFill ;
	
	public var GF:Function = MovieClip.prototype.beginGradientFill ;
	
	public var L:Function = MovieClip.prototype.lineTo ;
	
	public var M:Function = MovieClip.prototype.moveTo ;
	
	public var S:Function = MovieClip.prototype.lineStyle ;

	/**
	 * The default line alpha value.
	 */
	public var default_la = null ;
	
	/**
	 * The default line color value.
	 */
	public var default_lc:Number = null ;

	/**
	 * The default fill alpha value.
	 */	
	public var default_fa:Number = null ;	
	
	/**
	 * The default fill color value.
	 */
	public var default_fc:Number = null ; // fill color

	/**
	 * The default thickness value.
	 */
	public var default_t:Number = null ; // thickness

	public function beginFill(color:Number, alpha:Number):Void 
	{
		fa = isNaN(alpha) ? default_fc : alpha ;
		fc = isNaN(color) ? default_fa : color ;
		F.apply(_target, [fc, fa]) ;
	}

	public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix):Void 
	{
		GF.apply(_target, arguments) ;
	}

	public function clear():Void 
	{
		CL.apply(_target) ;
	}

	public function clone() 
	{
		return null ;
	}

	public function curveTo(x1:Number, y1:Number, x2:Number, y2:Number):Void 
	{
		C.apply(_target, arguments);
	}	

	public function draw():Void 
	{
		//
	}

	public function endFill():Void 
	{
		EF.apply(_target) ;
	}

	public function getTarget():MovieClip 
	{
		return _target ;
	}

	public function initialize(target:MovieClip, isNew:Boolean):Void 
	{
		if(isNew) 
		{
			var depth:Number = target.getNextHighestDepth() ;
			target = target.createEmptyMovieClip("__child__" + depth, depth) ;
		}
		_target = target ;
	}

	public function lineStyle(thickness:Number, color:Number, alpha:Number):Void 
	{
		t = isNaN(thickness) ? default_t : thickness ;
		lc = isNaN(color) ? default_lc : color ;
		la = isNaN(alpha) ? default_la : alpha ;
		S.apply(_target, [t, lc, la].concat(arguments.slice(3)) ) ;
	}

	public function lineTo(x:Number, y:Number):Void 
	{
		L.apply(_target, arguments);
	}

	public function moveTo(x:Number, y:Number):Void 
	{
		M.apply(_target, arguments);
	}

	/**
	 * Run the draw of the specified pen.
	 */
	public function run():Void 
	{
		draw() ;
	}
	
	/**
	 * Returns the movieclip target of this IPen instance.
	 * @return the movieclip target of this IPen instance.
	 */
	public function setTarget(target:MovieClip):Void 
	{
		_target = target ;
	}
	
	/**
	 * Returns the string representation of this object.
	 * @return the string representation of this object.
	 */
	public function toString():String 
	{
		var name:String = ConstructorUtil.getName(this) ;
		var m:MovieClip = getTarget() ;
		var txt:String = "[" + name ;
		if (m) txt += ":" + m ;
		txt += "]" ;
		return txt ;
	}

	private var _target:MovieClip ;
  
}