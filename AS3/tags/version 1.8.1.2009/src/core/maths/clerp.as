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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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

package core.maths
{
    /**
     * Circular Lerp is like lerp but handles the wraparound from 0 to 360. 
     * This is useful when interpolating eulerAngles and the object crosses the 0/360 boundary. 
     * The standard Lerp function causes the object to rotate in the wrong direction and looks stupid, clerp() fixes that.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import core.maths.clerp ;
     * trace( clerp( 0 , 180 , 0.5 ) ; // 90
     * </pre>
     * @param amount The amount to interpolate between the two values where 0.0 equal to the first point, 0.1 is very near the first point, 0.5 is half-way in between, etc. 
     * @param start the begining value.
     * @param end The ending value.
     * @return The interpolated value between two numbers at a specific increment.
     */
    public const clerp:Function = function( amount:Number , start:Number, end:Number ):Number 
    {
        var max:int     = 360 ;
        var half:int    = 180 ;
        var diff:Number = end - start ;
        if ( diff < -half ) 
        {
            return start + ( ( max - start ) + end ) * amount ;
        }
        else if ( diff > half )
        {
            return start - ( ( max - end ) + start ) * amount ;
        }
        else
        {
            return start + ( end - start ) * amount ;
        }
    };
}
