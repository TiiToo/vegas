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
    import core.maths.clamp;

    import system.data.OrderedIterator;

    import flash.errors.IllegalOperationError;

    /**
     * An iterator page by page over an array who return an new array of elements.
     * If the step size value is <code class="prettyprint">1</code> the next and previous methods returns the single value element in the data array.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.iterator.PageByPageIterator;
     * 
     * var ar:Array = [1, 2, 3, 4, 5, 6, 7, 8] ;
     * 
     * var it:PageByPageIterator = new PageByPageIterator( a, 2 ) ;
     * 
     * var next:Function = function():void
     * {
     *     if (!it.hasNext())
     *     {
     *         it.reset() ;
     *     }
     *     var next:* = it.next()
     *     trace( "> " + next + " : " + it.currentPage() ) ;
     * }
     * 
     * var prev:Function = function():void
     * {
     *     var prev:* ;
     *     if ( !it.hasPrevious())
     *     {
     *         it.lastPage() ;
     *         // use it.current() to get the current page after a it.lastPage() invokation.
     *         prev = it.current() ; 
     *     }
     *     else
     *     {
     *         prev = it.previous() ;
     *     }
     *     trace( "> " + prev + " : " + it.currentPage() ) ;
     * }
     * 
     * next() ; // > 1,2 : 1
     * next() ; // > 3,4 : 2
     * next() ; // > 5,6 : 3
     * next() ; // > 7,8 : 4
     * next() ; // > 1,2 : 1
     * prev() ; // > 7,8 : 4
     * 
     * trace( "> current : " + it.current() ) ;
     * </pre>
     */
    public class PageByPageIterator implements OrderedIterator
    {
        /**
         * Creates a new PageByPageIterator.
         * @param data the array to enumerate.
         * @param stepSize the step size value.
         * @throws IllegalOperationError if the data array is empty.
         */
        public function PageByPageIterator( data:Array , stepSize:uint = 1 )
        {
            if ( data == null || data.length == 0 )
            {
                throw new IllegalOperationError( "PageByPageIterator constructor failed, data length not must be empty" ) ; 
            }
            else
            {
                var len:int = data.length ;
                 _data = data ;
                 _key = 0 ;
                 _currentPage = 0 ;
                 _step = (stepSize > 1) ? stepSize : PageByPageIterator.DEFAULT_STEP ; 
                 _pageCount =  Math.ceil( len / _step ) ;
            }
        }
        
        /**
         * The default step value in all the PageByPageIterators.
         */
        public static var DEFAULT_STEP:Number = 1 ;
        
        /**
         * Returns the current value.
         * @return the current value.
         */
        public function current():*
        {
            return _current ;
        }
        
        /**
         * Returns the current page value.
         * @return the number of the current page.
         */
        public function currentPage():Number
        {
            return _currentPage ;
        }
        
        /**
         * Seek the iterator in the first page of this object.
         */
        public function firstPage():void
        {
            seek( 1 ) ;
        }
        
        /**
         * Returns the step size of this PageByPageIterator.
         * @return the step size of this PageByPageIterator.
         */
        public function getStepSize():Number
        {
            return _step ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iterator has more elements.
         */
        public function hasNext():Boolean
        {
            return _key < _pageCount ;
        }
        
        /**
         * Checks to see if there is a previous element that can be iterated to.
         * @return <code class="prettyprint">true</code> if the iterator has more elements.
         */
        public function hasPrevious():Boolean
        {
            return _key > 1 ;
        }
        
        /**
         * Returns the current page number.
         * @return the current page number.
         */
        public function key():*
        {
            return _currentPage ;
        }
        
        /**
         * Seek the iterator in the last page of this object.
         */
        public function lastPage():void
        {
            seek( _pageCount ) ;
        }
        
        /**
         * Returns the next Array page of elements or the next element in the Array if the getStepSize() value is 1.
         * @return the next Array page of elements or the next element in the Array if the getStepSize() value is 1.
         */
        public function next():*
        {
            var index:Number = _step * _key++ ;
            _currentPage     = _key ;
            if (_step > 1)
            {
                _current = _data.slice(index, index + _step) ;
            }
            else
            {
                _current = _data[index] ;
            }
            return _current ;
        }
        
        /**
         * Returns the numbers of page of this iterator.
         * @return the numbers of page of this iterator.
         */
        public function pageCount():Number
        {
            return _pageCount ;
        }
        
        /**
         * Returns the previous Array page of elements or the previous element in the Array if the getStepSize() value is 1.
         * @return the previous element from the collection.
         */
        public function previous():*
        {
            _currentPage -- ;
            _key -- ;
            var index:Number = _step * (_key-1) ;
            if (_step > 1)
            {
                _current = _data.slice(index, index + _step) ;
            }
            else
            {
                _current = _data[index] ;
            }
            return _current ;
        }
        
        /**
         * Unsupported operation in a PageByPageIterator.
         * @throws IllegalOperationError the method remove() in this iterator is unsupported. 
         */
        public function remove():*
        {
            throw new IllegalOperationError("The PageByPageIterator remove method is unsupported.") ;
        }
        
        /**
         * Resets the key pointer of the iterator.
         */
        public function reset():void
        {
            _key         = 0 ;
            _currentPage = 0 ;
            _current     = undefined ;
        }
        
        /**
         * Seek the key pointer of the iterator.
         */
        public function seek(position:*):void
        {
            _key = clamp( position++, 0, _pageCount+1 ) ;
            _currentPage = _key ;
            var index:Number = _step * (_key-1) ;
            if (_step > 1)
            {
                _current = _data.slice(index, index + _step) ;
            }
            else
            {
                _current = _data[index] ;
            }
        }
        
        /**
         * @private
         */
        private var _current:* ;
        
        /**
         * @private
         */
        private var _currentPage:Number ;
        
        /**
         * @private
         */
        private var _data:Array ;
        
        /**
         * @private
         */
        private var _key:int ;
        
        /**
         * @private
         */
        private var _pageCount:Number ;
        
        /**
         * The numbers of lines in a page.
         * @private
         */
        private var _step:Number ;
    }
}