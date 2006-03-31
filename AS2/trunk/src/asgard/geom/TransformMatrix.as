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

/** Matrix

	AUTHOR

		Name : TransformMatrix
		Package : asgard.geom
		Version : 1.0.0.0
		Date :  2005-12-20
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Flash8 flash.geom.Matrix compatibilty for FP7
		
		La classe flash.geom.Matrix représente une matrice de transformation qui détermine la façon
		de mapper des points d'un espace de coordonnées à l'autre. 

	CONSTRUCTOR
		
		var m:TransformMatrix = new TransformMatrix(a:Number, b:Number, c:Number, d:Number, tx:Number, ty:Number) ;

	PROPERTY SUMMARY
	
		- a:Number
		
			Dans la première ligne et la première colonne de l'objet Matrix,
			la valeur affectant le positionnement des pixels sur l'axe x lors du redimensionnement ou de la rotation d'une image.
			
		- b:Number

			Dans la première ligne et la deuxième colonne de l'objet Matrix, 
			la valeur affectant le positionnement des pixels sur l'axe y lors de la rotation ou de l'inclinaison d'une image.
		
		- c:Number
		
			Dans la deuxième ligne et la première colonne de l'objet Matrix,
			la valeur affectant le positionnement des pixels sur l'axe x lors de la rotation ou de l'inclinaison d'une image.

		- d:Number
		
			Dans la deuxième ligne et la deuxième colonne de l'objet Matrix, 
			la valeur affectant le positionnement des pixels sur l'axe y lors du redimensionnement ou de la rotation d'une image.
		
		- tx:Number
		
			La distance de translation de chaque point sur l'axe x.
		
		- ty:Number
		
			La distance de translation de chaque point sur l'axe y.
		

	METHOD SUMMARY

		- clone():Matrix
		
		- concat(m:Matrix):Void
		
		- createBox(scaleX:Number, scaleY:Number, rotation:Number, x:Number, y:Number):Void
		
		- createGradientBox(width:Number, height:Number, rotation:Number, x:Number, y:Number):Void
		
		- deltaTransformPoint(p:Point):Point
		
			En partant d'un point dans l'espace de coordonnées de prétransformation, 
			cette méthode renvoie les coordonnées de ce point suite à la transformation.
		
		- equals(o):Boolean
		
		- identity():Void
		
		- rotate( radians:Number ):Void
		
			rotate matrix in radians
		
		- rotateD( degrees:Number ):Void
			
			rotate matrix in degrees
		
		- scale(sx:Number, sy:Number):Void
		
		- transformPoint(p:Point):Point
		
		- translate(dx:Number, dy:Number):Void
		
		- toSource( indent:Number, indentor:String):String
		
		- toString():String

	INHERIT
	
		CoreObject > TransformMatrix

	IMPLEMENT SUMMARY
	
		ICloneable, IEquality, ISerializable, IFormattable
		
---------------*/

import asgard.geom.Point;
import asgard.geom.Trigo;

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.IEquality;
import vegas.core.ISerializable;

class asgard.geom.TransformMatrix extends CoreObject implements ICloneable, IEquality, ISerializable {

	// ----- Constructor
	
	public function TransformMatrix(p_a:Number, p_b:Number, p_c:Number, p_d:Number, p_x:Number, p_y:Number) {
		var l = arguments.length ;
		if (l == 0) {
			identity() ;
		} else {
			a = p_a ;
			b = p_b ;
			c = p_c ;
			d = p_d ;
			tx = p_x ;
			ty = p_y ;
		}
	}

	// ----o Public Properties
	
	public var a:Number ;
	public var b:Number ;
	public var c:Number ;
	public var d:Number ;
	public var tx:Number ;
	public var ty:Number ;
		
	// ----o Public Methods

	public function clone() {
		return new TransformMatrix(a, b, c, d, tx, ty) ;
	}
	
