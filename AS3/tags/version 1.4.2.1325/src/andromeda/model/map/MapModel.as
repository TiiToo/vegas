/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.model.map 
{
    import andromeda.events.EntryEvent;
    import andromeda.model.ChangeModel;

    import system.data.Entry;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.Map;
    import system.data.maps.HashMap;
    import system.data.maps.MapEntry;

    /**
     * This model use an internal <code class="prettyprint">Map</code> to register Entry objects with a specific key and this corresponding value.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples
     * {
     *     import andromeda.events.EntryEvent;
     *     import andromeda.model.map.MapModel;
     *     
     *     import system.data.Iterator;
     *     import system.data.maps.ArrayMap;
     *     
     *     import flash.display.Sprite;
     *     
     *     public class ExampleMapModel extends Sprite 
     *     {
     *         public function ExampleMapModel()
     *         {
     *             var model:MapModel = new MapModel() ;
     *             
     *             model.setMap( new ArrayMap() ) ;
     *             
     *             model.addEventListener( EntryEvent.ADD           , debug ) ;
     *             model.addEventListener( EntryEvent.BEFORE_CHANGE , debug ) ;
     *             model.addEventListener( EntryEvent.CHANGE        , debug ) ;
     *             model.addEventListener( EntryEvent.REMOVE        , debug ) ;
     *             model.addEventListener( EntryEvent.UPDATE        , debug ) ;
     *             
     *             var count:uint = 4 ;
     *             
     *             for (var i:int ; i<count ; i++ ) 
     *             {
     *                 model.put( "key" + i , "value" + i ) ;
     *             }
     *             
     *             var it:Iterator = model.keyIterator() ;
     *             
     *             while( it.hasNext() )
     *             {
     *                 model.current = it.next() ;
     *             }
     *             
     *             trace( "- model current : " + model.current ) ;
     *             
     *             trace( "- model size : " + model.size() ) ;
     *             
     *             model.remove( "key2" ) ;
     *             
     *             trace( "- model size : " + model.size() ) ;
     *             
     *             model.update( "key3" , "content3" ) ;
     *         }
     *         
     *         public function debug( e:EntryEvent ):void
     *         {
     *             trace( "# type:" + e.type + " entry:" + e.entry ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class MapModel extends ChangeModel implements Iterable 
    {
        /**
         * Creates a new MapModel instance.
         * @param id the id of this model.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel (optional) the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         * @param factory (optionale) the Map factory reference used in the model to register all entries.
         */
        public function MapModel(id:* = null, global:Boolean = false, channel:String=null , factory:Map = null )
        {
            super( id , global , channel );
            _map = factory || initializeMap() ;
        }
        
        /**
         * Sets this property with the key of the entry register in the model, the getter value of this virtual property returns a MapEntry object.
         * @private
         */
        public override function set current( o:* ):void
        {
            if ( o == _current && security )
            {
                return ;
            }
            if ( _current != null && _current is MapEntry )
            {
                notifyBeforeChange( _current ) ;
                _current = null ;
            }
            if ( o != null && _map.containsKey( o ) )
            {
                _current = _map.get(o) ;
                notifyChange( _current );
            }
        }
        
        /**
         * Removes all value objects in the model.
         */
        public override function clear():void
        {
            _map.clear() ;
            super.clear() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model contains the specified value.
         * @return <code class="prettyprint">true</code> if the model contains the specified value.
         */
        public function contains( value:* ):Boolean
        {
            return _map.containsValue( value ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model contains the specified id key in argument.
         * @return <code class="prettyprint">true</code> if the model contains the specified id key in argument
         */
        public function containsKey( key:* ):Boolean
        {
            return _map.containsKey( key ) ;
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">addVO</code> method.
         * @return the event name use in the <code class="prettyprint">addVO</code> method.
         */
        public function getEventTypeADD():String
        {
            return _sAddType ;
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">removeVO</code> method.
         * @return the event name use in the <code class="prettyprint">removeVO</code> method.
         */
        public function getEventTypeREMOVE():String
        {
            return _sRemoveType ;
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">updateVO</code> method.
         * @return the event name use in the <code class="prettyprint">updateVO</code> method.
         */
        public function getEventTypeUPDATE():String
        {
            return _sUpdateType ;
        }
        
        /**
         * Returns the internal map of this model.
         * @return the internal map of this model.
         */
        public function getMap():Map
        {
            return _map ; 
        }
        
        /**
         * Returns the value register in the model with the specified key.
         * @return the value register in the model with the specified key.
         */
        public function get( key:* ):*
        {
            return _map.get( id ) ;
        }
        
        /**
         * Returns the MapEntry representation of the key/value entry register in the model with the specified key.
         * @return the MapEntry representation of the key/value entry register in the model with the specified key.
         */
        public function getMapEntry( key:* ):MapEntry
        {
            if ( containsKey( key ) )
            {
                return new MapEntry( key , get(key) ) ;
            }
            return null ;
        }
        
        /**
         * This method is invoked to initialize all event types of the model.
         */
        public override function initEventType():void
        {
            _sAddType          = EntryEvent.ADD ;
            _sBeforeChangeType = EntryEvent.BEFORE_CHANGE ;
            _sChangeType       = EntryEvent.CHANGE ;
            _sClearType        = EntryEvent.CLEAR  ;
            _sRemoveType       = EntryEvent.REMOVE ;
            _sUpdateType       = EntryEvent.UPDATE ;
        }
        
        /**
         * Initialize the internal Map instance in the constructor of the class.
         * You can overrides this method if you want change the default HashMap use in this model.
         */
        public function initializeMap():Map
        {
            return new HashMap() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model is empty.
         * @return <code class="prettyprint">true</code> if the model is empty.
         */
        public function isEmpty():Boolean 
        {
            return _map.isEmpty() ;
        }
        
        /**
         * Returns the iterator of this model.
         * @return the iterator of this model.
         */
        public function iterator():Iterator
        {
            return _map.iterator() ;
        }
        
        /**
         * Returns the keys iterator of this model.
         * @return the keys iterator of this model.
         */
        public function keyIterator():Iterator
        {
        	return _map.keyIterator() ;
        }
        
        /**
         * Notify a <code class="prettyprint">ModelObjectEvent</code> when a <code class="prettyprint">ValueObject</code> is inserted in the model.
         */ 
        public function notifyAdd( entry:Entry ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( new EntryEvent( _sAddType , entry ) ) ;
        }
        
        /**
         * Notify an event before the current <code class="prettyprint">value</code> selected in the model is changed.
         */ 
        public override function notifyBeforeChange( value:* ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( new EntryEvent( _sBeforeChangeType , value ) ) ;
        }
        
        /**
         * Notify an event when a value is selected and changed in the model.
         */
        public override function notifyChange( value:*  ):void
        {
            if ( isLocked( ) )
            {
                return ;
            }
            dispatchEvent( new EntryEvent( _sChangeType , value ) ) ;
        }
        
        /**
         * Notify an event when the model is cleared.
         */ 
        public override function notifyClear():void
        {
            if ( isLocked( ) )
            {
                return ;
            }
            dispatchEvent( new EntryEvent( _sClearType ) ) ;
        }
        
        /**
         * Notify an <code class="prettyprint">EntryEvent</code> when an key/value entry is removed in the model.
         */ 
        public function notifyRemove( entry:Entry ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( new EntryEvent( _sRemoveType , entry ) ) ;
        }
        
        /**
         * Notify an <code class="prettyprint">EntryEvent</code> when the model is updated.
         */ 
        public function notifyUpdate( entry:Entry ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( new EntryEvent( _sUpdateType , entry ) ) ;
        }
        
        /**
         * Inserts a value object in the model.
         * @throws ArgumentError if the argument of this method is 'null' or 'undefined'. 
         * @throws ArgumentError if the <code class="prettyprint">key</code> passed in argument is already register in the model.
         */
        public function put( key:* , value:* ):void
        {
            if (key == null)
            {
                throw new ArgumentError( this + " add method failed, the argument passed in argument not must be 'null' or 'undefined'.") ;
            }
            if ( !_map.containsKey( key ) )
            {
                var e:MapEntry = new MapEntry( key , value ) ;
                _map.put( key , e ) ;
                notifyAdd( e ) ;
            }
            else
            {
                throw new ArgumentError( this + " add method failed, the key passed in argument already register in the model, you must remove this 'id' key before add a new value or use the update method.") ;    
            }
        }
        
        /**
         * Removes the entry register in the model with the specified key.
         */
        public function remove( key:* ):void
        {
            if (key == null)
            {
                throw new ArgumentError( this + " remove method failed, the passed-in key not must be 'null' or 'undefined'.") ;
            }    
            if ( _map.containsKey( key ) )
            {
                notifyRemove( _map.remove( key ) as MapEntry ) ;
            }
            else
            {
                throw new ArgumentError( this + " remove method failed, the passed-in key must be register in the model.") ;
            }
        }
        
        /**
         * Sets the event name use in the <code class="prettyprint">addVO</code> method.
         */
        public function setEventTypeADD( type:String ):void
        {
            _sAddType = type ;
        }
        
        /**
         * Sets the event name use in the <code class="prettyprint">removeVO</code> method.
         */
        public function setEventTypeREMOVE( type:String ):void
        {
            _sRemoveType = type ;
        }
        
        /**
         * Sets the event name use in the <code class="prettyprint">addVO</code> method.
         */
        public function setEventTypeUPDATE( type:String ):void
        {
            _sUpdateType = type ;
        }
        
        /**
         * Sets the internal map of this model. By default the 'initializeMap' method is used if the passed-in argument is null.
         */
        public function setMap( m:Map ):void
        {
            _map = m || initializeMap() ;
        }
        
        /**
         * Returns the number of <code class="prettyprint">ValueObject</code> in this model.
         * @return the number of <code class="prettyprint">ValueObject</code> in this model.
         */
        public function size():Number
        {
            return _map.size() ;
        }
        
        /**
         * Update a key/value entry in the model.
         * @throws ArgumentError if the key passed-in argument isn't register in the model.
         */
        public function update( key:* , value:*  ):void
        {
            if ( _map.containsKey( key ) )
            {
                var e:MapEntry = _map.get(key) as MapEntry ;
                e.value = value ;
                notifyUpdate( e ) ;
            }
            else
            {
                throw new ArgumentError( this + " update failed, the passed-in key passed in argument don't exist in the model.") ;
            }
        }
        
        /**
         * The internal map of this model.
         */
        private var _map:Map ;
        
        /**
         * The internal ModelObjectEvent type use in the addVO method.
         */
        private var _sAddType:String ;
                
        /**
         * The internal ModelObjectEvent type use in the removeVO method.
         */
        private var _sRemoveType:String ;
        
        /**
         * The internal ModelObjectEvent type when the update event type is use.
         */
        private var _sUpdateType:String ;
    }
}
