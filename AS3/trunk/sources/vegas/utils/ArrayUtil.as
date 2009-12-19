/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
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

package vegas.utils
{
    /**
     * Array static tool class.
     */
    public class ArrayUtil 
    {
        /**
         * Creates the shallow copy of the Array.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.ArrayUtil ;
         * 
         * var ar1:Array = [ [2, 3, 4] , [5, 6, 7] ] ;
         * var ar2:Array = ArrayUtil.clone(ar1) ;
         * 
         * trace( 'clone : ' + ar1 + " : " + ar2 ) ; // 2,3,4,5,6,7
         * trace( 'ar1 == ar2 : ' + ( ar1 == ar2 ) ) ; // false
         * trace( 'ar1[0] == ar2[0] : ' + ( ar1[0] == ar2[0] ) ) ; // true
         * </pre>
         * @return the shallow copy of the Array.
         */
        public static function clone( ar:Array ):Array 
        {
              return ar.slice() ;
        }
        
        /**
         * Splices an array (removes an element) and returns either the entire array or the removed element.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.ArrayUtil ;
         * 
         * var ar:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
         * trace("+ " + ar);
         * trace( "ArrayUtil.pierce( ar, 1 ) : " + ArrayUtil.pierce( ar, 1 ) ) ;
         * trace("+ " + ar) ;
         * }
         * </pre>
         * @param ar the array.
         * @param index the index of the array element to remove from the array.
         * @param flag a boolean {@code true} to return a new spliced array of false to return the removed element.
         * @return The newly spliced array or the removed element in function of the flag parameter.
         */
        public static function pierce(ar:Array, index:Number, flag:Boolean ):*
        {
            var item:* = ar[index] ;
            ar.splice(index, 1) ;
            return (flag) ? ar : item ;
        }
        
        /**
         * Shuffles an array.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.ArrayUtil ;
         * var ar = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
         * trace("+ " + ar);
         * ArrayUtil.shuffle(ar);
         * trace("+ " + ar) ;
         * }
         * </pre>
         * @return the shuffled array.
         * @see #pierce method.
         */
        public static function shuffle( ar:Array ):Array 
        {
            var tmp:Array = [] ;
            var len:int   = ar.length;
            var index:int = len - 1 ;
            for (var i:int ; i < len; i++) 
            {
                tmp.push( pierce( ar , Math.round(Math.random() * index ) , false ) );
                index-- ;
            }
            while(--len > -1) 
            {
                ar[len] = tmp[len] ;
            }
            return ar ;
        }
    }
}
