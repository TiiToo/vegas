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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * This filter contains all constants and methods to sort the Arrays in the application.
 * <p><b>Example : </b></p>
 * {@code
 * 
 * ArrayFilter = vegas.data.array.ArrayFilter ;
 * Delegate    = vegas.events.Delegate ;
 * 
 * var debug = function ()
 * {
 *     trace("filter : " + af.filter ) ;
 *     trace("is NONE               : " + af.isNone() )
 *     trace("is CASEINSENSITIVE    : " + af.isCaseInsensitive() ) ;
 *     trace("is DESCENDING         : " + af.isDescending() ) ;
 *     trace("is NUMERIC            : " + af.isNumeric() ) ;
 *     trace("is RETURNINDEXEDARRAY : " + af.isReturnIndexedArray() ) ;
 *     trace("is UNIQUESORT         : " + af.isUniqueSort() ) ;
 *     trace("---") ;
 * }
 * 
 * var change = function ( e )
 * {
 *     trace( e ) ;
 * }
 * 
 * var af = ArrayFilter.getInstance() ;
 * af.addEventListener( ArrayFilter.CHANGE, new Delegate(this, change ) ) ;
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
 * 
 * }
 * @author eKameleon
 */
if (vegas.data.array.ArrayFilter == undefined) 
{
	
	/**
	 * @requires vegas.events.AbstractCoreEventDispatcher
	 */
	require("vegas.events.AbstractCoreEventDispatcher") ;
	
	/**
	 * Creates a new ArrayFilter instance.
	 * @param value the default filter value of this instance. If this argument is null the filter value is ArrayFilter.NONE(0).
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	vegas.data.array.ArrayFilter = function ( value /*Number*/ , bGlobal /*Boolean*/ , sChannel /*String*/ ) 
	{ 
		vegas.events.AbstractCoreEventDispatcher.apply(this, Array.fromArguments(arguments)) ;
		this._eChange = new vegas.events.BasicEvent( vegas.data.array.ArrayFilter.CHANGE , this ) ;
		this.setFilter( value ) ;
	}

	/**
	 * @extends vegas.events.AbstractCoreEventDispatcher
	 */
	vegas.data.array.ArrayFilter.extend( vegas.events.AbstractCoreEventDispatcher ) ;

   	/**
     * Specifies case-insensitive sorting for the Array class sorting methods. You can use this constant
	 * for the <code>options</code> parameter in the <code>sort()</code> or <code>sortOn()</code> method. 
	 * <p>The value of this constant is 1.</p>
	 */
	vegas.data.array.ArrayFilter.CASEINSENSITIVE /*Number*/ = 1 ;
	
	/**
	 * The change event occurs when the filter value is changed.
	 */
	vegas.data.array.ArrayFilter.CHANGE /*String*/ = "change" ;
	
	/**
     * Specifies descending sorting for the Array class sorting methods. 
 	 * You can use this constant for the <code>options</code> parameter in the <code>sort()</code>
 	 * or <code>sortOn()</code> method. 
 	 * <p>The value of this constant is 2.</p>
	 */
	vegas.data.array.ArrayFilter.DESCENDING /*Number*/ = 2 ;

	/**
	 * Specifies the default numeric sorting value for the Array class sorting methods.
	 * <p>The value of this constant is 0.</p>
	 */
	vegas.data.array.ArrayFilter.NONE /*Number*/ = 0;

	/**
     * Specifies numeric (instead of character-string) sorting for the Array class sorting methods. 
     * Including this constant in the <code>options</code>
 	 * parameter causes the <code>sort()</code> and <code>sortOn()</code> methods 
	 * to sort numbers as numeric values, not as strings of numeric characters.  
     * Without the <code>NUMERIC</code> constant, sorting treats each array element as a 
 	 * character string and produces the results in Unicode order. 
 	 *
   	 * <p>For example, given the array of values <code>[2005, 7, 35]</code>, if the <code>NUMERIC</code> 
 	 * constant is <strong>not</strong> included in the <code>options</code> parameter, the 
   	 * sorted array is <code>[2005, 35, 7]</code>, but if the <code>NUMERIC</code> constant <strong>is</strong> included, 
   	 * the sorted array is <code>[7, 35, 2005]</code>. </p>
 	 * 
 	 * <p>This constant applies only to numbers in the array; it does 
   	 * not apply to strings that contain numeric data such as <code>["23", "5"]</code>.</p>
 	 * 
 	 * <p>The value of this constant is 16.</p>
	 */
	vegas.data.array.ArrayFilter.NUMERIC /*Number*/ = 16 ;
		
	/**
 	 * Specifies that a sort returns an array that consists of array indices as a result of calling
 	 * the <code>sort()</code> or <code>sortOn()</code> method. You can use this constant
 	 * for the <code>options</code> parameter in the <code>sort()</code> or <code>sortOn()</code> 
 	 * method, so you have access to multiple views on the array elements while the original array is unmodified. 
 	 * <p>The value of this constant is 8.</p>
 	 */
	vegas.data.array.ArrayFilter.RETURNINDEXEDARRAY /*Number*/ = 8 ;

	/**
   	 * Specifies the unique sorting requirement for the Array class sorting methods. 
     * You can use this constant for the <code>options</code> parameter in the <code>sort()</code> or <code>sortOn()</code> method. 
     * The unique sorting option terminates the sort if any two elements or fields being sorted have identical values. 
	 * <p>The value of this constant is 4.</p>
	 */
	vegas.data.array.ArrayFilter.UNIQUESORT /*Number*/ = 4 ;
	
	/**
	 * Indicates if the change event is notify or not when the filter value change.
	 */
	vegas.data.array.ArrayFilter.prototype.useEvent /*Boolean*/ = true ;
	
	/**
	 * Returns {@code true} if the filter number value contains the option number value.
	 * @return {@code true} if the filter number value contains the option number value.
	 */
	vegas.data.array.ArrayFilter.contains = function( nFilter/*Number*/, nOption/*Number*/ ) /*Boolean*/
	{
		return Boolean( nOption & nFilter ) ;
	}
	
	/**
	 * Returns the event name of the change event of this object.
	 * @return the event name of the change event of this object.
	 */
	vegas.data.array.ArrayFilter.prototype.getEventTypeCHANGE = function() /*String*/
	{
		return this._eChange.getType() ;
	}
	
	/**
	 * Returns the singleton reference of this class.
	 * @return the singleton reference of this class.
	 */
	vegas.data.array.ArrayFilter.getInstance = function() /*ArrayFilter*/
	{
		if (vegas.data.array.ArrayFilter._instance == null)
		{
			vegas.data.array.ArrayFilter._instance = new vegas.data.array.ArrayFilter() ;	
		}	
		return vegas.data.array.ArrayFilter._instance ;
	}
	
	/**
	 * Returns the current filter value of this object.
	 * @return the current filter value of this object.
	 */
	vegas.data.array.ArrayFilter.prototype.getFilter = function() /*Number*/
	{
		return isNaN(this._filter) ? vegas.data.array.ArrayFilter.NONE : this._filter ;
	}

	/**
	 * Returns {@code true} if the CASEINSENSITIVE option value exist in the current filter.
	 * @return {@code true} if the CASEINSENSITIVE option value exist in the current filter.
	 */
	vegas.data.array.ArrayFilter.prototype.isCaseInsensitive = function() /*Boolean*/
	{
		return vegas.data.array.ArrayFilter.contains( this.getFilter() , vegas.data.array.ArrayFilter.CASEINSENSITIVE ) ;	
	}
	
	/**
	 * Returns {@code true} if the DESCENDING option value exist in the current filter.
	 * @return {@code true} if the DESCENDING option value exist in the current filter.
	 */
	vegas.data.array.ArrayFilter.prototype.isDescending = function() /*Boolean*/
	{
		return vegas.data.array.ArrayFilter.contains( this.getFilter() , vegas.data.array.ArrayFilter.DESCENDING ) ;	
	}
	
	/**
	 * Returns {@code true} if the filter is NONE.
	 * @return {@code true} if the filter is NONE.
	 */
	vegas.data.array.ArrayFilter.prototype.isNone =function() /*Boolean*/
	{
		return this.getFilter() == vegas.data.array.ArrayFilter.NONE ;
	}

	/**
	 * Returns {@code true} if the NUMERIC option value exist in the current filter.
	 * @return {@code true} if the NUMERIC option value exist in the current filter.
	 */
	vegas.data.array.ArrayFilter.prototype.isNumeric = function() /*Boolean*/
	{
		return vegas.data.array.ArrayFilter.contains( this.getFilter() , vegas.data.array.ArrayFilter.NUMERIC ) ;	
	}
	
	/**
	 * Returns {@code true} if the RETURNINDEXEDARRAY option value exist in the current filter.
	 * @return {@code true} if the RETURNINDEXEDARRAY option value exist in the current filter.
	 */
	vegas.data.array.ArrayFilter.prototype.isReturnIndexedArray = function() /*Boolean*/
	{
		return vegas.data.array.ArrayFilter.contains( this.getFilter() , vegas.data.array.ArrayFilter.RETURNINDEXEDARRAY ) ;	
	}
	
	/**
	 * Returns {@code true} if the UNIQUESORT option value exist in the current filter.
	 * @return {@code true} if the UNIQUESORT option value exist in the current filter.
	 */
	vegas.data.array.ArrayFilter.prototype.isUniqueSort = function() /*Boolean*/
	{
		return vegas.data.array.ArrayFilter.contains( this.getFilter() , vegas.data.array.ArrayFilter.UNIQUESORT ) ;	
	}
	
	/**
	 * Notify a change in this object.
	 */
	vegas.data.array.ArrayFilter.prototype.notifyChange = function() /*Void*/
	{
		if ( this.useEvent == true )
		{
			this.dispatchEvent( this._eChange ) ;
		}	
	}
	
	/**
	 * Sets the CASEINSENSITIVE option value in the current filter.
	 */
	vegas.data.array.ArrayFilter.prototype.setCaseInsensitive = function( b /*Boolean*/ ) /*void*/
	{
		var old /*Number*/ = this._filter ;
		this._filter = b ? this._filter | vegas.data.array.ArrayFilter.CASEINSENSITIVE : this._filter & ~vegas.data.array.ArrayFilter.CASEINSENSITIVE ;
		if (this._filter != old)
		{
			this.notifyChange() ;
		}	
	}

	/**
	 * Sets the DESCENDING option value in the current filter.
	 */
	vegas.data.array.ArrayFilter.prototype.setDescending = function( b /*Boolean*/ ) /*void*/
	{
		var old /*Number*/ = this._filter ;
		this._filter = b ? this._filter | vegas.data.array.ArrayFilter.DESCENDING : this._filter & ~vegas.data.array.ArrayFilter.DESCENDING ;
		if (this._filter != old)
		{
			this.notifyChange() ;
		}
	}

	/**
	 * Sets the event name of the change event of this object.
	 */
	vegas.data.array.ArrayFilter.prototype.setEventTypeCHANGE = function ( type /*String*/ ) /*void*/
	{
		this._eChange.setType( type || vegas.data.array.ArrayFilter.CHANGE ) ;
	}

	/**
	 * Sets the current filter value of this object.
	 */
	vegas.data.array.ArrayFilter.prototype.setFilter = function( n /*Number*/ ) /*void*/
	{
		var old /*Number*/ = this._filter ;
		this._filter = isNaN(n) ? vegas.data.array.ArrayFilter.NONE : n ;
		if (this._filter != old)
		{
			this.notifyChange() ;
		}	
	}

	/**
	 * Sets the NONE option value in the current filter.
	 */
	vegas.data.array.ArrayFilter.prototype.setNone = function() /*void*/
	{
		var old /*Number*/ = this._filter ;
		this._filter = vegas.data.array.ArrayFilter.NONE ;
		if (this._filter != old)
		{
			this.notifyChange() ;
		}	
	}

	/**
	 * Sets the NUMERIC option value in the current filter.
	 */
	vegas.data.array.ArrayFilter.prototype.setNumeric = function( b /*Boolean*/ ) /*void*/
	{
		var old /*Number*/ = this._filter ;
		this._filter = b ? this._filter | vegas.data.array.ArrayFilter.NUMERIC : this._filter & ~vegas.data.array.ArrayFilter.NUMERIC ;
		if (this._filter != old)
		{
			this.notifyChange() ;
		}	
	}

	/**
	 * Sets the RETURNINDEXEDARRAY option value in the current filter.
	 */
	vegas.data.array.ArrayFilter.prototype.setReturnIndexedArray = function( b /*Boolean*/ ) /*void*/
	{
		var old /*Number*/ = this._filter ;
		this._filter = b ? this._filter | vegas.data.array.ArrayFilter.RETURNINDEXEDARRAY : this._filter & ~vegas.data.array.ArrayFilter.RETURNINDEXEDARRAY ;
		if (this._filter != old)
		{
			this.notifyChange() ;
		}	
	}
	
	/**
	 * Sets the UNIQUESORT option value in the current filter.
	 */
	vegas.data.array.ArrayFilter.prototype.setUniqueSort = function( b /*Boolean*/ ) /*void*/
	{
		var old /*Number*/ = this._filter ;
		this._filter = b ? this._filter | vegas.data.array.ArrayFilter.UNIQUESORT : this._filter & ~vegas.data.array.ArrayFilter.UNIQUESORT ;
		if (this._filter != old)
		{
			this.notifyChange() ;
		}	
	}

	/**
	 * The internal singleton reference.
	 */
	/*private*/ vegas.data.array.ArrayFilter._instance /*ArrayFilter*/ = null ;
	
	/**
	 * The internal change event reference.
	 */
	vegas.data.array.ArrayFilter.prototype._eChange /*Event*/ = null ;
	
	/**
	 * The filter value of this object.
	 */
	vegas.data.array.ArrayFilter.prototype._filter /*Number*/ ;
	
}