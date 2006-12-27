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

// TODO create unit tests.

/**
 * 	THANKS : 
 * 	- Robert Penner :: Robert Penner's Programming Macromedia Flash MX
 * 	<http://www.robertpenner.com/profmx>
 * 	<http://www.amazon.com/exec/obidos/ASIN/0072223561/robertpennerc-20>
 */
class pegas.geom.Trigo 
{

	static public function distance (x1, y1, x2, y2) : Number {
		var dx = x2 - x1 ;
		var dy = y2 - y1 ;
		return Math.sqrt (dx * dx + dy * dy ) ;
	}

	static public function distanceP (p1 : Object , p2 : Object ) : Number 
	{
		return distance(p1.x, p1.y, p2.x, p2.y) ;
	}

	static public function degreesToRadians (angle:Number) : Number 
	{
		return angle * (Math.PI / 180) ;
	}

	static public function radiansToDegrees (angle:Number) : Number 
	{
		return angle * (180 / Math.PI) ;
	}

	static public function sinD (angle:Number) : Number 
	{
		return Math.sin (angle * (Math.PI / 180)) ;
	}

	static public function cosD (angle:Number) : Number 
	{
		return Math.cos (angle * (Math.PI / 180)) ;
	}

	static public function tanD (angle:Number) : Number 
	{
		return Math.tan (angle * (Math.PI / 180)) ;
	}

	/**
	 * Tangente inverse
	 */
	static public function atan2D  ( y:Number , x:Number ) : Number {
		return Math.atan2 (y, x) * (180 / Math.PI) ;
	}

	/**
	 * Cosinus inverse
	 */
	static public function acosD (ratio:Number) : Number 
	{
		return Math.acos(ratio) * (180 / Math.PI) ;
	}

	/**
	 * Sinus inverse
	 */
	static public function asin2D (ratio:Number) : Number 
	{
		return Math.asin (ratio) * (180 / Math.PI) ;
	}

	static public function angleOfLine (x1:Number, y1:Number, x2:Number, y2:Number):Number 
	{
		return Trigo.atan2D (y2 - y1, x2 - x1) ;
	}

	// Standardisation d'un angle

	static public function fixAngle (angle:Number):Number 
	{
		if (isNaN(angle)) angle = 0 ;
		angle %= 360 ;
		return (angle < 0) ? angle + 360 : angle ;
	}

	// cartesianToPolar - polarToCartesian

	static public function cartesianToPolar (p:Object) : Object 
	{
		return ( { r : Math.sqrt (p.x * p.x + p.y * p.y) , t : Trigo.atan2D (p.y , p.x) } ) ;
	}

	static public function polarToCartesian (p:Object) : Object 
	{
		return ( { x : p.r * Trigo.cosD (p.t) , y : p.r * Trigo.sinD (p.t) } ) ;
	}

}