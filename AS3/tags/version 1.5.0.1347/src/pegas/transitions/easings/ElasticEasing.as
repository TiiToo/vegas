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
     * The <code class="prettyprint">ElasticEasing</code> class.
     */
    public class ElasticEasing extends LinearEasing
    {
        use namespace hack ;
        
        /**
         * Creates a new ElasticEasing instance.
         * @param mode The mode of the easing equation ("easeOut", "easeIn" or "easeInOut").
         */
        public function ElasticEasing( mode:String = "easeOut" )
        {
            super( mode ) ;
        }
        
        /**
         * The optional a value.
         */
        public var a:Number ;
        
        /**
         * The optional p value.
         */
        public var p:Number ;
        
        /**
         * The "easeIn" singleton of the ElasticEasing class.
         */
        public static const easeIn:ElasticEasing = new ElasticEasing( EasingMode.EASE_IN ) ;
        
        /**
         * The "easeInOut" singleton of the ElasticEasing class.
         */
        public static const easeInOut:ElasticEasing = new ElasticEasing( EasingMode.EASE_IN_OUT ) ;
        
        /**
         * The "easeOut" singleton of the ElasticEasing class.
         */
        public static const easeOut:ElasticEasing = new ElasticEasing( EasingMode.EASE_OUT ) ;
        
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
            if ( t==0 )
            {
                return b ;
            }
            if ( _mode == "easeIn" )
            {
                if ( ( t/=d ) == 1 ) 
                {
                    return b + c ;
                }
                if ( !p ) 
                {
                    p = d * .3 ;
                }
                if (!a || a < Math.abs(c)) 
                { 
                    a = c   ; 
                    s = p/4 ; 
                }
                else 
                {
                    s = p / ( 2 * Math.PI ) * Math.asin ( c / a ) ;
                }
                return -( a * Math.pow( 2 , 10 * (t-=1) ) * Math.sin( ( t * d - s )*( 2 * Math.PI ) / p ) ) + b ;
            }
            else if ( _mode == "easeInOut" )
            {
                if ( ( t /= d/2 ) == 2 ) 
                {
                    return b + c ;
                }
                if (!p)
                {
                    p= d * ( .3 * 1.5 ) ;
                }
                if (!a || a < Math.abs(c)) 
                { 
                    a = c   ;
                    s = p/4 ;
                }
                else 
                {
                    s = p / (2*Math.PI) * Math.asin (c/a) ;
                }
                if (t < 1) 
                {
                    return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
                }
                return a * Math.pow( 2 , -10 * (t-=1) ) * Math.sin( (t*d-s) * ( 2 * Math.PI ) / p ) * .5 + c + b ;
            }
            else
            {
                if ( ( t/=d ) ==1 ) 
                {
                    return b+c ;
                }    
                if (!p) 
                { 
                    p=d*.3;
                }
                if (!a || a < Math.abs(c)) 
                { 
                    a = c   ; 
                    s = p/4 ; 
                }
                else 
                {
                    s = p / (2*Math.PI) * Math.asin(c/a) ;
                }
                return (a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b) ;
            }
        }
        
        /**
         * @private
         */
        private var s:Number ;
    }
}
