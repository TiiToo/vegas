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

/** Pen [Interface]

	AUTHOR

		Name : Pen
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2005-05-12
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY

		- beginFill(fc:Number, fa:Number):Void
		
		- beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix):Void
		
		- clear():Void
		
		- curveTo(x1:Number, y1:Number, x2:Number, y2:Number):Void
		
		- endFill():Void
		
		- getTarget():MovieClip
		
		- initialize( target:MovieClip , bNew:Boolean):Void
		
		- lineStyle(t:Number, lc:Number, la:Number):Void
		
		- lineTo(x:Number, y:Number):Void 
		
		- moveTo(x:Number, y:Number):Void
		
		- setTarget(target:MovieClip):Void
		
		- toString():String

	INHERIT
	
		Shape

----------  */

import asgard.draw.Shape ;

interface asgard.draw.Pen extends Shape {

	function beginFill(color:Number, alpha:Number):Void ;

	function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix):Void ;

	function clear():Void ;

	function curveTo(x1:Number, y1:Number, x2:Number, y2:Number):Void ;

	function endFill():Void ;

	function getTarget():MovieClip ;

	function initialize( target:MovieClip , bNew:Boolean):Void ;

	function lineStyle(thickness:Number, color:Number, alpha:Number):Void ;

	function lineTo(x:Number, y:Number):Void ;

	function moveTo(x:Number, y:Number):Void ;

	function setTarget(target:MovieClip):Void ;

	function toString():String ;

}