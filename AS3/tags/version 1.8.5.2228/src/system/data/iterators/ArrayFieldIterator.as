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
  Portions created by the Initial Developers are Copyright (C) 2006-2011
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

package system.data.iterators
{
    /**
     * Converts an array to an iterator but this iterator return the value of a specific field if the array is an array of objects.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.iterators.ArrayFieldIterator ;
     * 
     * var ar:Array = 
     * [
     *     { label : "item1", date : new Date(2005, 10, 12) } ,
     *     { label : "item2", date : new Date(2004, 2, 22) } ,
     *     { label : "item3", date : new Date(2005, 4, 3) }
     * ] ;
     * 
     * trace (" --- browse 'label' field") ;
     * 
     * var it:ArrayFieldIterator = new ArrayFieldIterator(ar, "label") ;
     * while (it.hasNext()) 
     * {
     *     trace (it.next() + " : " + it.key()) ;
     * }
     * 
     * trace(" --- browse 'date' field") ;
     * 
     * var it:ArrayFieldIterator = new ArrayFieldIterator(ar, "date") ;
     * while (it.hasNext())
     * {
     *     trace (it.next() + " : " + it.key()) ;
     * }
     * </pre>
     */
    public class ArrayFieldIterator extends ArrayIterator
    {
        /**
         * Creates a new ArrayFieldIterator instance.
         */
        public function ArrayFieldIterator(a:Array, fieldName:String=null)
        {
            super(a) ;
            this.fieldName = fieldName ;
        }
        
        /**
         * The field used in the next method to return the next value in the array.
         */    
        public var fieldName:String ;
        
        /**
         * The default undefineable value use if the field don't exist in the current object in the iterator. 
         */
        public var undefineable:* = null ;
        
        /**
         * Returns the next field element in the iteration.
         * @return the next field element in the iteration.
         */
        public override function next():* 
        {
            var o:* = _a[++_k] ;
            return ( fieldName != null ) ? ( fieldName in o ? o[fieldName] : null ) : o ;
        }
    }
}