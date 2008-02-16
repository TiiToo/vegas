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

package andromeda.model
{
	import vegas.events.AbstractCoreEventDispatcher;    

	/**
	 * This class provides a skeletal implementation of the <code>IModel</code> interface, to minimize the effort required to implement this interface.
	 * @author eKameleon
	 */
	public class AbstractModel extends AbstractCoreEventDispatcher implements IModel
	{
	
		/**
		 * Creates a new AbstractModel instance.
		 * @param id the id of the model.
         * @param id the id of this model.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code>bGlobal</code> argument is <code>true</code>.
		 */	
		public function AbstractModel( id:* = null , bGlobal:Boolean = false , sChannel:String = null )
		{
			super( bGlobal , sChannel ) ;
			_setID( id ) ;
		}

		/**
		 * Returns the <code>id</code> of this IModelObject. This method is use to register this object in a category of models.
		 * You can overrides this method to change the nature of the natural id property of this object but this hack don't modify the value of the <code>id</code> property. 
		 * @return the <code>id</code> of this IModelObject.
		 */
		public function get id():*
		{
			return _id ;
		}
		
		/**
		 * Sets the <code>id</code> of this IModelObject.
		 */
		public function set id(value:*):void
		{
			_setID( value || hashCode() ) ;
		}

		/**
	 	 * Run the first process with this model.
	 	 * Overrides this method if you want implement a command process.
		 */
		public function run( ...arguments:Array ):void 
		{
			
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
			
			if ( this._id != null )
			{
				ModelCollector.insert ( this._id, this ) ;
			}
			
		}
		
	}
}