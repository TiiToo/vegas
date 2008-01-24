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
package andromeda.util.mvc
{
	
	import andromeda.events.ModelChangedEvent;
	
	import vegas.events.AbstractCoreEventDispatcher;	

	/**
     * Abstract class to creates IModel implementations.
     * @author eKameleon
     */
	public class AbstractModel extends AbstractCoreEventDispatcher implements IModel
	{
		
		/**
		 * Abstract contructor, creates an IModel instance.
		 */
		public function AbstractModel()
		{
			super();
		}

		/**
		 * Adds a view in the model.
		 */
		public function addView( view:IView ):void
		{
            registerEventListener(ModelChangedEvent.MODEL_CHANGED, view ) ;
		}

		/**
		 * Returns a shallow copy of this object.
		 */	
		public function clone():*
		{
			return null ; // override this method.
		}

		/**
		 * Notify a ModelChangedEvent to the views.
		 */
		public function notifyChanged(event:ModelChangedEvent):void
		{
			dispatchEvent( event ) ;
		}

		/**
		 * Removes a view in the model.
		 */
		public function removeView(view:IView):void
		{
			unregisterEventListener(ModelChangedEvent.MODEL_CHANGED, view) ;
		}
		
	}
}