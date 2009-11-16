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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package pegas.transitions.easings 
{
    import pegas.transitions.easings.LinearEasing;
    
    import system.hack;
    
    /**
     * The BounceEasing class.
     */
    public class BounceEasing extends LinearEasing 
    {
        use namespace hack ;
        
        /**
         * Creates a new BounceEasing instance.
         * @param mode The mode of the easing equation ("easeOut", "easeIn" or "easeInOut").
         */
        public function BounceEasing(mode:String = "easeOut")
        {
            super( mode ) ; 
        }
        
        /**
         * The "easeIn" singleton of the BounceEasing class.
         */
        public static const easeIn:BounceEasing = new BounceEasing( EasingMode.EASE_IN ) ;
        
        /**
         * The "easeInOut" singleton of the BounceEasing class.
         */
        public static const easeInOut:BounceEasing = new BounceEasing( EasingMode.EASE_IN_OUT ) ;
        
        /**
         * The "easeOut" singleton of the BounceEasing class.
         */
        public static const easeOut:BounceEasing = new BounceEasing( EasingMode.EASE_OUT ) ;
        
        /**
         * Calculates the easing value (override this method)
         * @param t Specifies the current time, between 0 and duration inclusive.
         * @param b Specifies the initial value of the animation property.
         * @param c Specifies the total change in the animation property.
         * @param d Specifies the duration of the motion.
         * @return The value of the interpolated property at the specified time.
         */
        public override function ease(t:Number, b:Number, c:Number, d:Number):Number
        {
            if ( _mode == "easeIn" )
            {
                return c - easeOut.ease( d - t , 0 , c , d ) + b;
            }
            else if ( _mode == "easeInOut" )
            {
                return (t < d/2) ? easeIn.ease(t * 2, 0, c, d) * 0.5 + b : easeOut.ease(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b ;
            }
            else
            {
                if ((t /= d) < (1 / 2.75))
                {
                    return c * (7.5625 * t * t) + b;
                }
                else if (t < (2 / 2.75))
                {
                    return c * (7.5625 * (t -= (1.5 / 2.75)) * t + 0.75) + b ;
                }
                else if (t < (2.5 / 2.75))
                {
                    return c * (7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375) + b ;
                }
                else
                {
                    return c * (7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375) + b ;
                }
            }
        }
    }
}
