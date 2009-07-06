/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
 
package pegas.transitions 
{
    import andromeda.model.CoreModel;
    
    import pegas.events.TweenEntryEvent;
    
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.Map;
    import system.data.maps.HashMap;
    
    /**
     * The model of the Tween class.
     */
    public class TweenModel extends CoreModel implements Iterable 
    {

        /**
         * Creates a new TweenModel instance.
         * @param id the id of the model.
         * @param tweens The array to initialize the model with some TweenEntry objects. All no TweenEntry objects are ignored.
         */
        public function TweenModel(id:* = null, tweens:Array=null )
        {
            super( id ) ;
            _map = new HashMap() ;
            if ( tweens == null ) 
            {
                return ;
            }
            var size:int = tweens.length ;
            if (size > 0) 
            {
                var t:TweenEntry ;
                for (var i:int ; i < size ; i++ ) 
                {
                    t = tweens[i] as TweenEntry ;
                    if ( t != null )
                    {
                        add( t.clone() ) ;
                    }
                }
            }
        }
        
        /**
         * Inserts a new TweenEntry in the model.
         */
        public function add( entry:TweenEntry ):Boolean 
        {
            if ( entry == null )
            {
               	throw new ArgumentError(this + " insert method failed, the entry parameter not must be null.") ;
            }
            var p:String = entry.prop ;
            if ( p != null ) 
            {
                _map.put( p, entry ) ;
                dispatchEvent( new TweenEntryEvent( TweenEntryEvent.ADD_ENTRY , this, entry ) ) ;
                return true ;
            }
            else 
            {
                return false ;
            }
        }
        
        /**
         * Removes all elements register in the model.
         */
        public function clear():void 
        {
            _map.clear( ) ;
            dispatchEvent( new TweenEntryEvent( TweenEntryEvent.CLEAR_ENTRY  , this ) ) ;
        }
        
        /**
         * Returns a shallow copy of this object. This method keep all Tween entries and the id of the original object.
         * <pre class="prettyprint"> 
         * var model:TweenModel = new TweenModel() ; 
         * var clone:TweenModel = model.clone() as TweenModel ;
         * </pre>
         * @return A shallow copy of this object.
         */
        public function clone():*
        {
            return new TweenModel( null , toArray() ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the specified property exist in this model.
         * @return <code class="prettyprint">true</code> if the specified property exist in this model.
         */
        public function contains( prop:String ):Boolean 
        {
            return _map.containsKey( prop ) ;
        }
        
        /**
         * Returns the specified TweenEntry reference.
         * @return the specified TweenEntry reference.
          */
        public function get( prop:String ):TweenEntry 
        {
            return _map.get( prop ) ;
        }
        
        /**
         * Returns the Array representation of all property names in this model.
         * @return the Array representation of all property names in this model.
         */
        public function getProperties():Array 
        {
            return _map.getKeys() ;
        }
        
        
        /**
         * Returns an iterator of this model.
         * @return an iterator of this model.
         */
        public function iterator():Iterator
        {
            return _map.iterator() ;
        }
        
        /**
         * Removes an entry in the model.
         */
        public function remove( entry:* ):Boolean 
        {
            var p:String ;
            if ( entry is String ) 
            {
                p = entry as String ;
            }
            else if ( entry is TweenEntry ) 
            {
                p = entry.prop ;
            }
            else 
            {
                throw new ArgumentError(this + " remove method failed with an unknow argument value : " + entry ) ;
            } 
            if ( contains(p) ) 
            {
                var t:TweenEntry = _map.remove( p ) ;
                if ( t != null )
                {
                    dispatchEvent( new TweenEntryEvent( TweenEntryEvent.REMOVE_ENTRY , this , t ) ) ;
                    return true ;
                }
            } 
            return false ;
        }
        
        /**
         * Returns the number of elements in the model.
         * @return the number of elements in the model.
         */
        public function size():Number 
        {
            return _map.size( ) ;
        }

        /**
         * Returns the Array representation of all TweenEntry objects in this model.
         * @return the Array representation of all TweenEntry objects in this model.
         */
        public function toArray():Array 
        {
            return _map.getValues() ;
        }
                
        /**
         * Returns the Map representation of all TweenEntry objects in this model.
          * @return the Map representation of all TweenEntry objects in this model.
          */
        public function toMap():Map 
        {
            return _map.clone() ;
        }
        
        /**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
        public function toString():String 
        {
            var s:String = "[TweenModel" ; 
            if ( _map.size() > 0 )
            {
                s += ":" + (_map as Object).toString() ;
            }
            s += "]" ;
            return s ;
        }
        
        /**
         * @private
         */
        private var _map:Map ;
        
    }
}
