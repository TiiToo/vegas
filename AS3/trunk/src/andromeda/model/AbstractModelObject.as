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
	
	import andromeda.events.ModelObjectEvent ;
	
	import vegas.errors.TypeMismatchError ;
	
	/**
	 * This class provides a skeletal implementation of the {@code IModelObject} interface, to minimize the effort required to implement this interface.
	 * @author eKameleon
	 */
	public class AbstractModelObject extends AbstractModel implements IModelObject
	{

		/**
		 * Creates a new AbstractModelObject instance.
		 * @param id the id of this model.
		 */	
		public function AbstractModelObject( id:* = null )
		{
			super( id ) ;
			initEvent() ;
		}

		/**
		 * Clear the model.
		 */	
		public function clear():void
		{
			_vo = null ;
			dispatchEvent( _eClear ) ;
		}

		/**
		 * Returns and creates a new empty ModelObjectEvent. You can override this method.
		 * @param type the type of the event.
		 * @return a new empty ModelObjectEvent with the type specified in argument.
		 */
		public function createNewModelObjectEvent( type:String ):ModelObjectEvent 
		{
			return new ModelObjectEvent( type || null , this ) ;
		}

		/**
		 * Returns the current IValueObject selected in this model.
		 * @return the current IValueObject selected in this model.
		 */
		public function getCurrentVO():IValueObject
		{
			return _vo ;
		}

		/**
		 * The event name use in the {@code addVO} method.
		 */
		public function getEventTypeADD():String
		{
			return ModelObjectEvent.ADD_VO ;
		}
		
		/**
		 * The event name use in the {@code setVO} method.
		 */
		public function getEventTypeCHANGE():String
		{
			return ModelObjectEvent.CHANGE_CURRENT_VO ;
		}
	
		/**
		 * The event name use in the {@code clearVO} method.
		 */
		public function getEventTypeCLEAR():String
		{
			return ModelObjectEvent.CLEAR_VO ;
		}
	
		/**
		 * The event name use in the {@code removeVO} method.
		 * you can override this method to change the nature of the remove event.
		 */
		public function getEventTypeREMOVE():String
		{
			return ModelObjectEvent.REMOVE_VO ;
		}

		/**
		 * This method is invoqued in the constructor of the class to initialize all events.
		 * Overrides this method.
		 */
		public function initEvent():void
		{
			_eChange = createNewModelObjectEvent( getEventTypeCHANGE() ) ;
			_eClear  = createNewModelObjectEvent( getEventTypeCLEAR() ) ;
		}

		/**
		 * Sets the current IValueObject selected in this model.
		 */
		public function setCurrentVO( vo:IValueObject ):void
		{
			if ( vo == _vo)
			{
				return ;	
			}
			validate(vo) ;
			_vo = vo ;
			_eChange.setVO(vo) ;
			dispatchEvent( _eChange ) ;
		}

		/**
		 * Returns true if the IValidator object validate the value.
		 * @return {@code true} is this specific value is valid.
		 */
		public function supports(value:*):Boolean 
		{
			return true ;
		}
	
		/**
		 * Evaluates the condition it checks and updates the IsValid property.
		 */
		public function validate(value:*):void 
		{
			if (!supports(value)) 
			{
				throw new TypeMismatchError( this + " validate(" + value + ") is mismatch.") ;
			}
		}

		/**
		 * The internal ModelObjectEvent use in the clearVO method.
		 */
		private var _eClear:ModelObjectEvent ;

		/**
		 * The internal ModelObjectEvent use in the setVO method.
		 */
		private var _eChange:ModelObjectEvent ;

		/**
		 * The current value object selectd in this model.
		 */
		private var _vo:IValueObject ;

	}

}