/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.display.coverflow 
{
    /**
     * This entry register all components of a specified Cover in the coverflow 3D space.
     */
    public class CoverEntry 
    {
        /**
         * Creates a new CoverEntry instance.
         * @param x The x component of the entry.
         * @param z The z component of the entry.
         * @param alpha The alpha component of the entry.
         */
        public function CoverEntry( x:Number = 0 , z:Number = 0 , alpha:Number = 0 )
        {
            this.x     = x ;
            this.z     = z ;
            this.alpha = alpha ;
        }
        
        /**
         * The alpha property of the entry.
         */
        public var alpha:Number ;
        
        /**
         * The x property of the entry.
         */
        public var x:Number ;
        
        /**
         * The z property of the entry.
         */
        public var z:Number ;
    }
}
