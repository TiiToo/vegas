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
    import system.hack;
    
    /**
     * The <code class="prettyprint">CubicEasing</code> class.
     */
    public class CubicEasing extends LinearEasing
    {
        use namespace hack ;
        
        /**
         * Creates a new CubicEasing instance.
         * @param mode The mode of the easing equation ("easeOut", "easeIn" or "easeInOut").
         */
        public function CubicEasing( mode:String = "easeOut" )
        {
            super( mode ) ;
        }
        
        /**
         * The "easeIn" singleton of the CubicEasing class.
         */
        public static const easeIn:CubicEasing = new CubicEasing( EasingMode.EASE_IN ) ;
        
        /**
         * The "easeInOut" singleton of the CubicEasing class.
         */
        public static const easeInOut:CubicEasing = new CubicEasing( EasingMode.EASE_IN_OUT ) ;
        
        /**
         * The "easeOut" singleton of the CubicEasing class.
         */
        public static const easeOut:CubicEasing = new CubicEasing( EasingMode.EASE_OUT ) ;
        
        /**
         * Calculates the easing value. 
         * @param t Specifies the current time, between 0 and duration inclusive.
         * @param b Specifies the initial value of the animation property.
         * @param c Specifies the total change in the animation property.
         * @param d Specifies the duration of the motion.
         * @return The value of the interpolated property at the specified time.
         */
        public override function ease( t:Number, b:Number, c:Number, d:Number ):Number 
        {
            if ( _mode == "easeIn" )
            {
                return c * (t/=d) * t * t + b ;
            }
            else if ( _mode == "easeInOut" )
            {
                if ((t/=d/2) < 1) 
                {
                    return c/2 * t* t* t + b ;
                }
                return c/2 * ( (t-=2) * t * t + 2 ) + b ;
            }
            else
            {
                return c * ( ( t = t/d-1 ) * t * t + 1 ) + b ;
            }
        }
    }
}
