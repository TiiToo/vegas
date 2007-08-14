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

package andromeda.model
{
	import vegas.events.AbstractCoreEventDispatcher;
	
	/**
	 * This class provides a skeletal implementation of the {@code IModel} interface, to minimize the effort required to implement this interface.
	 * @author eKameleon
	 */
	public class AbstractModel extends AbstractCoreEventDispatcher implements IModel
	{
	
		/**
		 * Creates a new AbstractModel instance.
		 * @param id the id of the model.
		 */	
		public function AbstractModel( id:* = null )
		{
			_setID( (id == null) ? this.hashCode() : id ) ;
		}

		/**
		 * Returns the {@code id} of this IModelObject. This method is use to register this object in a category of models.
		 * You can overrides this method to change the nature of the natural id property of this object but this hack don't modify the value of the {@code id} property. 
		 * @return the {@code id} of this IModelObject.
		 */
		public function get id():*
		{
			return _id ;
		}
		
		/**
		 * Sets the {@code id} of this IModelObject.
		 */
		public function set id(value:*):void
		{
			_setID( value || hashCode() ) ;
		}
		
		/**
		 * The internal id property of this IModelObject. By default the id equals the hashCode() value.
		 */
		private var _id:* ;
		
		/**
		 * Internal method to register the IModel in the ModelCollector with the specified id in argument.
		 * @see ModelCollector.
		 */
		private function _setID( id:* ):void 
		{
			
			if ( ModelCollector.contains( this._id ) )
			{
				ModelCollector.remove( this._id ) ;
			}
			
			this._id = id ;
			
			ModelCollector.insert ( this._id, this ) ;
			
		}
		
	}
}