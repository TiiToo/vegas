/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.utils
{
    import system.Objects;
    import vegas.core.Copyable;
    
    /**
     * The <code class="prettyprint">Copier</code> utility class is an all-static class with a method to returns a copy representation of an object.
     */
    public class Copier
    {
        /**
         * Returns a deep copy of the specified object passed in argument. You can use a <code class="prettyprint">ICopyable</code> instance or a native object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.data.list.LinkedList ;
         * import vegas.util.Copier ;
         * var list:LinkedList = new LinkedList() ;
         * list.insert("item1") ;
         * list.insert("item2") ;
         * var copy:LinkedList = Copier.copy(list) as LinkedList ; // LinkedList is ICopyable !
         * trace( copy.equals(list) ) ; // true
         * </pre>
         * @return a deep copy of the specified object passed in argument.
         */    
        public static function copy( o:* ):* 
        {
            if (o === undefined) 
            {
                return undefined ;
            }
            if (o === null) 
            {
                return null ;
            }
            if (o is Copyable) 
            {
                return (o as Copyable).copy() ;
            }
            else if (o as Array) 
            {
                return copyArray( o ) ;
            }
            else if (o is Number) 
            {
                return (o as Number).valueOf() ;
            }
            else if (o is String) 
            {
                return (o as String).valueOf() ;
            }
            else if (o as Boolean)
            {
                return Boolean(o) ;
            }
            else if (o is Date) 
            {
                return copyDate( o as Date ) ;
            }
            else if ( o is Function ) 
            {
                return o ;
            }
            else if (o is Object) 
            {
                return ObjectUtil.copy( o ) ;
            }
            else 
            {
                return Objects.copyPrimitive( o ) ;
            }
        }

        /**
         * Creates the deep copy of the specified Array.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.Copier ;
         * 
         * var ar1:Array = [ [2, 3, 4] , [5, 6, 7] ] ;
         * var ar2:Array = Copier.copyArray( ar1 ) ;
         * 
         * trace( 'copy : ' + ar1 + " : " + ar2 ) ; // 2,3,4,5,6,7
         * trace( 'ar1 == ar2 : ' + ( ar1 == ar2 ) ) ; // false
         * trace( 'ar1[0] == ar2[0] : ' + ( ar1[0] == ar2[0] ) ) ; // false
         * </pre>
         * @return the deep copy of the specified Array.
         */
        public static function copyArray( ar:Array ):Array 
        {
            var a:Array = [] ;
            var l:int = ar.length ;
            for (var i:int ; i < l ; i++) 
            {
                if( ar[i] === undefined ) 
                {
                    a[i] = undefined ;
                }
                else if( ar[i] === null ) 
                {
                    a[i] = null ;
                }
                else 
                {
                    a[i] = Copier.copy(ar[i]) ;
                }
            }
            return a ;
        }  
          
        /**
         * Returns a deep copy of the date object passed in argument.
         * @return a deep copy of the date object passed in argument.
         */
        public static function copyDate( d:Date ):Date 
        {
            return new Date( d.valueOf() ) ;
        }
    }
}