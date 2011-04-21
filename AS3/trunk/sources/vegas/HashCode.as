/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon) <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2011
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
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

package vegas
{
    /**
     * Collected methods which allow easy implementation of <code class="prettyprint">hashCode</code>.
     */
    public class HashCode
    {
        /**
         * Compares two Hashable objects.
         * <pre class="prettyprint">
         * var isEquals:Boolean = HashCode.equals(o1, o2) ;
         * </pre>
         * @param   o1 the first value to compare.
         * @param   o2 the second value to compare.
         * @return <code class="prettyprint">true</code> of the two object are equals.  
         */
        public static function equals(o1:*, o2:*):Boolean 
        {
            return HashCode.identify(o1) == HashCode.identify(o2) ;
        }
        
        /**
         * Indenfity the hashcode value of an object.
         */
        public static function identify( o:* ):uint 
        {
            if ( o is Hashable )
            {
                return (o as Hashable).hashCode() ;
            }
            else
            {
                if ( "hashCode" in o && o["hashCode"] is Function )
                {
                    return uint( o["hashCode"]() ) ;
                }
                else
                {
                    return 0 ;
                }
            }
        }
        
        /**
         * Returns the next hashcode value.
         * @return the next hashcode value.
         */
        public static function next():uint 
        {
            return _hash++ ;
        }
        
        /**
         * Returns the string representation of the next hashcode value.
         * @return the string representation of the next hashcode value.
         */
        public static function nextName():String 
        {
            return String( _hash + 1 ) ;
        }
        
        /**
         * The internal hashcode counter.
         */
        private static var _hash:uint = 0 ;
    }
}
