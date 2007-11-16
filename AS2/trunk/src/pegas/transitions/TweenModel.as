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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import andromeda.model.AbstractModel;

import pegas.events.TweenEntryEvent;
import pegas.transitions.TweenEntry;

import vegas.data.Map;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.map.HashMap;
import vegas.errors.IllegalArgumentError;
import vegas.util.TypeUtil;

/**
 * The model of the Tween class.
 * @author eKameleon
 */
class pegas.transitions.TweenModel extends AbstractModel implements Iterable 
{
	
	/**
	 * Creates a new TweenModel instance.
	 * @param id the id of the model.
	 * @param tweens The array to initialize the model with some TweenEntry objects. All no TweenEntry objects are ignored.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 * @param tweens an array of TweenEntry objects. 
	 */
	public function TweenModel( id , tweens:Array, bGlobal:Boolean , sChannel:String ) 
	{
		super( id,  bGlobal , sChannel ) ;
		_map = new HashMap() ;
		initEvent() ;
		var size:Number = tweens.length ;
		if (size > 0) 
		{
			for (var i:Number = 0 ; i < size ; i++) 
			{
				var t:TweenEntry = tweens[i] ;
				if ( t != null && t instanceof TweenEntry )
				{
					insert( t.clone() ) ;
				}
			}
		}
	}

	/**
	 * Returns a shallow copy of this object. This method keep all Tween entries and the id of the original object.
	 * {@code  var clone:TweenModel = tp.clone() ;}
	 * @return a shallow copy of this object.
	 */
	public function clone() 
	{
		return new TweenModel( null , toArray( ) ) ;
	}

	/**
	 * Clear the model.
	 */
	public function clear():Void 
	{
		_map.clear( ) ;
		dispatchEvent( _eClear ) ;
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
	 * Returns the event name use in the {@code insert} method.
	 * @return the event name use in the {@code insert} method.
	 */
	public function getEventTypeADD():String
	{
		return _eAdd.getType() ;
	}

	/**
	 * Returns the event name use in the {@code clear} method.
	 * @return the event name use in the {@code clear} method.
	 */
	public function getEventTypeCLEAR():String
	{
		return _eClear.getType() ;
	}


	/**
	 * Returns the event name use in the {@code remove} method.
	 * @return the event name use in the {@code remove} method.
	 */
	public function getEventTypeREMOVE():String
	{
		return _eRemove.getType() ;
	}

	/**
	 * Returns the Array representation of all property names in this model.
	 * @return the Array representation of all property names in this model.
	 */
	public function getProperties():Array 
	{
		return _map.getKeys( ) ;
	}
	
	/**
	 * Initialize the events of this model.
	 */
	public function initEvent():Void
	{
		_eAdd    = new TweenEntryEvent( TweenEntryEvent.ADD_ENTRY    , this ) ;
		_eClear  = new TweenEntryEvent( TweenEntryEvent.CLEAR_ENTRY  , this ) ;
		_eRemove = new TweenEntryEvent( TweenEntryEvent.REMOVE_ENTRY , this ) ;
	}

	/**
	 * Inserts a new TweenEntry in the model.
	 */
	public function insert( entry:TweenEntry ):Boolean 
	{
		var p:String = entry.prop ;
		if ( p ) 
		{
			_map.put( p, entry ) ;
			_eAdd.setTweenEntry(entry) ;
			dispatchEvent( _eAdd ) ;
			return true ;
		}
		else 
		{
			return false ;
		}
	}

	/**
	 * Returns an iterator of this model.
	 * @return an iterator of this model.
	 */
	public function iterator():Iterator 
	{
		return _map.iterator( ) ;
	}

	/**
	 * Removes an entry in the model.
	 */
	public function remove( entry:Object ):Boolean 
	{
		var p:String ;
		if (TypeUtil.typesMatch( entry, String )) 
		{
			p = String( entry ) ;
		}
		else if (TypeUtil.typesMatch( entry, TweenEntry )) 
		{
			p = entry.prop ;
		}
		else 
		{
			throw new IllegalArgumentError(this + " remove method failed with an unknow argument value : " + entry ) ;
		} 
		if (p) 
		{
			var t:TweenEntry = _map.remove( p ) ;
			if (t != null) 
			{
				_eRemove.setTweenEntry( t ) ;
				dispatchEvent( _eRemove ) ;
				return true ;
			}
		} 
		else 
		{
			return false ;
		}
	}


	/**
	 * Sets the event name use in the {@code insert} method.
	 */
	public function setEventTypeADD( type:String ):Void
	{
		_eAdd.setType( type ) ;
	}

	/**
	 * Sets the event name use in the {@code clear} method.
	 */
	public function setEventTypeCLEAR( type:String ):Void
	{
		_eClear.setType( type ) ;
	}

	/**
	 * Sets the event name use in the {@code remove} method.
	 */
	public function setEventTypeREMOVE( type:String ):Void
	{
		_eRemove.setType( type ) ;
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
		return _map.getValues( ) ;
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
			s += ":" + _map.toString() ;
		}
		s += "]" ;
		return s ;
	}
	
	/**
	 * @private
	 */
	private var _eAdd:TweenEntryEvent ;
	
	/**
	 * @private
	 */
	private var _eClear:TweenEntryEvent ;
	
	/**
	 * @private
	 */
	private var _eRemove:TweenEntryEvent ;
	
	/**
	 * @private
	 */
	private var _map:HashMap ;
	
}