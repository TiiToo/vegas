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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.models.arrays
{
    import system.data.Iterator;
    import system.data.ValueObject;
    import system.data.iterators.PageByPageIterator;
    import system.events.ArrayEvent;
    
    import vegas.events.ModelObjectEvent;
    import vegas.models.CoreModelObject;
    
    /**
     * Defines an <code class="prettyprint">Array</code> model with a 'page by page' iterator.
     * <p><b>Example :</b>>/p>
     * <pre class="prettyprint">
     * import vegas.events.ModelObjectEvent ;
     * import vegas.models.arrays.PageableArrayModelObject ;
     * import vegas.vo.SimpleValueObject ;
     * 
     * import system.events.ArrayEvent ;
     * 
     * var update:Function = function( e:Event ):void
     * {
     *     switch( true )
     *     {
     *         case e is ArrayEvent :
     *         {
     *             trace( e + " : " + (e as ArrayEvent).getArray() ) ;
     *             break ;
     *         }
     *         case e is ModelObjectEvent :
     *         {
     *             trace( e + " : " + (e as ModelObjectEvent).getVO() ) ;
     *             break ;
     *         }
     *         default :
     *         {
     *             trace( e + " : unknow type of event.") ;
     *         }
     *     }
     * }
     * 
     * var model:PageableArrayModelObject = new PageableArrayModelObject() ;
     * 
     * model.count =  2 ;
     * 
     * model.addEventListener( ModelObjectEvent.UPDATE_VO , update ) ;
     * 
     * var datas:Array  = [] ;
     * var count:uint = 20 ;
     * for ( var i:uint = 0 ; i<count ; i++ )
     * {
     *     datas.push( new SimpleValueObject( { id:i } ) ) ;
     * }
     * 
     * model.init( datas ) ;
     * 
     * var onKeyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.LEFT :
     *         {
     *             if ( model.hasPrevious() == false )
     *             {
     *                 model.lastPage() ;
     *             }
     *             else
     *             {
     *                 model.previous() ;
     *             }
     *             break ;
     *        }
     *        case Keyboard.RIGHT :
     *        {
     *            if ( model.hasNext() == false )
     *            {
     *                model.firstPage() ;
     *            }
     *            else
     *            {
     *                model.next() ;
     *            }
     *            break ;
     *        }
     *        case Keyboard.SPACE :
     *        {
     *            model.setCount( 4 , true ) ; // change the count value but not auto restart the update process of the model.
     *        }
     *     }
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , onKeyDown ) ;
     * 
     * trace( "Press Keyboard.LEFT and Keyboard.RIGHT keys to test this model" ) ;
     * trace( "Press Keyboard.SPACE to use a page with 4 items inside (change count of items)." ) ;
     * 
     * model.currentPage = 2 ; // go to the page 2
     */
    public class PageableArrayModelObject extends CoreModelObject
    {
        /**
         * Creates a new PageableArrayModelObject instance.
         * @param id the id of this model.
         * @param global the flag to use a global event flow or a local event flow (default true).
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function PageableArrayModelObject(id:* = null, global:Boolean = true, channel:String = null)
        {
            super( id, global, channel );
            _a = [] ;
        }
        
        /**
         * Determinates the count of items in a page of this model.
         */
        public function get count():uint
        {
            return _count ;
        }
        
        /**
         * @private
         */
        public function set count( n:uint ):void
        {
            setCount( n ) ;
        }
        
        /**
         * Indicates the current page selected in the model.
         */
        public function get currentPage():Number
        {
            return _itPage.currentPage() ;
        }        
        
        /**
         * Indicates the current page selected in the model.
         */
        public function set currentPage( n:Number ):void
        {
            if ( _itPage != null )
            {
                _itPage.seek(n) ;
                notifyUpdate( _itPage.current() ) ;
            }
        }
        
        /**
         * Indicates the numbers of page with the current model.
         */
        public function get pageCount():Number
        {
            return _itPage.pageCount() ;
        }
        
        /**
         * Clear the model.
         */    
        public override function clear():void
        {
            _a = []  ;
            super.clear() ;
        }
        
        /**
         * Seek the iterator in the first page of this object.
         */
        public function firstPage():void
        {
            if ( _itPage != null )
            {
                _itPage.firstPage() ;
                notifyUpdate( _itPage.current() ) ;
            }
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">addVO</code> method.
         * @return the event name use in the <code class="prettyprint">addVO</code> method.
         */
        public function getEventTypeUPDATE():String
        {
            return _sUpdateType || ModelObjectEvent.UPDATE_VO ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the list has a next page.
         * @return <code class="prettyprint">true</code> if the list has a next page.
         */
        public function hasNext():Boolean
        {
            return  _itPage.hasNext() ;
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the list has a previous page.
         * @return <code class="prettyprint">true</code> if the list has a previous page.
         */
        public function hasPrevious():Boolean
        {
            return _itPage.hasPrevious() ;
        }
        
        /**
         * Fill and initialize the model with an Array of ValueObject.
         * @param datas The array of all value objects to insert in the model.
         * @param noClear (optional) If this argument is <code class="prettyprint">true</code> the clear method isn't called when this process begin.
         * @param noRefresh (optional) If this argument is <code class="prettyprint">true</code> the refresh method isn't called when this process is finish.
         */
        public function init( datas:Array , noClear:Boolean=false , noRefresh:Boolean=false ):void
        {
            if ( !noClear )
            {
                clear() ;
            }
            var vo:ValueObject ;
            var len:int = datas.length ;
            for ( var i:int ; i < len ; i++ )
            {
                vo = datas[i] as ValueObject ;
                if ( supports( vo ) )
                {
                    _a.push( vo ) ;
                }    
            }
            if ( noRefresh == true )
            {
                return ;
            }
            refresh() ;
        }
        
        /**
         * Returns a PageByPageIterator of this model.
         * @return a PageByPageIterator of this model.
         */
        public function iterator():Iterator
        {
            return new PageByPageIterator( _a , _count ) ;
        }
        
        /**
         * Seek the iterator in the last page of this object.
         */
        public function lastPage():void
        {
            if ( _itPage != null )
            {
                _itPage.lastPage() ;
                notifyUpdate( _itPage.current() ) ;
            }
        }
        
        /**
         * Notify an <code class="prettyprint">Event</code> when a <code class="prettyprint">IValueObject</code> is inserted in the model. 
         * If the model countVO value is > 1 notify an ArrayEvent else if the coutVO value is 1 notify a ModelObjectEvent. 
         */ 
        public function notifyUpdate( value:* ):*
        {
            if ( isLocked() == false )
            {
                if ( count > 1 )
                {    
                    dispatchEvent( new ArrayEvent( getEventTypeUPDATE() , value as Array ) ) ;
                }
                else
                {
                    dispatchEvent( new ModelObjectEvent( getEventTypeUPDATE() , this , value ) ) ;
                }
            }
            return value ;
        }
        
        /**
         * Show the next page of the model.
         */
        public function next():*
        {
            if ( hasNext() )
            {
                return notifyUpdate( _itPage.next() ) ;
            }
        }
        
        /**
         * Show in the previous page in the list or previous screen.
         */
        public function previous():*
        {
            if ( hasPrevious() )
            {
                return notifyUpdate( _itPage.previous() ) ;
            }
        }
        
        /**
         * Refresh the model.
         */
        public function refresh():void
        {
            if (size() > 0)
            {
                _itPage = new PageByPageIterator ( _a , _count ) ;
            }
            else
            {
                _itPage = null ;
            }
            run() ;
        }
        
        /**
         * Resets the key pointer of the iterator.
         */
        public function reset():void 
        {
            if ( _itPage != null )
            {
                _itPage.reset() ;
            }
        }
        
        /**
         * Run the model when is initialize. This method don't work if the model is locked.
         * @see Lockable
         */
        public override function run(...arguments:Array):void
        {
            if ( isLocked() ) 
            {
                return ;
            }
            if ( size() > 0 )
            {
                next() ;
            }
        }
        
        /**
         * Set the count of items in a page of this model. 
         * @param n The count value of items in this model. This value must be >=1.
         * @param noRender Indicates if the method call the run method if this argumement is <code class="prettyprint">false</code> (default is <code class="prettyprint">false</code>).
         */
        public function setCount( n:uint , noRender:Boolean=false ):void
        {
            _count = n > 1 ? n : 1 ;
            if ( noRender ) 
            {
                lock() ;
            }
            refresh() ;
            if ( noRender ) 
            {
                unlock() ;
            }
        }
        
        /**
         * Sets the event name use in the <code class="prettyprint">addVO</code> method.
         */
        public function setEventTypeUPDATE( type:String ):void
        {
            _sUpdateType = type ;
        }
        
        /**
         * Returns the number of <code class="prettyprint">IValueObject</code> in this model.
         * @return the number of <code class="prettyprint">IValueObject</code> in this model.
         */
        public function size():uint
        {
            return _a.length ;
        }
        
        /**
         * Returns the Array representation of all vos in this model.
         * @return the Array representation of all vos in this model.
         */
        public function toArray():Array
        {
            return [].contact( _a ) ;
        }
        
        /**
         * @private
         */
        private var _a:Array ; 
        
        /**
         * @private
         */
        private var _count:Number = 1 ;
        
        /**
         * @private
         */
        private var _itPage:PageByPageIterator ;
        
        /**
         * @private
         */
        private var _sUpdateType:String ;
    }
}
