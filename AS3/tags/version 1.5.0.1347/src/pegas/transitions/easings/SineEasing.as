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
     * The <code class="prettyprint">SineEasing</code> class.
     */
    public class SineEasing extends LinearEasing
    {
        use namespace hack ;
        
        /**
         * Creates a new SineEasing instance.
         * @param mode The mode of the easing equation ("easeOut", "easeIn" or "easeInOut").
         */
        public function SineEasing( mode:String = "easeOut" )
        {
            super( mode ) ;
        }
        
        /**
         * The "easeIn" singleton of the SineEasing class.
         */
        public static const easeIn:SineEasing = new SineEasing( EasingMode.EASE_IN ) ;
        
        /**
         * The "easeInOut" singleton of the SineEasing class.
         */
        public static const easeInOut:SineEasing = new SineEasing( EasingMode.EASE_IN_OUT ) ;
        
        /**
         * The "easeOut" singleton of the SineEasing class.
         */
        public static const easeOut:SineEasing = new SineEasing( EasingMode.EASE_OUT ) ;
        
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
                return -c * Math.cos( t/d * ( Math.PI/2 ) ) + c + b ;
            }
            else if ( _mode == "easeInOut" )
            {
                return -c/2 * ( Math.cos(Math.PI*t/d) - 1 ) + b ;
            }
            else
            {
                return c * Math.sin( t/d * ( Math.PI/2 ) ) + b ;
            }
        }
    }
}
