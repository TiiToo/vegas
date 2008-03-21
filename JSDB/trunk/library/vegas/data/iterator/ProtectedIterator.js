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
 * Protect an iterator. This class protect the remove, reset and seek method. 	
 * @author eKameleon 
 */
if (vegas.data.iterator.ProtectedIterator == undefined) 
{
	
	/**
	 * Creates a new ProtectedIterator instance.
	 * @param iterator the iterator to protected.
	 */
	vegas.data.iterator.ProtectedIterator = function ( it /*Iterator*/ ) 
	{ 
		this._i = it ;
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.data.iterator.ProtectedIterator.extend(vegas.core.CoreObject) ;

	/**
	 * Returns {@code true} if the iteration has more elements.
	 * @return {@code true} if the iteration has more elements.
	 */	
	vegas.data.iterator.ProtectedIterator.prototype.hasNext = function () 
	{
		return this._i.hasNext() ;
	}

	/**
	 * Returns the current key of the internal pointer of the iterator (optional operation).
	 * @return the current key of the internal pointer of the iterator (optional operation).
	 */
	vegas.data.iterator.ProtectedIterator.prototype.key = function() 
	{
		return this._i.key() ;
	}

	/**
	 * Returns the next element in the iteration.
	 * @return the next element in the iteration.
	 */
	vegas.data.iterator.ProtectedIterator.prototype.next = function () 
	{
		return this._i.next() ;
	}

	/**
	 * Unsupported method in all ProtectedIterator.
	 * @throws UnsupportedOperation the remove method is unsupported in a ProtectedIterator instance.
	 */
	vegas.data.iterator.ProtectedIterator.prototype.remove = function() 
	{
		this._notifyError("remove") ;
	}

	/**
	 * Unsupported method in all ProtectedIterator.
	 * @throws UnsupportedOperation the reset method is unsupported in a ProtectedIterator instance.
	 */
	vegas.data.iterator.ProtectedIterator.prototype.reset = function() 
	{
		this._notifyError("reset") ;
	}
	
	/**
	 * Unsupported method in all ProtectedIterator.
	 * @throws UnsupportedOperation the seek method is unsupported in a ProtectedIterator instance.
	 */
	vegas.data.iterator.ProtectedIterator.prototype.seek = function (n) 
	{
		this._notifyError("seek") ;
	}
	
	/**
	 * @private
	 */
	vegas.data.iterator.ProtectedIterator.prototype._notifyError = function ( methodName/*String*/ ) /*Void*/ 
	{
		throw new vegas.errors.UnsupportedOperation(this + " " + methodName + " method is unsupported.") ;
	}
	
}