/*

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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.colors 
{
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	
	import vegas.core.CoreObject;	

	/**
	 * <code>BasicColor</code> extends the Color Object.
	 * <p>
	 * {@code 
	 * import pegas.colors.BasicColor;
 	 * var c : BasicColor = new BasicColor ( display ); // assuming 'display' is a DisplayObject
	 * c.setRGB(0xFF9900);
	 * }
	 * </p>
	 * @author eKameleon
	 */	
	public class Color extends CoreObject
	{

		/**
		 * Creates an instance of a BasicColor.
		 * <p>{@code new BasicColor(mc);</p>
		 * @param display a DisplayObject reference.
	 	 */
		public function Color( display:DisplayObject )
		{
			this.display = display ;
		}

		/**
		 * A ColorTransform object containing values that universally adjust the colors in the display object.
		 */
		public function get colorTransform():ColorTransform 
		{
			return display.transform.colorTransform ;
		}
		
		/**
		 * @private
		 */
		public function set colorTransform( transform:ColorTransform ):void 
		{
			display.transform.colorTransform = transform ;
		}
		
		/**
		 * The DisplayObject reference of this object.
		 */
		public var display:DisplayObject ;

		/**
		 * (read-write) Indicates the R+G+B combination currently in use by the color object
		 */
		public function get rgb():Number 
		{
			return getRGB() ;
		}
		
		/**
		 * @private
		 */
		public function set rgb( offset:Number ):void 
		{
			setRGB( offset ) ;
		}

		/**
		 * Returns the R+G+B combination currently in use by the color object
		 * @return A number that represents the RGB numeric value for the color specified.
		 */
		public function getRGB():Number 
		{
			return display.transform.colorTransform.color ;
		}
		
		/**
		 * Returns the transform value set by the last setTransform() call.
		 * @return An object whose properties contain the current offset and percentage values for the specified color.
		 */
		public function getTransform():Object 
		{
			var ct:ColorTransform = display.transform.colorTransform ;
			return {ra: ct.redMultiplier*100, rb: ct.redOffset, ga: ct.greenMultiplier*100, gb: ct.greenOffset, ba: ct.blueMultiplier*100, bb: ct.blueOffset, aa:ct.alphaMultiplier*100, ab: ct.alphaOffset};
		}

		/**
	 	 * Inverts the color of the specified Color reference in argument.
	 	 */
		public function invert():void 
		{
			var t:Object = getTransform();
			setTransform 
			( 
				{
					ra : -t.ra , ga : -t.ga , ba : -t.ba ,
					rb : 255 - t.rb , gb : 255 - t.gb , bb : 255 - t.bb 
				} 
			) ;
		}

		/**
		 * Resets the color of the specified Color reference in argument, the MovieClip display the original view since Color transformation.
		 */
		public function reset():void 
		{ 
			setTransform ({ra:100, ga:100, ba:100, rb:0, gb:0, bb:0}) ;
		}	

		/**
		 * Specifies an RGB color for a Color object.
		 * @param offset 0xRRGGBB The hexadecimal or RGB color to be set. RR, GG, and BB each consist of two hexadecimal digits that specify the offset of each color component. The 0x tells the ActionScript compiler that the number is a hexadecimal value.
		 */
		public function setRGB( offset:Number ):void 
		{
			var ct:ColorTransform = new ColorTransform();
			ct.color = offset ;
			display.transform.colorTransform = ct;
		}

		/**
		 * Sets color transform information for a Color object.
		 * The colorTransformObject parameter is a generic object that you create from the new Object constructor. It has parameters specifying the percentage and offset values for the red, green, blue, and alpha (transparency) components of a color, entered in the format 0xRRGGBBAA.
		 * @param transformObject An object created with the new Object constructor. This instance of the Object class must have the following properties that specify color transform values: ra, rb, ga, gb, ba, bb, aa, ab. These properties are explained in the above summary for the setTransform() method. 
		 */
		public function setTransform( transformObject:Object ):void 
		{
			var t:Object = {ra:100, rb:0, ga:100, gb:0, ba:100, bb:0, aa:100, ab:0};
			for (var p:String in transformObject)
			{
				t[p] = transformObject[p];
			}
			var ct:ColorTransform = new ColorTransform( t.ra/100 , t.ga/100 , t.ba/100 , t.aa/100 , t.rb , t.gb, t.bb, t.ab );
			display.transform.colorTransform = ct;
		 }
		
	}

}
