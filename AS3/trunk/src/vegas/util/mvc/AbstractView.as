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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.util.mvc
{
    import flash.display.DisplayObject;
    import flash.display.Stage;
    import flash.events.Event;
    
    import vegas.core.CoreObject;
    
    /**
	 * Abstract class to creates IView implementations.
	 * @author eKameleon
	 */
	public class AbstractView extends CoreObject implements IView
	{

		/**
		 * Abstract contructor, creates an IView instance.
		 */		
		public function AbstractView()
		{
			super();
		}

		/**
		 * Returns the controller reference of this view.
		 */
		public function getController():IController 
		{
			return _oController ;
		}

		/**
		 * Returns the display reference of this view.
		 */
		public function getDisplay():DisplayObject
		{
			return _display ;
		}

		/**
		 * This method is called whenever an event occurs of the type for which the EventListener interface was registered.
		 * @param e The Event contains contextual information about the event.
		 */
		public function handleEvent(e:Event):*
		{
			return null ;
		}

		/**
		 * Register a model with this view.
		 */
		public function registerWithModel( oModel:IModel ):void
		{
			oModel.addView(this);
		}

		/**
		 * Sets the controller reference of this view.
		 */
		public function setController(oController:IController):void
		{
			_oController = oController;
		}

		/**
		 * Sets a new model and register this model with this view. 
		 */
		public function setModel(oModel:IModel):void 
		{
			registerWithModel( oModel ) ;
		}

		/**
		 * Sets the display reference of this view.
		 */
		public function setDisplay( display:DisplayObject=null ):void
		{
			_display = (display == null) ? Stage.root : display ;
		}		
	
		/**
		 * Internal display view reference.
		 */
		private var _display:DisplayObject ;

		/**
		 * Internal controller.
		 */
		private var _oController:IController ;

		/**
		 * Internal model.
		 */
		private var _oModel:IModel ;
		
	}
}