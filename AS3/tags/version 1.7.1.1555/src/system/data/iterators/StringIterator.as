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

package system.data.iterators
{
    import system.data.Iterator;
    import system.numeric.Mathematics;
    
    import flash.errors.IllegalOperationError;
    
    /**
     * Converts a string to an iterator.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.Iterator ;
     * import system.data.iterators.StringIterator ;
     * 
     * var s:String = "Hello world" ;
     * 
     * var it:Iterator = new StringIterator(s) ;
     * 
     * it.seek( 1 ) ;
     * 
     * while( it.hasNext() )
     * {
     *     var char:String = it.next() ;
     *     trace( it.key() + ' : ' + char ) ;
     * }
     * 
     * trace (s) ;
     * </pre>
     */
    public class StringIterator implements Iterator
    {
        /**
         * Creates a new StringIterator instance.
         * @param s the String object to enumerate.
         */
        public function StringIterator( s:String )
        {
            if ( s == null )
            {
               throw new ArgumentError( this + " constructor failed, the passed-in String argument not must be 'null'.") ;   
            } 
            _s    = s  ;
            _k    = -1 ;
            _size = s.length ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */    
        public function hasNext():Boolean
        {
            return _k < _size - 1  ;
        }
        
        /**
         * Returns the current key of the internal pointer of the iterator (optional operation).
         * @return the current key of the internal pointer of the iterator (optional operation).
         */
        public function key():*
        {
            return _k ;
        }
        
        /**
         * Returns the next element in the iteration.
         * @return the next element in the iteration.
         */
        public function next():*
        {
            return _s.charAt( ++_k );
        }
        
        /**
         * Removes from the underlying collection the last element returned by the iterator (optional operation).
         */
        public function remove():*
        {
            throw new IllegalOperationError( "This " + this + " does not support the reset() method.") ;
            return null ;
        }
        
        /**
         * Reset the internal pointer of the iterator (optional operation).
         */
        public function reset():void
        {
            _k = -1 ;
        }
        
        /**
         * Change the position of the internal pointer of the iterator (optional operation).
         */
        public function seek(position:*):void
        {
            _k = Mathematics.clamp ( ( position - 1 ) , -1 , _size - 1 ) ;
        }
        
        /**
         * @private
         */
        private var _k:Number ;
        
        /**
         * @private
         */
        private var _s:String ;
        
        /**
         * @private
         */
        private var _size:Number ;
    }
}