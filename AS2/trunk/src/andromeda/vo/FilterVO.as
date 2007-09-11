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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import andromeda.model.SimpleValueObject;

import vegas.util.ConstructorUtil;
import vegas.util.serialize.Serializer;

/**
 * This class provides a binary filter value object.
 * <p><b>Example :</b></p>
 * {@code
 * 
 * var VIDEO:Number = 1 ;
 * var MP3:Number = 2 ; 
 * 
 * var filter:FilterVO = new FilterVO() ;
 * 
 * trace( "filter : " +  filter ) ;
 * 
 * filter.toggleFilter( VIDEO , true ) ;
 * 
 * trace( "filter : " +  filter ) ;
 * 
 * trace( "filter.toggleFilter( MP3, true ) : " + filter.toggleFilter( ProductFilter.TRAINING, true ) ) ;
 * trace( "filter.toggleFilter( MP3, true ) : " + filter.toggleFilter( ProductFilter.TRAINING, true ) ) ;
 * 
 * trace("filter : " +  filter ) ;
 * 
 * filter.toggleFilter( VIDEO , false ) ;
 * 
 * trace( "filter : " +  filter ) ;
 * 
 * trace( "filter.contains( VIDEO ) : " + filter.contains( VIDEO ) ) ;
 * trace( "filter.contains( MP3 ) : " + filter.contains( MP3 ) ) ;
 * }
 * @author eKameleon
 */
class andromeda.vo.FilterVO extends SimpleValueObject 
{
	
	/**
	 * Creates a new FilterVO instance. 
	 */	
	public function FilterVO( filter:Number ) 
	{
		setFilter(filter) ;	
	}
	
	/**
	 * The default filter value of the filter value objects.
	 */
	public static var NONE:Number = 0 ;
	
	/**
	 * The filter value of this object.
	 */
	public var filter:Number ;
	
	/**
	 * Clear the filter value.
	 */
	public function clear():Void
	{
		filter = NONE ;
	}
	
	/**
	 * Returns {@code true} if the filter number value contains the option number value.
	 * @return {@code true} if the filter number value contains the option number value.
	 */
	public function contains( value:Number ) : Boolean
	{
		return Boolean( value & getFilter() ) ;
	}
	
	/**
	 * Returns the current filter value of this object.
	 * @return the current filter value of this object.
	 */
	public function getFilter():Number
	{
		return isNaN( filter ) ? NONE : filter ;
	}

	/**
	 * Returns {@code true} if the filter is NONE.
	 * @return {@code true} if the filter is NONE.
	 */
	public function isNone():Boolean
	{
		return getFilter() == NONE ;
	}

	/**
	 * Sets the current filter value of this object.
	 */
	public function setFilter( n:Number ):Void
	{
		filter = isNaN(n) ? NONE : n ;
	}

	/**
	 * Toggle a filter value in this filter object.
	 */
	public function toggleFilter( value:Number, b:Boolean ):Boolean
	{
		var old:Number = filter ;
		filter = b ? ( filter | value ) : ( filter & ~value ) ;
		return old != filter ;
	}
	
	/**
	 * Returns the Object representation of this object.
	 * @return the Object representation of this object.
	 */
	public function toObject():Object
	{
		return { filter:filter } ;
	}
	
	/**
	 * Returns the eden source representation of this object.
	 * @return the eden source representation of this object.
	 */
	public function toSource():Object
	{
		return Serializer.getSourceOf( this, [ Serializer.toSource( filter ) ]  ) ;
	}
	
	/**
	 * Returns the String representation of this object.
	 * @return the String representation of this object.
	 */
	public function toString():Object
	{
		return "[" + ConstructorUtil.getName(this) + ":" + filter + "]" ;
	}
	
}