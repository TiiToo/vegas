﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2009
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package graphics.transitions.easings 
{
    import system.hack;
    
    /**
     * The <code class="prettyprint">StrongEasing</code> class.
     */
    public class StrongEasing extends LinearEasing
    {
        use namespace hack ;
        
        /**
         * Creates a new StrongEasing instance.
         * @param mode The mode of the easing equation ("easeOut", "easeIn" or "easeInOut").
         */
        public function StrongEasing( mode:String = "easeOut" )
        {
            super( mode ) ;
        }
        
        /**
         * The "easeIn" singleton of the StrongEasing class.
         */
        public static const easeIn:StrongEasing = new StrongEasing( EasingMode.EASE_IN ) ;
        
        /**
         * The "easeInOut" singleton of the StrongEasing class.
         */
        public static const easeInOut:StrongEasing = new StrongEasing( EasingMode.EASE_IN_OUT ) ;
        
        /**
         * The "easeOut" singleton of the StrongEasing class.
         */
        public static const easeOut:StrongEasing = new StrongEasing( EasingMode.EASE_OUT ) ;
        
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
                return ( c * (t/=d) * t * t * t * t ) + b ;
            }
            else if ( _mode == "easeInOut" )
            {
                if ((t/=d/2) < 1) 
                {
                    return ( c/2 * t * t * t * t * t ) + b ;
                }
                return c/2 * ( (t-=2) * t * t * t * t + 2 ) + b ;
            }
            else
            {
                return c * ( ( t=t/d-1) * t * t * t * t + 1 ) + b ;
            }
        }
    }
}
