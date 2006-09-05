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
  
		- Nicolas Coevoet <http://niko.informatif.org/> (Documentation)
    
*/

/* BasicColor

	AUTHOR

		Name : ColorHSV
		Package : asgard.colors
		Version : 1.0.0.0
		Date :  2004-11-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/


/**
 * <code>ColorHSV</code> provide static color conversion methods, in Hue Saturation Value color space.
 * {@link http://en.wikipedia.org/wiki/HSV_color_space}
 * @usage 
 * <pre>
 * import asgard.colors.ColorHSV;
 * var o:Object = ColorHSV.rgb2hsv(255, 0, 0);
 * for (var i in o) {
 * 	trace(i+" : "+o[i]);
 * }
 * var oRGB : Object = {r:250,g:0,b:0};
 * var o2 : Object = ColorHSV.hsv2rgb (oRGB, 50, 100);
 * trace ("--")
 * for (var i in o2) {
 * 	trace(i+" : "+o2[i]);
 * }
 * </pre>
 * 
 * @author 		eKameleon
 * @version     1.0.0.0
 * @since       1.0.0.0
 */
class asgard.colors.ColorHSV {
	
	// ----o Constructor
	
	/**
	 * You can't create a ColorHSV instance, only use static methods. 
	 * @private
	 */
	private function ColorHSV() {
		//
	}
	
	//  ------o static public Methods

	/**
	 * hsv2rgb
	 * @since Flash 6
	 * @usage 
	 * <pre>
	 * import asgard.colors.ColorHSV;
	 * var oRGB : Object = {r:250,g:0,b:0};
	 * var o2 : Object = ColorHSV.hsv2rgb (oRGB, 50, 100); // desaturate 50%
	 * for (var i in o2) {
	 * 	trace(i+" : "+o2[i]);
	 * }
	 * </pre>
	 * @param oColor an Object with r,g,b properties ( range from 0 - 255 ), this is the Hue.
	 * @param s a Number represent the Saturation value ( range from 0 - 100 ).
	 * @param v a Number represent the Brightness ( Value ) ( range from 0 - 100 ).
	 * @return an Object with r,g,b properties.
	 */
	static public function hsv2rgb ( oColor, s:Number, v:Number) :Object {
		var tmp:Array = ["r:"+oColor.r,"g:"+oColor.g,"b:"+oColor.b].sort(_fsort) ;
		var order:Array = [ tmp[0].split(':')[0] , tmp[1].split(':')[0] , tmp[2].split(':')[0] ];
		var o:Object = { r:oColor.r , g:oColor.g , b:oColor.b } ;
		o[order[2]] += ( 100 - s ) * 2.55 ;
		o[order[1]] += ( 255 - o[order[1]] ) * ( 100 - s ) / 100 ;
		o[order[0]] *= v / 100 ; 
		o[order[1]] *= v / 100 ; 
		o[order[2]] *= v / 100 ;
		return o ;
	}

	/**
	 * rgb2hsv
	 * @since Flash 6
	 * @usage 
	 * <pre>
	 * import asgard.colors.ColorHSV;
	 * var o:Object = ColorHSV.rgb2hsv(255, 0, 0);
	 * for (var i in o) {
	 * 	if (typeof (o[i]) == "object") {
	 * 		trace(i+" : ");
	 * 		for (var j in o[i]) {
	 * 			trace("	"+j+" : "+o[i][j]);
	 * 		}
	 * 	} else {
	 * 		trace(i+" : "+o[i]);
	 * 	}
	 * }
	 * </pre>
	 * @param r a Number represent red value ( range from 0 - 255 ).
	 * @param g a Number represent red value ( range from 0 - 255 ).
	 * @param b a Number represent red value ( range from 0 - 255 ).
	 * @return an Object with h ( Hue ), s ( Saturation ), v ( Value / Brightness ) properties. h is an Object with r,g,b properties.
	 */
	static public function rgb2hsv ( r:Number, g:Number ,b:Number):Object {
		var temp:Array = ["r:" + r,"g:" + g,"b:"+b].sort(_fsort);
		var order:Array =[ temp[0].split(':')[0] , temp[1].split(':')[0] , temp[2].split(':')[0] ];
		var o:Object= {r:r,g:g,b:b} ;
		var v:Number = o[order[0]] * 100 /255 ;
		o.r *= 100 / v ;
		o.g *= 100 / v ;
		o.b *= 100 / v ;
		var s:Number =  (255 - o[order[2]]) * 100 / 255 ; // saturation
		o[order[1]] = Math.round ( 255* (1 - (255-o[order[1]])/(255-o[order[2]]) ));
		o[order[0]]= 255 ; o[order[2]] = 0 ;
		return( { h:o , s:s<<0 ,v:v<<0} ) ;
	}
	
	//  ------o static private Methods
	
	static private function _fsort ( a:String , b:String ) :Number {
		var val1:Number = Number(a.split(':')[1]);
		var val2:Number = Number(b.split(':')[1]);
		if (val1 > val2) return -1;
		else if (val1 < val2) return 1;
		else return 0;
	}
	
}