	public function createBox(scaleX:Number, scaleY:Number, rotation:Number, x:Number, y:Number):Void {
		var rr:Number = isNaN(rotation) ? 0 : rotation ;
		var rx:Number = isNaN(x) ? 0 : x ;
		var ry:Number = isNaN(y) ? 0 : y ;
		identity() ;
		rotate(rr) ;
		scale(scaleX, scaleY) ;
		tx = rx ;
		ty = ry ;
	}
	
	public function createGradientBox(width:Number, height:Number, rotation:Number, x:Number, y:Number):Void {
		var rr = isNaN(rotation) ? 0 : rotation ;
		var rx:Number = isNaN(x) ? 0 : x ;
		var ry:Number = isNaN(y) ? 0 : y ;
		createBox((width / 1638.400000) , (height / 1638.400000) , rr, rx + width / 2, ry + height / 2) ;
	}
	
	public function concat(m:TransformMatrix):Void {
		var r_a:Number = a * m.a ;
		var r_d:Number = d * m.d ;
		var r_b:Number = 0 ;
		var r_c:Number = 0 ;
		var r_tx:Number = tx * m.a + m.tx ;
		var r_ty:Number = ty * m.d + m.ty ;
		if (b != 0 || c != 0 || m.b != 0 || m.c != 0) {
			r_a = r_a + b * m.c ;
			r_d = r_d + c * m.b ;
			r_b = r_b + (a * m.b + b * m.d) ;
			r_c = r_c + (c * m.a + d * m.c) ;
			r_tx = r_tx + ty * m.c ;
			r_ty = r_ty + tx * m.b ;
		}
		a = r_a ;
		b = r_b ;
		c = r_c ;
		d = r_d ;
		tx = r_tx ;
		ty = r_ty ;
	}
	
	public function deltaTransformPoint(p:Point):Point {
		return new Point(a * p.x + c * p.y , d * p.y + b * p.x) ;
	}
	
	public function equals(o):Boolean {
		return ( o instanceof TransformMatrix && o.a == a && o.b == b && o.c == c && o.d == d && o.tx == tx && o.ty == ty) ;
	}
		
	public function identity():Void {
		a = d = 1 ;
		b = c = 0 ;
		tx = ty = 0 ;
	}
	
	public function invert():Void {
		if (b == 0 && c == 0) 
		{
			a = 1 / a ;
			d = 1 / d ;
			b = 0 ;
			c = 0 ;
			tx = - a * tx ;
			ty = - d * ty ;
		}
		else 
		{
			var a0:Number = a ;
			var a1:Number = b ;
			var a2:Number = c ;
			var a3:Number = d ;
			var det:Number = a0 * a3 - a1 * a2;
			if (det == 0) identity() ;
			else 
			{
				det = 1 / det ;
				a = a3 * det ;
				b = -a1 * det ;
				c = -a2 * det ;
				d = a0 * det ;
				var p:Point = deltaTransformPoint( new Point(tx, ty) ) ;
				tx = - p.x ;
				ty = - p.y ;
			}
		}
	}
	
	public function rotate( radians:Number ):Void {
		var c:Number = Math.cos(radians);
		var s:Number = Math.sin(radians);
		concat(new TransformMatrix(c, s, -s, c, 0, 0)) ;
	}
	
	public function rotateD( degrees:Number ):Void {
		rotate(Trigo.degreesToRadians(degrees)) ;
	}
	
	public function scale(sx:Number, sy:Number):Void {
		concat(new TransformMatrix(sx, 0, 0, sy, 0, 0));
	}
	
	public function transformPoint(p:Point):Point {
		return new Point( (a * p.x) + (c * p.y) + tx , (d * p.y) + (b * p.x) + ty ) ;
	}
	
	public function translate(dx:Number, dy:Number):Void {
		tx += dx ;
		ty += dy ;
	}
	
	public function toSource( indent:Number, indentor:String):String {
		return "new TransformMatrix(" + a + "," + b + "," + c + "," + d + "," + tx + "," + ty + ")" ;
	}
	
	public function toString():String {
		return "[a:" + a + ",b:" + b + ",c:" + c + ",d:" + d + ",tx:" + tx + ",ty:" + ty +  "]" ;
	}

}