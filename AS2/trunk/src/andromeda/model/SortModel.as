/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */
import andromeda.model.AbstractModel;

import vegas.data.array.ArrayFilter;
import vegas.data.map.HashMap;
import vegas.errors.IllegalArgumentError;
import vegas.events.BasicEvent;

/**
 * This model defines a sort ArrayFilter model.
 * @author eKameleon
 */
class andromeda.model.SortModel extends AbstractModel 
{
	
	/**
	 * Creates a new SortModel instance.
	 * @param id the id of the model.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	function SortModel( id , bGlobal:Boolean , sChannel:String ) 
	{
		super(id, bGlobal, sChannel);
		_map = new HashMap() ;
		_eChange = new BasicEvent( CHANGE , this ) ;
	}
	
	/**
	 * The type name of the change event of this model.
	 */
	public static var CHANGE:String = "change" ;
	
	/**
	 * Adds a field name to sort in the lists.
	 * @param fieldName the field name value to sort.
	 * @param filter The ArrayFilter to use to sort the field name. If this value is null an empty ArrayFilter is use.
	 * @throws IllegalArgumentError If the specified fieldName argument is 'null' or 'undefined'
	 * @throws IllegalArgumentError If the specified fieldName argument is already exist in the model.
	 */
	public function addFieldName( fieldName:String , filter:ArrayFilter ):Void
	{
		if ( fieldName == null )
		{
			throw new IllegalArgumentError(this + " addFieldName field name failed with a 'null' or 'undefined' fieldName argument." ) ;
		}
		else if ( containsFieldName( fieldName ) )
		{
			throw new IllegalArgumentError(this + " addFieldName field name failed with an already register or empty field name in the model : " + fieldName ) ;
		}
		else
		{
			filter = filter || new ArrayFilter() ;
			filter.setDescending( isDescending() ) ; 
			_map.put( fieldName , filter ) ;	
		}
	}

	/**
	 * Removes all elements in this model.
	 */
	public function clear():Void
	{
		_currentFieldName = null ;
		_map.clear() ;
	}
	
	/**
	 * Returns {@code true} if the model contains the specified field name.
	 * @return {@code true} if the model contains the specified field name.
	 */
	public function containsFieldName( fieldName:String ):Boolean
	{
		return _map.containsKey( fieldName ) ;
	}

	/**
	 * Returns the current field name selected in this model.
	 * @return the current field name selected in this model.
	 */	
	public function getCurrentFieldName():String
	{
		return 	_currentFieldName || null  ;
	}

	/**
	 * Returns the current field filter selected in this model.
	 * @return the current field filter selected in this model.
	 */	
	public function getCurrentFilter():ArrayFilter
	{
		if ( _currentFieldName != null )
		{
			return _map.get( _currentFieldName ) || null  ;
		}
		else
		{
			return null ;
		}
	}

	/**
	 * Returns the event name use when the model change.
	 * @return the event name use when the model change.
	 */
	public function getEventTypeCHANGE():String
	{
		return _eChange.getType() ;
	}

	/**
	 * Returns {@code true} if the DESCENDING option value exist in the current filter.
	 * @return {@code true} if the DESCENDING option value exist in the current filter.
	 */
	public function isDescending():Boolean
	{
		return _isDescending ;	
	}
	
	/**
	 * Invoqued if the internal StyleSheet object  change.
	 */
	public function notifyChange( noEvent:Boolean ):Void
	{
		if ( noEvent == true  ) 
		{
			return ;
		}
		else
		{
			dispatchEvent( _eChange  ) ;
		}
	}

	/**
	 * Adds a field name to sort in the lists.
	 * @param fieldName the field name value to sort.
	 * @param filter The ArrayFilter to use to sort the field name. If this value is null an empty ArrayFilter is use.
	 * @throws IllegalArgumentError If the specified fieldName argument isn't register in the model.
	 */
	public function removeFieldName( fieldName:String  ):Void
	{
		if ( containsFieldName( fieldName ) )
		{
			_map.remove(fieldName) ;
		}
		else
		{
			throw new IllegalArgumentError(this + " removeFieldName failed with a no register or empty field name : " + fieldName ) ;	
		}
	}

	/**
	 * Sets if the DESCENDING option value exist in the current filter.
	 */
	public function setDescending( b:Boolean , noEvent:Boolean ):Void
	{
		var old:Boolean = _isDescending ;
		if ( old == b )
		{
			
		}
		else
		{
			_isDescending = b ;
			var size:Number = size() ;
			if ( size > 0 )
			{
				var filters:Array = _map.getValues() ;
				while ( --size > -1 )
				{
					ArrayFilter( filters[size] ).setDescending( _isDescending ) ;	
				} 
			}
			notifyChange(noEvent) ;
		}
	}
	
	/**
	 * Sets the current field name selected in this model.
	 */	
	public function setCurrentFieldName( fieldName:String , isDescending:Boolean , noEvent:Boolean ):Void
	{
		if ( containsFieldName( fieldName ) )
		{
			_currentFieldName = fieldName ;
			
			if ( arguments.length == 2 )
			{
				setDescending( isDescending , true ) ;		
			}
			
			notifyChange( noEvent ) ;
		}
		else
		{
			_currentFieldName = null ;
			getLogger().warn(this + " setCurrentFieldName failed with a no register or empty field name : " + fieldName ) ;	
		}
	} 
	
	/**
	 * Returns the event name use when the model change.
	 * @return the event name use when the model change.
	 */
	public function setEventTypeCHANGE( type:String ):Void
	{
		_eChange.setType( type ) ;
	}

	/**
	 * Returns the numbers of fieldName who can be sorting in the application.
	 * @return the numbers of fieldName who can be sorting in the application.
	 */
	public function size():Number
	{
		return _map.size() ;
	}

	/**
	 * Indicates the current selected field name of this model.
	 */
	private var _currentFieldName:String ;
	
	/**
	 * The internal Event use when the model change.
	 */
	private var _eChange:BasicEvent ;

	/**
	 * Indicates if the lists of the application are descending or not.
	 */		
	private var _isDescending:Boolean = false ;
	
	/**
	 * The internal map used to register the fieldName and the corresponding ArrayFilters.
	 */
	private var _map:HashMap ;

}