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
    import pegas.transitions.easings.Easing;
    
    import system.hack;
    
    /**
     * The Linear easing equation.
     */
    public class LinearEasing implements Easing 
    {
        use namespace hack ;
        
        /**
         * Creates a new LinearEasing instance.
         * @param mode The mode of the easing equation ("easeOut", "easeIn" or "easeInOut").
         */
        public function LinearEasing( mode:String = "easeOut" )
        {
            this.mode = mode ;
        }
        
        /**
         * Determinates the mode of the easing.
         */
        public function get mode():String
        {
            return _mode ;
        }
        
        /**
         * @private
         */
        public function set mode( value:String ):void
        {
            switch( value )
            {
                case EasingMode.EASE_IN     :
                case EasingMode.EASE_IN_OUT :
                {
                    _mode = value ;
                    break ;
                }
                case EasingMode.EASE_OUT :
                default :
                {
                    _mode = EasingMode.EASE_OUT ;
                }
            }
        }
        
        /**
         * Calculates the easing value (override this method)
         * @param t Specifies the current time, between 0 and duration inclusive.
         * @param b Specifies the initial value of the animation property.
         * @param c Specifies the total change in the animation property.
         * @param d Specifies the duration of the motion.
         * @return The value of the interpolated property at the specified time.
         */
        public function ease(t:Number, b:Number, c:Number, d:Number):Number
        {
            return ( ( c * t ) / d ) + b ;
        }
        
        /**
         * @private
         */
        hack var _mode:String ;
    }
}
