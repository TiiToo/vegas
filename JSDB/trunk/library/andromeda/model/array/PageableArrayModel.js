/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedA Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Defines an array model with a 'page by page' iterator.
 * @author eKameleon
 */
if ( andromeda.model.array.PageableArrayModel == undefined) 
{

	/**
	 * @requires andromeda.model.array.PageableArrayModel
	 */
	require("andromeda.model.AbstractModelObject") ;

	/**
	 * Creates a new PageableArrayModel instance.
	 * @param id the id of this model.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	andromeda.model.array.PageableArrayModel = function ( id , bGlobal /*Boolean*/ , sChannel /*String*/ ) 
	{ 
		andromeda.model.AbstractModelObject.call( this , id, bGlobal, sChannel ) ; // super
		this._a = new Array() ;
	}
	
	/**
	 * @extends andromeda.model.AbstractModelObject
	 */
	proto = andromeda.model.array.PageableArrayModel.extend( andromeda.model.AbstractModelObject ) ;
	
	/**
	 * Inserts all IValueObject in the array passed in argument.
	 * @param datas The array of all value objects to insert in the model.
	 * @param noClear (optional) If this argument is is {@code true} the clear method isn't called. 
	 */
	proto.addAllVO = function( datas /*Array*/ , noClear/*Boolean*/) /*void*/
	{
		if ( noClear != true )
		{
			this.clear() ;
		}
		var len /*Number*/ = datas.length ;
		for (var i /*Number*/ = 0 ; i<len ; i++)
		{
			var vo /*IValueObject*/ = datas[i] ;
			if ( this.supports( vo ) )
			{
				this._a.push( vo ) ;
			}	
		}
		this.refresh() ;
	}

	/**
	 * Clear the model.
	 */	
	proto.clear = function() /*void*/
	{
		this._a = []  ;
		andromeda.model.AbstractModelObject.prototype.clear.call(this) ; // super.clear()
	}

	/**
	 * Returns the count of the IValueObject in a page of this model.
	 * @return the count of the IValueObject in a page of this model.
	 */
	proto.getCountVO = function() /*Number*/
	{
		return this._voCount ;
	}

	/**
	 * Returns the event name use in the {@code addVO} method.
	 * @return the event name use in the {@code addVO} method.
	 */
	proto.getEventTypeUPDATE = function() /*String*/
	{
		return this._eUpdate.getType() ;
	}

	/**
	 * Returns the current page selected in the model.
	 * @return the current page selected in the model.
	 */
	proto.getCurrentPage = function() /*Number*/
	{
		return this._itPage.currentPage() ;	
	}

	/**
	 * Returns the numbers of page with the current model.
	 * @return the numbers of page with the current model.
	 */
	proto.getPageCount = function() /*Number*/
	{
		return this._itPage.pageCount() ;	
	}

	/**
	 * Returns {@code true} if the list has a next page.
	 * @return {@code true} if the list has a next page.
	 */
	proto.hasNext = function() /*Boolean*/
	{
		return this._itPage.hasNext() ;
	}
	
	/**
	 * Returns {@code true} if the list has a previous page.
	 * @return {@code true} if the list has a previous page.
	 */
	proto.hasPrevious = function() /*Boolean*/
	{
		return this._itPage.hasPrevious() ;
	}

	/**
	 * This method is invoqued in the constructor of the class to initialize all events.
	 */
	/*override*/ proto.initEvent = function() /*void*/
	{
		andromeda.model.AbstractModelObject.prototype.initEvent.call(this) ;
		this._eUpdate = new ArrayEvent( andromeda.events.ModelObjectEvent.UPDATE_VO ) ;
	}

	/**
	 * Returns a PageByPageIterator of this model.
	 * @return a PageByPageIterator of this model.
	 */
	proto.iterator = function() /*Iterator*/
	{
		return new vegas.data.iterator.PageByPageIterator( this._voCount, this._a) ;	
	}

    /**
     * Notify a {@code ModelObjectEvent} when a {@code IValueObject} is inserted in the model.
     */ 
    proto.notifyUpdate = function( ar /*Array*/ ) /*Array*/
    {
        if ( this.isLocked() == false )
        {
        	this._eUpdate.setArray( ar ) ;
			this.dispatchEvent( this._eUpdate  ) ;    
        }
        return ar ;
    }

	/**
	 * Show in the previous page in the list or previous screen.
	 */
	proto.previous = function()
	{
		if ( this.hasPrevious() )
		{
			return this.notifyUpdate( this._itPage.previous() ) ;
		}
		else
		{
			return null ;
		}
	}
	
	/**
	 * Show the next page of the model.
	 */
	proto.next = function()
	{
		if ( this.hasNext() )
		{
			return this.notifyUpdate( this._itPage.next() ) ;
		}
		else
		{
			return null ;
		}
	}

	/**
	 * Refresh the model.
	 */
	proto.refresh = function() /*void*/
	{
		if ( this.size() > 0)
		{
			this._itPage = new vegas.events.PageByPageIterator ( this._voCount , this._a ) ;
		}
		else
		{
			this._itPage = null ;	
		}
		this.run() ;
	}
	
	/**
	 * Run the model when is initialize.
	 */
	proto.run = function() /*void*/
	{
		this.next() ;
	}

	/**
	 * Set the count of the IValueObject in a page of this model.
	 */
	proto.setCountVO = function ( n /*Number*/ ) /*void*/
	{
		this._voCount = n > 0 ? n : 0 ;
		this.refresh() ;
	}

	/**
	 * Sets the event name use in the {@code addVO} method.
	 */
	proto.setEventTypeUPDATE = function( type /*String*/ ) /*void*/
	{
		this._eUpdate.setType( type ) ;
	}

	/**
	 * Returns the number of elements in the model.
	 * @return the number of elements in the model.
	 */
	proto.size = function() /*Number*/
	{
		return this._a.length ;	
	}

	/**
	 * Returns the array representation of all vos in this model.
	 * @return the array representation of all vos in this model.
	 */
	proto.toArray = function() /*Array*/
	{
		return [].contact( this_a ) ;	
	}

	/**
	 * The internal array of all elements.
	 */
	proto._a /*Array*/ = null ; 

	/**
	 * The internal ArrayEvent when the update event type is use.
	 */
	proto._eUpdate /*ArrayEvent*/ = null ;

	/**
	 * The current PageByPageIterator instance.
	 */
	proto._itPage /*PageByPageIterator*/ = null ;
	
	/**
	 * The numbers of items in the list (16 default icons in the list).
	 */
	proto._voCount /*Number*/ = 1 ;

	// encapsulate
	
	delete proto ;

}