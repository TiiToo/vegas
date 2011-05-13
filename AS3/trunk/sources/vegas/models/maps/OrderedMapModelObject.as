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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
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

package vegas.models.maps 
{
    import system.data.Map;
    import system.data.ValueObject;
    import system.data.iterators.PageByPageIterator;
    import system.data.maps.ArrayMap;
    
    /**
     * This map model object is ordered with a previous and next methods inside.
     * 
     * @example Example
     * <listing version="3.0">
     * <code class="prettyprint">
     * package examples
     * {
     *     import vegas.events.ModelObjectEvent;
     *     import vegas.models.maps.OrderedMapModelObject;
     *     import vegas.vo.FilterVO;
     *     
     *     import flash.display.Sprite;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     
     *     public class OrderedMapModelObjectExample extends Sprite 
     *     {
     *         public function OrderedMapModelObjectExample()
     *         {
     *             model = new OrderedMapModelObject() ;
     *             
     *             model.addEventListener( ModelObjectEvent.ADD_VO    , debug ) ;
     *             model.addEventListener( ModelObjectEvent.CHANGE_VO , debug ) ;
     *             
     *             var count:uint = 4 ;
     *             
     *             for (var i:int ; i &lt; count ; i++ ) 
     *             {
     *                 model.addVO( new FilterVO( { id : i , filter : i << 1 } ) ) ;
     *             }
     *             
     *             model.run() ;
     *             
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *         }
     *         
     *         public var model:OrderedMapModelObject ;
     *         
     *         public function debug( e:ModelObjectEvent ):void
     *         {
     *             trace( "type:" + e.type + " vo:" + e.getVO() ) ;
     *         }
     *         
     *         public function keyDown( e:KeyboardEvent ):void
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.LEFT :
     *                 {
     *                     model.previous() ;
     *                     trace( "hasPrevious:" + model.hasPrevious() ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.RIGHT :
     *                 {
     *                     model.next() ;
     *                     trace( "hasNext:" + model.hasNext() ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.SPACE :
     *                 {
     *                     model.loop = !model.loop ;
     *                     trace( "loop:" + model.loop ) ;
     *                     break ;
     *                 }
     *             }
     *         }
     *     }
     * }
     * </code>
     * </listing>
     */
    public class OrderedMapModelObject extends MapModelObject
    {
        /**
         * Creates a new OrderedMapModelObject instance.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel (optional) the name of the global event flow if the <code>global</code> argument is <code>true</code>.
         * @param id the id of this model.
         */
        public function OrderedMapModelObject( global:Boolean = true , channel:String = null , id:* = null )
        {
            super( global, channel, new ArrayMap() , id );
        }
        
        /**
         * Indicates if the next and previous method loops when the internal ordered iterator can find a next or previous value object.
         */
        public var loop:Boolean = true ;
        
        /**
         * Clear the model.
         */
        public override function clear():void
        {
            _it = null ;
            super.clear() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model has more elements.
         * @return <code class="prettyprint">true</code> if the model has more elements.
         */
        public function hasNext():Boolean
        {
            if ( _map.size() > 0 )
            {
                if ( _it.hasNext() )
                {
                    return true ;
                }
                else
                {
                    return loop;
                }
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Checks to see if there is a previous element that can be iterated to.
         * @return <code class="prettyprint">true</code> if the iterator has more elements.
         */
        public function hasPrevious():Boolean
        {
            if ( _map.size() > 0 )
            {
                if ( _it.hasPrevious() )
                {
                    return true ;
                }
                else
                {
                    return loop;
                }
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Initialize the internal Map instance in the constructor of the class.
         */
        public override function initializeMap():Map
        {
            return new ArrayMap() ;
        }
        
        /**
         * Sets the next value object in the model.
         */
        public function next():void
        {
            if ( _it )
            {
                if ( !_it.hasNext() )
                {
                    if( loop )
                    {
                        _it.reset() ;
                    }
                    else
                    {
                        return ;
                    }
                }
                setCurrentVO( getVO( _it.next() ) ) ;
            }
            else if ( _map.size() > 0 )
            {
                reset() ;
                next() ;
            }
        }
        
        /**
         * Sets the previous value object in the model. 
         * If no value object is selected in the model this method invoke the next() method to select the first value object.
         */
        public function previous():void
        {
            if ( _it )
            {
                var prev:* ;
                if ( !_it.hasPrevious() )
                {
                    if ( loop )
                    {
                        _it.lastPage() ;
                    }
                    else
                    {
                        return ;
                    }
                    prev = _it.current() ;
                }
                else
                {
                    prev = _it.previous() ; 
                }
                setCurrentVO( getVO( prev ) ) ;
            }
            else if ( _map.size() > 0 )
            {
                reset() ;
                next() ;
            }
        }
        
        /**
         * Reset the internal iterator of the model.
         */
        public function reset():void
        {
            if (size() > 0)
            {
                _it = new PageByPageIterator( getMap().getKeys() ) ;
            }
            else
            {
                _it = null ;
            }
        }
        
        /**
         * Resets the model and run the model to select the next value object register in the model.
         */
        public override function run( ...arguments:Array ):void
        {
            reset() ;
            if ( _map.size() > 0 )
            {
                next()  ;
            }
        }
        
        /**
         * Seek the model and select the specified value Object.
         * @param vo The value object reference to seek the model.
         * @throws ArgumentError if the passed-in ValueObject isn't register in the model.
         */
        public function seek( vo:ValueObject ):void
        {
            if ( contains(vo) )
            {
                var map:ArrayMap = getMap() as ArrayMap ;
                var index:uint   = map.indexOfValue( vo ) ;
                if ( _it == null )
                {
                    reset() ;
                }
                _it.seek(index) ;
                super.setCurrentVO( vo ) ;
                _it.seek( index + 1 ) ;
            }
            else
            {
                throw new ArgumentError(this + " seek method failed, the passed-in ValueObject isn't register in the model.") ;
            }
        }
        
        /**
         * Sets the current <code class="prettyprint">ValueObject</code> selected in this model.
         */
        public override function setCurrentVO( vo:ValueObject ):void
        {
            seek(vo) ;
        }
        
        /**
         * The internal iterator to show the pictures.
         */
        protected var _it:PageByPageIterator ;
    }
}