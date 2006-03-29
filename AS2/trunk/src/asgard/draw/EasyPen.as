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

/** EasyPen

	AUTHOR
	
		Name : EasyPen
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2005-05-12
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		var pen:Pen = new EasyPen(target:MovieClip, isNew:Boolean) ;
	
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
		
		- endFill():Void
		
		- getAlign():Number
		
		- getTarget():MovieClip
		
		- initialize( target:MovieClip , bNew:Boolean):Void
		
		- lineStyle(t:Number, lc:Number, la:Number):Void
		
		- lineTo(x:Number, y:Number):Void 
		
		- moveTo(x:Number, y:Number):Void
		
		- setAlign(nAlign:Number):Void
		
		- setTarget(target:MovieClip):Void
		
		- toString():String

	INHERIT
	
		CoreObject > AbstractPen > EasyPen
	
	IMPLEMENT
	
		ICloneable, IPen, IRunnable, IShape, IFormattable, IHashable

	SEE ALSO
	
		Align

----------  */

import asgard.display.Align;
import asgard.draw.AbstractPen;

import vegas.util.factory.PropertyFactory;

class asgard.draw.EasyPen extends AbstractPen {

	// -----o Constructor

	public function EasyPen(target:MovieClip, isNew:Boolean) {
		initialize(target, isNew) ;
	}

	// ----o Public Properties

	public var align:Number ; // [R/W]

	// ----o Public Methods

	public function getAlign():Number {
		return _align ;
	}

	public function setAlign ( nAlign:Number , noDraw:Boolean):Void {
		_align = (Align.validate(nAlign)) ? nAlign : Align.TOP_LEFT ;
		if (!noDraw) draw() ;
	}

	// ----o Virtual Properties

	static private var __ALIGN__:Boolean = PropertyFactory.create(EasyPen, "align", true) ;	
	
	// ----o Private Properties
	
	private var _align:Number ;
	
}