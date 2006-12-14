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

/** Canvas

	AUTHOR
	
		Name : Canvas
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2005-12-19
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		var draw:Draw = new Draw(target:MovieClip, data:Array, isNew:Boolean) ;
	
	PROPERTY SUMMARY
	
		+ data:Object [R/W]
		
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
		
		+ curvesToLines():Void
		
		- draw():Void
		
		- endFill():Void
		
		- getTarget():MovieClip
	
		+ getData():Array

		+ static process(target:MovieClip, draw:Draw):Void		
		
		+ removeTransform():Void
		
		- initialize( target:MovieClip , bNew:Boolean):Void
		
		- lineStyle(t:Number, lc:Number, la:Number):Void
		
		- lineTo(x:Number, y:Number):Void 
		
		+ linesToCurves():Void
		
		- moveTo(x:Number, y:Number):Void
		
		- run():Void
		
		+ setData(data:Array):Void
		
		- setTarget(target:MovieClip):Void
		
		+ setTransform( transform:Function ):Void
		
		+ size():Number
		
		- toString():String

	IMPLEMENT
	
		ICloneable, IFormattable, IHashCode, IPen, IRunnable, IShape
		
	INHERIT
	
		AbstractPen > AbstractPen > Arc

	IMPLEMENT
	
		ICloneable, IPen, IRunnable, IShape, IFormattable, IHashable
	
	THANKS 
		
		- Peter Hall : http://www.peterjoel.com ASVDrawing Class v1.0
		
----------  */

import asgard.draw.AbstractPen;

class asgard.draw.Canvas extends AbstractPen {

	// -----o Constructor

	public function Canvas(target:MovieClip, data:Array, isNew:Boolean) {
		setData(data) ;
		initialize(target, isNew) ;
	}
	
	// ----o public Properties
	
	// public var data:Array ; // [R/W]

	// ----o Public Methods

	/*override*/ public function clone() {
		return new Canvas(getTarget(), getData()) ;
	}
	
	public function curvesToLines():Void {
		var d:Array = _data ;
		var e:Array ;
		var value:Array ;
		var l:Number = d.length ;
		while (--l > -1) {
			e = d[l];
			value = e[1];
			if( e[0] == "C" ){
				d[l] = ["L",[value[2],value[3]]];
			}
		}
	}
	
	public function getData():Array {
		return _data ;
	}

	public function removeTransform():Void {
		this.C = MovieClip.prototype.curveTo ;
		this.L = MovieClip.prototype.lineTo ;
		this.M = MovieClip.prototype.moveTo ;
	}

	/*override*/ public function draw():Void {
		Canvas.process(_target, this) ;
	}

	public function linesToCurves():Void {
		var i:Number = 0 ;
		var key:String ;
		var value:Array ;
		var e:Array ;
		var d:Array = _data ;
		var len:Number = d.length;
		var ax:Number = 0 ;
		var ay:Number = 0 ;
		while ( i<len ) {
			e = d[i] ;
			key = e[0] ;
			value = e[1] ;
			if( key == "L" )
			
			{
				d[i] = ["C", [(ax+value[0])/2 , (ay+value[1])/2 , value[0], value[1]]] ;
				ax = value[0] ;
				ay = value[1] ;
			} 
			
			else if ( key == "C" )
			
			{
				ax = value[2] ;
				ay = value[3] ;
			}
			
			else if ( key == "M" )
			
			{
				ax = value[0] ;
				ay = value[1] ;
			}
			
			i++ ;
		}
	}

	static public function process( target:MovieClip , draw:Canvas ):Void {
		var t:MovieClip = target ;
		var d:Array = draw.getData() ;
		var len:Number = draw.size() ;
		if (t && len > 0) {
			var c:Array ;
			var i:Number = 0 ;
			while (i < len) {
				c = d[i++] ;
				draw[c[0]].apply(t, c[1]) ;
			}
		}
	}
	
	public function setData(arData:Array):Void {
		_data = arData || [] ;
	}

	public function setTransform( transform:Function ):Void {
		if(typeof transform != "function"){
			removeTransform() ;
		} else {
			this.C = function(cx:Number, cy:Number, ax:Number, ay:Number):Void {
				var cp:Object = transform(cx,cy);
				var ap:Object = transform(ax,ay);
				this.curveTo(cp.x, cp.y, ap.x, ap.y);
			} ;
			this.L = function (x:Number, y:Number):Void {
				var p:Object = transform(x,y);
				this.lineTo(p.x,p.y);
			} ;
			this.M = function(x:Number, y:Number):Void {
				var p:Object = transform(x,y) ;
				this.moveTo(p.x,p.y);
			} ;
		}
	}
	
	public function size():Number {
		return _data.length ;
	}

	// ----o Virtual Properties

	public function get data():Array {
		return getData() ;
	}
	
	public function set data(aData:Array):Void {
		setData(aData) ;	
	}
	
	// ----o Private Properties
	
	private var _data:Array ;
  
}