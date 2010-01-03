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

package vegas.models.maps
{
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.Map;
    import system.data.ValueObject;
    import system.data.maps.HashMap;
    
    import vegas.events.ModelObjectEvent;
    import vegas.models.CoreModelObject;
    
    /**
     * This model use an internal <code class="prettyprint">Map</code> to register value objects with a specific key.
     */
    public class MapModelObject extends CoreModelObject implements Iterable 
    {
        /**
         * Creates a new MapModelObject instance.
         * @param id the id of this model.
         * @param global the flag to use a global event flow or a local event flow (default true).
         * @param channel (optional) the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         * @param factory (optional) the Map factory reference used in the model to register all entries.
         */
        public function MapModelObject(id:* = null , global:Boolean = true , channel:String = null , factory:Map = null )
        {
            super( id , global , channel );
            _map = factory || initializeMap() ;
        }
        
        /**
         * Inserts a value object in the model.
         * @throws ArgumentError if the argument of this method is 'null' or 'undefined'. 
         * @throws ArgumentError if the <code class="prettyprint">ValueObject</code> passed in argument is already register in the model.
         */
        public function addVO( vo:ValueObject ):void
        {
            if (vo == null)
            {
                throw new ArgumentError( this + " addVO method failed, the argument passed in argument not must be 'null' or 'undefined'.") ;    
            }
            validate(vo) ;
            if ( !_map.containsKey( vo.id ) )
            {
                _map.put( vo.id , vo ) ;
                notifyAdd(vo) ;
            }
            else
            {
                throw new ArgumentError( this + " addVO method failed, the ValueObject passed in argument already register in the model, you must remove this 'id' key before add a new value object.") ;    
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
         * Returns <code class="prettyprint">true</code> if the model contains the specified ValueObject.
         * @return <code class="prettyprint">true</code> if the model contains the specified ValueObject.
         */
        public function contains( vo:ValueObject ):Boolean
        {
            return _map.containsValue( vo ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model contains the specified id key in argument.
         * @return <code class="prettyprint">true</code> if the model contains the specified id key in argument
         */
        public function containsByID( id:* ):Boolean
        {
            return _map.containsKey( id ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model contains the specified attribute value.
         * @return <code class="prettyprint">true</code> if the model contains the specified id key in argument
         */
        public function containsByProperty( propName:String , value:* ):Boolean
        {
            if ( propName == null )
            {    
                return false ;
            }    
            var datas:Array = _map.getValues() ;
            var size:int = datas.length ;
            if (size > 0)
            {
                while ( --size > -1 )
                {
                    if ( datas[size][propName] == value )
                    {
                        return true ;
                    }
                }
                return false ;
            }
            else
            {
                return false ;
            }
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
         * Returns the ValueObject defined by the id passed in argument.
         * @return the ValueObject defined by the id passed in argument.
         */
        public function getVO( id:* ):ValueObject
        {
            return _map.get( id ) ;
        }
        
        /**
         * This method is invoked in the constructor of the class to initialize all events.
         * Overrides this method.
         */
        public override function initEventType():void
        {
            super.initEventType() ;
            _sAddType    = ModelObjectEvent.ADD_VO ;
            _sRemoveType = ModelObjectEvent.REMOVE_VO ;
            _sUpdateType = ModelObjectEvent.UPDATE_VO ;
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
         * Notify a <code class="prettyprint">ModelObjectEvent</code> when a <code class="prettyprint">ValueObject</code> is inserted in the model.
         */ 
        public function notifyAdd( vo:ValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            if ( hasEventListener( _sAddType ) )
            {
                dispatchEvent( createNewModelObjectEvent( _sAddType , vo ) ) ;
            }
        }
        
        /**
         * Notify a <code class="prettyprint">ModelObjectEvent</code> when a <code class="prettyprint">ValueObject</code> is removed in the model.
         */ 
        public function notifyRemove( vo:ValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            if ( hasEventListener( _sRemoveType ) )
            {
                dispatchEvent( createNewModelObjectEvent( _sRemoveType , vo ) ) ;
            }
        }
        
        /**
         * Notify a <code class="prettyprint">ModelObjectEvent</code> when a <code class="prettyprint">ValueObject</code> is updated in the model.
         */ 
        public function notifyUpdate( vo:ValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            if ( hasEventListener( _sUpdateType ) )
            {
                dispatchEvent( createNewModelObjectEvent( _sUpdateType , vo ) ) ;
            }
        }
        
        /**
         * Removes a value object in the model.
         */
        public function removeVO( vo:ValueObject ):void
        {
            if (vo == null)
            {
                throw new ArgumentError( this + " removeVO method failed, the ValueObject passed in argument not must be 'null' or 'undefined'.") ;    
            }    
            validate(vo) ;
            if ( _map.containsKey( vo.id ) )
            {
                _map.remove( vo.id ) ;
                notifyRemove( vo ) ;
            }
            else
            {
                throw new ArgumentError( this + " removeVO method failed, the id passed in argument allready register in the model, you must remove this 'id' key before add a noew value object.") ;    
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
         * Update a value object in the model.
         * @throws Warning if the value object passed-in argument don't exist.
         */
        public function updateVO( vo:ValueObject ):void
        {
            if ( _map.containsKey( vo.id ) )
            {
                _map.put( vo.id , vo ) ;
                notifyUpdate(vo) ;
            }
            else
            {
                throw new ArgumentError( this + " updateVO method failed, the value object passed in argument don't exist in the model.") ;
            }
        }
        
        /**
         * The internal map of this model.
         */
        protected var _map:Map ;
        
        /**
         * The internal ModelObjectEvent type use in the addVO method.
         */
        protected var _sAddType:String ;
        
        /**
         * The internal ModelObjectEvent type use in the removeVO method.
         */
        protected var _sRemoveType:String ;
        
        /**
         * The internal ModelObjectEvent type when the update event type is use.
         */
        protected var _sUpdateType:String ;
    }
}
