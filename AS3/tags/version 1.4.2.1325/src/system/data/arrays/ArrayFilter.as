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

package system.data.arrays 
{
    import system.Reflection;
    import system.Serializable;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;    

    /**
     * Dispatched when the filter is changed.
     * @eventType flash.events.Event.CHANGE
     */
    [Event(name="onFinished", type="andromeda.events.ActionEvent")]

    /**
     * This filter contains all constants and methods to sort the Arrays in the application.
     * <p><b>Example : </b></p>
     * <pre class="prettyprint">
     * import flash.events.Event ;
     * import system.data.arrays.ArrayFilter ;
     * 
     * var debug:Function = function ():Void
     * {
     *     trace("filter                : " + af.filter ) ;
     *     trace("is NONE               : " + af.isNone() )
     *     trace("is CASEINSENSITIVE    : " + af.isCaseInsensitive() ) ;
     *     trace("is DESCENDING         : " + af.isDescending() ) ;
     *     trace("is NUMERIC            : " + af.isNumeric() ) ;
     *     trace("is RETURNINDEXEDARRAY : " + af.isReturnIndexedArray() ) ;
     *     trace("is UNIQUESORT         : " + af.isUniqueSort() ) ;
     *     trace("---") ;
     * }
     * 
     * var change:Function = function ( e:Event ):Void
     * {
     *     trace( e ) ;
     * }
     * 
     * var af:ArrayFilter = new ArrayFilter() ;
     * 
     * af.addEventListener( ArrayFilter.CHANGE, change ) ;
     * 
     * debug() ;
     * 
     * af.setCaseInsensitive( true ) ;
     * af.setDescending( true ) ;
     * af.setNumeric( true ) ;
     * af.setReturnIndexedArray( true ) ;
     * af.setUniqueSort( true ) ;
     * debug() ;
     * 
     * af.setCaseInsensitive( false ) ;
     * debug() ;
     * 
     * af.setDescending( false ) ;
     * debug() ;
     * 
     * af.setNumeric( false ) ;
     * debug() ;
     * 
     * af.setReturnIndexedArray( false) ;
     * debug() ;
     * 
     * af.setUniqueSort( false ) ;
     * debug() ;
     * </pre>
     */
    public class ArrayFilter extends EventDispatcher implements Serializable
    {

        /**
         * Creates a new ArrayFilter instance.
         * @param value the default filter value of this instance. If this argument is null the filter value is ArrayFilter.NONE(0). 
         * @param target The target object for events dispatched to the EventDispatcher object. This parameter is used when the EventDispatcher instance is aggregated by a class that implements IEventDispatcher; it is necessary so that the containing object can be the target for events. Do not use this parameter in simple cases in which a class extends EventDispatcher.
         */
        public function ArrayFilter( value:uint = 0 , target:IEventDispatcher = null )
        {
            super(target);
            filter = value ;
        }
        
        /**
         * Specifies case-insensitive sorting for the Array class sorting methods. You can use this constant
         * for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> method. 
         * <p>The value of this constant is 1.</p>
         */
        public static const CASEINSENSITIVE:uint = Array.CASEINSENSITIVE ;
                
        /**
         * Specifies descending sorting for the Array class sorting methods. 
         * You can use this constant for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code>
         * or <code class="prettyprint">sortOn()</code> method. 
         * <p>The value of this constant is 2.</p>
         */
        public static const DESCENDING:uint = Array.DESCENDING ;
        
        /**
         * Specifies the default numeric sorting value for the Array class sorting methods.
         * <p>The value of this constant is 0.</p>
         */
        public static const NONE:uint = 0;
        
        /**
         * Specifies numeric (instead of character-string) sorting for the Array class sorting methods. 
         * Including this constant in the <code class="prettyprint">options</code>
         * parameter causes the <code class="prettyprint">sort()</code> and <code class="prettyprint">sortOn()</code> methods 
         * to sort numbers as numeric values, not as strings of numeric characters.  
         * Without the <code class="prettyprint">NUMERIC</code> constant, sorting treats each array element as a 
         * character string and produces the results in Unicode order. 
         *
         * <p>For example, given the array of values <code class="prettyprint">[2005, 7, 35]</code>, if the <code class="prettyprint">NUMERIC</code> 
         * constant is <strong>not</strong> included in the <code class="prettyprint">options</code> parameter, the 
         * sorted array is <code class="prettyprint">[2005, 35, 7]</code>, but if the <code class="prettyprint">NUMERIC</code> constant <strong>is</strong> included, 
         * the sorted array is <code class="prettyprint">[7, 35, 2005]</code>. </p>
         * 
         * <p>This constant applies only to numbers in the array; it does 
         * not apply to strings that contain numeric data such as <code class="prettyprint">["23", "5"]</code>.</p>
         * 
         * <p>The value of this constant is 16.</p>
         */
        public static const NUMERIC:uint = Array.NUMERIC ;
        
        /**
         * Specifies that a sort returns an array that consists of array indices as a result of calling
         * the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> method. You can use this constant
         * for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> 
         * method, so you have access to multiple views on the array elements while the original array is unmodified. 
         * <p>The value of this constant is 8.</p>
         */
        public static const RETURNINDEXEDARRAY:uint = Array.RETURNINDEXEDARRAY ;

        /**
         * Specifies the unique sorting requirement for the Array class sorting methods. 
         * You can use this constant for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> method. 
         * The unique sorting option terminates the sort if any two elements or fields being sorted have identical values. 
         * <p>The value of this constant is 4.</p>
         */
        public static const UNIQUESORT:uint = Array.UNIQUESORT ;        
        
        /**
         * Returns the current filter value of this object.
         * @return the current filter value of this object.
         */
        public function get filter():uint 
        {
            return _filter ;
        }
        
        /**
         * Sets the current filter value of this object.
         */
        public function set filter( value:uint ):void
        {
            var old:uint = _filter ;
            _filter = value ;
            if (_filter != old)
            {
                notifyChange() ;
            }  
        }
        
        /**
         * Indicates if an event is notify or not when the filter value change.
         */
        public var useEvent:Boolean = true ;
        
        /**
         * Returns <code class="prettyprint">true</code> if the filter number value contains the option number value.
         * @return <code class="prettyprint">true</code> if the filter number value contains the option number value.
         */
        public static function contains( nFilter:uint, nOption:uint ):Boolean
        {
            return Boolean(nOption & nFilter) ;
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the CASEINSENSITIVE option value exist in the current filter.
         * @return <code class="prettyprint">true</code> if the CASEINSENSITIVE option value exist in the current filter.
        */
        public function isCaseInsensitive():Boolean
        {
            return contains( filter , CASEINSENSITIVE ) ;    
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the DESCENDING option value exist in the current filter.
         * @return <code class="prettyprint">true</code> if the DESCENDING option value exist in the current filter.
         */
        public function isDescending():Boolean
        {
            return contains( _filter , DESCENDING ) ;    
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the filter is NONE.
         * @return <code class="prettyprint">true</code> if the filter is NONE.
         */
        public function isNone():Boolean
        {
            return _filter == NONE ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the NUMERIC option value exist in the current filter.
         * @return <code class="prettyprint">true</code> if the NUMERIC option value exist in the current filter.
         */
        public function isNumeric():Boolean
        {
            return contains( _filter , NUMERIC ) ;    
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the RETURNINDEXEDARRAY option value exist in the current filter.
         * @return <code class="prettyprint">true</code> if the RETURNINDEXEDARRAY option value exist in the current filter.
         */
        public function isReturnIndexedArray():Boolean
        {
            return contains( _filter , RETURNINDEXEDARRAY ) ;    
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the UNIQUESORT option value exist in the current filter.
         * @return <code class="prettyprint">true</code> if the UNIQUESORT option value exist in the current filter.
         */
        public function isUniqueSort():Boolean
        {
            return contains( _filter , UNIQUESORT ) ;    
        }
        
        /**
         * Notify an event when the filter value is changed.
         */
        public function notifyChange():void
        {
            if ( useEvent == true )
            {
                dispatchEvent( new Event(Event.CHANGE) ) ;
            }    
        }
        
        /**
         * Sets the CASEINSENSITIVE option value in the current filter.
         */
        public function setCaseInsensitive(b:Boolean):void
        {
            var old:uint = _filter ;
            _filter = b ? _filter | CASEINSENSITIVE : _filter & ~CASEINSENSITIVE ;
            if (_filter != old)
            {
                notifyChange() ;
            }    
        }
        
        /**
         * Sets the DESCENDING option value in the current filter.
         */
        public function setDescending( b:Boolean ):void
        {
            var old:uint = _filter ;
            _filter = b ? _filter | DESCENDING : _filter & ~DESCENDING ;
            if (_filter != old)
            {
                notifyChange() ;
            }
        }
        
        /**
         * Sets the NONE option value in the current filter.
         */
        public function setNone():void
        {
            var old:uint = _filter ;
            _filter = NONE ;
            if (_filter != old)
            {
                notifyChange() ;
            }    
        }

        /**
         * Sets the NUMERIC option value in the current filter.
         */
        public function setNumeric( b:Boolean ):void
        {
            var old:uint = _filter ;
            _filter = b ? _filter | NUMERIC : _filter & ~NUMERIC ;
            if (_filter != old)
            {
                notifyChange() ;
            }    
        }

        /**
         * Sets the RETURNINDEXEDARRAY option value in the current filter.
         */
        public function setReturnIndexedArray( b:Boolean ):void
        {
            var old:uint = _filter ;
            _filter = b ? _filter | RETURNINDEXEDARRAY : _filter & ~RETURNINDEXEDARRAY ;
            if (_filter != old)
            {
                notifyChange() ;
            }    
        }

        /**
         * Sets the UNIQUESORT option value in the current filter.
         */
        public function setUniqueSort( b:Boolean ):void
        {
            var old:uint = _filter ;
            _filter = b ? _filter | UNIQUESORT : _filter & ~UNIQUESORT ;
            if (_filter != old)
            {
                notifyChange() ;
            }    
        }

        /**
         * Returns a eden String representation of the object.
         * @return a string representation the source code of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + Reflection.getClassPath( this ) + "(" +  _filter + ")" ;
        }
        
        /**
         * Returns a eden String representation of the object.
         * @return a string representation of the source code of the object.
         */
        public override function toString():String 
        {
            return "[ArrayFilter " + _filter + "]" ;
        } 
        
        /**
         * The filter value of this object.
         */
        private var _filter:uint ;        
        
    }
}
