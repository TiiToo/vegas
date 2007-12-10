<?php

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

/**
 * This class provides a binary filter value object.
 * <p><b>Example :</b></p>
 * {@code
 * function trace( $message )
 * {
 *     echo $message . "<br>" ;
 * }
 * 
 * $VIDEO  = 1 ;
 * $MP3    = 2 ; 
 * 
 * $filter = new FilterVO() ;
 * 
 * trace( "filter : " .  $filter ) ;
 * trace( "filter.isNone : " . $filter->isNone() ) ;
 * 
 * trace("") ;
 * 
 * $filter->toggleFilter( $VIDEO , true ) ;
 * trace( "filter : " .  $filter ) ;
 * trace( "filter.isNone : " . $filter->isNone() ) ;
 * 
 * trace("") ;
 * 
 * trace( "filter.toggleFilter( VIDEO, true ) : " . $filter->toggleFilter( $VIDEO , true ) ) ;
 * trace( "filter.toggleFilter( MP3, true )   : " . $filter->toggleFilter( $MP3   , true ) ) ;
 * trace( "filter : " .  $filter ) ;
 * 
 * trace("") ;
 * 
 * $filter->toggleFilter( $VIDEO , false ) ;
 * 
 * trace( "filter : " .  $filter ) ;
 * trace( "filter.contains( VIDEO ) : " . $filter->contains( $VIDEO ) ) ;
 * trace( "filter.contains( MP3 )   : " . $filter->contains( $MP3 ) ) ;
 * }
 * @author eKameleon
 */
class FilterVO 
{

    /**
	 * Creates a new FilterVO instance.
	 */
	function FilterVO ( $filter /*Number*/ = 0 ) 
	{
		if (isset($filter))
		{
			$this->setFilter($filter);	
		}
    } 
    
   	/**
	 * The default filter value of the filter value objects.
	 */
	const NONE /*Number*/ = 0 ;

	/**
	 * The filter value of this object.
	 */
	var $filter /*Number*/;

	/**
	* Clear the filter value.
	*/
	public function clear()
	{
		$this->filter = FilterVO::NONE ;
	}

	/**
	 * Returns {@code true} if the filter number value contains the option number value.
	 * @return {@code true} if the filter number value contains the option number value.
	 */
	public function contains( $value /*Number*/ )
	{
		return $value & $this->getFilter() ;
	}
	
	/**
	 * Returns the current filter value of this object.
	 * @return the current filter value of this object.
	 */
	public function getFilter()
	{
		return is_nan( $this->filter ) ? FilterVO::NONE : $this->filter ;
	}

	/**
	 * Returns {@code true} if the filter is NONE.
	 * @return {@code true} if the filter is NONE.
	 */
	public function isNone()
	{
		return $this->getFilter() == FilterVO::NONE ;
	}
	
	/**
	 * Sets the current filter value of this object.
	 */
	public function setFilter( $filter /*Number*/ )
	{
		$this->filter = (is_nan($filter) || empty($filter) ) ? FilterVO::NONE : $filter ;
	}

	/**
	 * Toggles a filter value in this filter object.
	 */
	public function toggleFilter( $value /*Number*/, $b /*Boolean*/ )
	{
		$old = $this->filter ;
		$this->filter = $b ? ( $this->filter | $value ) : ( $this->filter & ~ $value ) ;
		return $old != $this->filter ;
	}

	/**
	 * Returns a String representation of the object.
	 * @return a String representation of the object.
	 */
	public function __toString() /*String*/
	{
		return "[FilterVO " . $this->getFilter() . "]" ;
    }


}

?>
