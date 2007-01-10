﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
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
 * This class provides a skeletal implementation of the {@code IPen} interface, to minimize the effort required to implement this interface.
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
	 * Defines the line alpha of the shape.
	 */
	public var la:Number ;

	/**
	 * Defines the line color of the shape.
	 */
	public var lc:Number ; // line color

	/**
	 * Defines the fill alpha of the shape.
	 */
	public var fa:Number ;	

	/**
	 * Defines the fill color of the shape.
	 */
	public var fc:Number ;

	/**
	 * Defines the line thickness of the shape.
	 */
	public var t:Number ;

	/**
	 * Defines a shortcut reference to used the {@code curveTo} method.
	 */
	public var C:Function = MovieClip.prototype.curveTo ;

	/**
	 * Defines a shortcut reference to used the {@code clear} method.
	 */
	public var CL:Function = MovieClip.prototype.clear ;

	/**
	 * Defines a shortcut reference to used the {@code endFill} method.
	 */
	public var EF:Function = MovieClip.prototype.endFill ;

	/**
	 * Defines a shortcut reference to used the {@code beginFill} method.
	 */
	public var F:Function = MovieClip.prototype.beginFill ;

	/**
	 * Defines a shortcut reference to used the {@code beginGradientFill} method.
	 */
	public var GF:Function = MovieClip.prototype.beginGradientFill ;

	/**
	 * Defines a shortcut reference to used the {@code lineTo} method.
	 */
	public var L:Function = MovieClip.prototype.lineTo ;

	/**
	 * Defines a shortcut reference to used the {@code moveTo} method.
	 */
	public var M:Function = MovieClip.prototype.moveTo ;
	
	/**
	 * Defines a shortcut reference to used the {@code lineStyle} method.
	 */
	public var S:Function = MovieClip.prototype.lineStyle ;

	/**
	 * Defines the default line alpha value.
	 */
	public var default_la = null ;
	
	/**
	 * Defines the default line color value.
	 */
	public var default_lc:Number = null ;

	/**
	 * Defines the default fill alpha value.
	 */	
	public var default_fa:Number = null ;	
	
	/**
	 * Defines the default fill color value.
	 */
	public var default_fc:Number = null ; // fill color

	/**
	 * Defines the default thickness value.
	 */
	public var default_t:Number = null ; // thickness

	/**
	 * Indicates the beginning of a new drawing path. If an open path exists (that is, if the current drawing position does not equal the previous position that is specified in a MovieClip.moveTo() method) and a fill is associated with it, that path is closed with a line and then filled. 
	 * @param color A hexadecimal color value; for example, red is 0xFF0000, blue is 0x0000FF. If this value is not provided or is undefined, a fill is not created.
	 * @param alpha [optional] An integer from 0 to 100 that specifies the alpha value of the fill. If this value is not provided, 100 (solid) is used. If the value is less than 0, Flash uses 0. If the value is greater than 100, Flash uses 100.
	 */
	public function beginFill(color:Number, alpha:Number):Void 
	{
		fa = isNaN(alpha) ? default_fc : alpha ;
		fc = isNaN(color) ? default_fa : color ;
		F.apply(_target, [fc, fa]) ;
	}

	/**
	 * Indicates the beginning of a new drawing path. 
	 * If the first parameter is undefined, or if no parameters are passed, the path has no fill. 
	 * If an open path exists (that is if the current drawing position does not equal the previous position specified in a MovieClip.moveTo() method), and it has a fill associated with it, that path is closed with a line and then filled.
	 * <p>This method fails if any of the following conditions exist:
	 * <ul>
	 * <li>The number of items in the colors, alphas, and ratios parameters are not equal.</li>
	 * <li>The fillType parameter is not "linear" or "radial".</li>
	 * <li>Any of the fields in the object for the matrix parameter are missing or invalid.</li>
	 * </ul>
	 * </p>
	 * @param type Valid values are the string "linear" and the string "radial". You can use the {@code pegas.draw.FillType} enumerate static class to defined the value of this parameter.
	 * @param colors An array of RGB hexadecimal color values you can use in the gradient; for example; red is 0xFF0000, blue is 0x0000FF. You can specify up to 15 colors. For each color, ensure to specify a corresponding value in the alphas and ratios parameters.
	 * @param alphas An array of alpha values for the corresponding colors in the colors array; valid values are 0 to 100. If the value is less than 0, Flash uses 0. If the value is greater than 100, Flash uses 100.
	 * @param ratios An array of color distribution ratios; valid values are 0 to 255. This value defines the percentage of the width where the color is sampled at 100%. Specify a value for each value in the colors parameter.
	 * @param matrix A transformation matrix that can be in any one of three forms :
	 * <p>A matrix object (supported by Flash Player 8 and later only), as defined by the flash.geom.Matrix class. The flash.geom.Matrix class includes a createGradientBox() method, which lets you conveniently set up the matrix for use with the beginGradientFill() method of MovieClip class. Macromedia recommends that you use this form of matrix for Flash Player 8 and later.</p>
	 * <p>You can use the properties a, b, c, d, e, f, g, h, and i, which can be used to describe a 3 x 3 matrix of the following form:
	 * {@code
	 * a b c
	 * d e f
	 * g h i
	 * }
	 * </p>
	 * <p>An object with the following properties: matrixType, x, y, w, h, r.</p>
	 * <p>The properties indicate the following: matrixType is the string "box", x is the horizontal position relative to the registration point of the parent clip for the upper-left corner of the gradient, y is the vertical position relative to the registration point of the parent clip for the upper-left corner of the gradient, w is the width of the gradient, h is the height of the gradient, and r is the rotation in radians of the gradient.</p>
	 * <p><b>Note :</b> For Flash Player 8 and later, Macromedia recommends that you define the matrix parameter in the form of a flash.geom.Matrix object (as described in the first item in this list).</p>
	 */
	public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix):Void 
	{
		GF.apply(_target, arguments) ;
	}

	/**
	 * Removes all the graphics created during runtime by using the movie clip draw methods, including line styles specified with MovieClip.lineStyle(). Shapes and lines that are manually drawn during authoring time (with the Flash drawing tools) are unaffected.
	 */
	public function clear():Void 
	{
		CL.apply(_target) ;
	}

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	public function clone() 
	{
		return null ;
	}

	/**
	 * Draws a curve using the current line style from the current drawing position to (anchorX, anchorY) using the control point that ((controlX, controlY) specifies.
	 * @param x1 An integer that specifies the horizontal position of the control point relative to the registration point of the parent movie clip.
	 * @param y1 An integer that specifies the vertical position of the control point relative to the registration point of the parent movie clip.
	 * @param x2 An integer that specifies the horizontal position of the next anchor point relative to the registration point of the parent movie clip.
	 * @param y2 An integer that specifies the vertical position of the next anchor point relative to the registration point of the parent movie clip.
	 */
	public function curveTo(x1:Number, y1:Number, x2:Number, y2:Number):Void 
	{
		C.apply(_target, arguments);
	}	

	/**
	 * Draws the shape with this pen. Overrides this method.
	 */
	public function draw():Void 
	{
		//
	}

	/**
	 * Applies a fill to the lines and curves that were since the last call to beginFill() or beginGradientFill(). Flash uses the fill that was specified in the previous call to beginFill() or beginGradientFill(). If the current drawing position does not equal the previous position specified in a moveTo() method and a fill is defined, the path is closed with a line and then filled.
	 */
	public function endFill():Void 
	{
		EF.apply(_target) ;
	}

	/**
	 * Returns the movieclip target reference of this pen.
	 * @return the movieclip target reference of this pen.
	 */
	public function getTarget():MovieClip 
	{
		return _target ;
	}

	/**
	 * Initializes the current pen.
	 */
	public function initialize(target:MovieClip, isNew:Boolean):Void 
	{
		if(isNew) 
		{
			var depth:Number = target.getNextHighestDepth() ;
			target = target.createEmptyMovieClip("__child__" + depth, depth) ;
		}
		_target = target ;
	}

	/**
	 * Specifies a line style that Flash uses for subsequent calls to the lineTo() and curveTo() methods until you call the lineStyle() method with different parameters. 
	 * You can call lineStyle() in the middle of drawing a path to specify different styles for different line segments within a path.
	 * <p><b>Note:</b> Calls to the clear() method set the value of line style back to undefined.</p>
	 * @param thickness An integer that indicates the thickness of the line in points; valid values are 0 to 255. If a number is not specified, or if the parameter is undefined, a line is not drawn. If a value of less than 0 is passed, Flash Player uses 0. The value 0 indicates hairline thickness; the maximum thickness is 255. If a value greater than 255 is passed, the Flash interpreter uses 255.
	 * @param color A hexadecimal color value of the line; for example, red is 0xFF0000, blue is 0x0000FF, and so on. If a value isn't indicated, Flash uses 0x000000 (black).
	 * @param alpha An integer that indicates the alpha value of the line's color; valid values are 0 to 100. If a value isn't indicated, Flash uses 100 (solid). If the value is less than 0, Flash uses 0; if the value is greater than 100, Flash uses 100.
	 * @param pixelHinting Added in Flash Player 8. A Boolean value that specifies whether to hint strokes to full pixels. This value affects both the position of anchors of a curve and the line stroke size itself. If a value is not indicated, Flash Player does not use pixel hinting.
	 * @param noScale Added in Flash Player 8. A string that specifies how to scale a stroke. Valid values are as follows:
	 * <p>
	 * <ul>
	 * <li>"normal" - Always scale the thickness (the default).</li>
	 * <li>"none" - Never scale the thickness.</li>
	 * <li>"vertical" - Do not scale thickness if object is scaled vertically only.</li>
	 * <li>"horizontal" - Do not scale thickness if object is scaled horizontally only.</li>
	 * </ul>
	 * </p>
	 * @param capsStyle Added in Flash Player 8. A string that specifies the type of caps at the end of lines. Valid values are: "round", "square", and "none". If a value is not indicated, Flash uses round caps.
	 * @param jointStyle Added in Flash Player 8. A string that specifies the type of joint appearance used at angles. Valid values are: "round", "miter", and "bevel". If a value is not indicated, Flash uses round joints.
	 * @param miterLimit Added in Flash Player 8. A number that indicates the limit at which a miter is cut off. Valid values range from 1 to 255 (and values outside of that range are rounded to 1 or 255). This value is only used if the jointStyle is set to "miter". If a value is not indicated, Flash uses 3. The miterLimit value represents the length that a miter can extend beyond the point at which the lines meet to form a joint. The value expresses a factor of the line thickness. For example, with a miterLimit factor of 2.5 and a thickness of 10 pixels, the miter is cut off at 25 pixels.
	 */
	public function lineStyle(thickness:Number, color:Number, alpha:Number, pixelHinting:Boolean, noScale:String, capsStyle:String, jointStyle:String, miterLimit:Number):Void 
	{
		t = isNaN(thickness) ? default_t : thickness ;
		lc = isNaN(color) ? default_lc : color ;
		la = isNaN(alpha) ? default_la : alpha ;
		S.apply(_target, [t, lc, la].concat(arguments.slice(3)) ) ;
	}

	/**
	 * Draws a line using the current line style from the current drawing position to (x, y); the current drawing position is then set to (x, y). If the movie clip that you are drawing in contains content that was created with the Flash drawing tools, calls to lineTo() are drawn underneath the content. If you call lineTo() before any calls to the moveTo() method, the current drawing position defaults to (0,0). If any of the parameters are missing, this method fails and the current drawing position is not changed.
	 * @param x An integer that indicates the horizontal position relative to the registration point of the parent movie clip.
	 * @param y An integer that indicates the vertical position relative to the registration point of the parent movie clip.
	 */
	public function lineTo(x:Number, y:Number):Void 
	{
		L.apply(_target, arguments);
	}

	/**
	 * Moves the current drawing position to (x, y). If any of the parameters are missing, this method fails and the current drawing position is not changed.
	 * @param x An integer that indicates the horizontal position relative to the registration point of the parent movie clip.
	 * @param y An integer that indicates the vertical position relative to the registration point of the parent movie clip.
	 */
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
	 * Sets the movieclip target of this IPen instance.
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