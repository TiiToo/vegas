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
 * A SortedArrayList stores is elements in order with a IComparator object.
 * @author eKameleon
 */
if (vegas.data.list.SortedArrayList == undefined) 
{

	/**
	 * Creates a new SortedArrayList instance. 
	 */
	vegas.data.list.SortedArrayList = function ( o , comp /*IComparator*/ , opt /*Number*/ ) 
	{ 
		
		vegas.data.list.ArrayList.apply(this, arguments) ;
		
		this.setComparator( comp ) ;
		
		this.setOptions(opt) ;
		
	}
	
	/**
	 * @extends vegas.data.list.AbstractList
	 */
	proto = vegas.data.list.SortedArrayList.extend(vegas.data.list.AbstractList) ;

	/**
	 * Returns a shallow copy of the instance.
	 * @return a shallow copy of the instance.
	 */
	proto.clone = function() 
	{
		return new vegas.data.list.SortedArrayList( this.toArray() ) ;
	}
	
	/**
	 * Inserts a new element in the list.
	 */
	proto.insert = function (o) 
	{
		var b /*Boolean*/ = this.__constructor__.prototype.insert.call(this, o) ;
		this._sort() ;
		return b ;
	}

	proto.insertAll = function (co /*Collection*/) 
	{
		if (co instanceof vegas.data.Collection) 
		{
			this.__constructor__.prototype__.insertAll.call(this, co) ;
			this._sort() ;
		}
	}

	proto.insertAt = function (id /*Number*/, o) /*void*/ 
	{
		this.__constructor__.prototype.insertAt.call(this, id, o) ;
		this._sort() ;
	}

	proto.insertAllAt = function (id/*Number*/, c /*Collection*/) /*Boolean*/ 
	{
		var b /*Boolean*/ = this.__constructor__.prototype.insertAllAt.call(this, id, c) ;
		this._sort() ;
		return b ;
	}

	proto.getComparator = function () /*IComparator*/ 
	{
		return this._comparator ;
	}

	proto.getOptions = function () 
	{
		return this._options ;
	}
		
	proto.setComparator = function (comp /*IComparator*/ ) /*Void*/ 
	{
		this._comparator = comp ;
	}
	
	proto.setOptions = function (o) 
	{
		this._options = o ;
	}
	
	proto.sort = function ( compare , options /*Number*/ ) /*Array*/  
	{
		if (typeof(compare) != "function" || !(compare instanceof IComparator)) 
		{
			return null ;
		}
		if (options) 
		{
			this._options = options ;
		}
		var compareFunc /*Function*/ = (compare instanceof IComparator) ? compare.compare : compare ;
		return this._a.sort(compareFunc , _options) ;
	}
	
	proto._comparator = null ;

	proto._sort = function () 
	{
		if (this._comparator instanceof vegas.core.IComparator)
		{
			this.sort( this._comparator.compare , this._options) ;
		}
	}
	
	delete proto ;
	
}