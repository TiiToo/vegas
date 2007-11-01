﻿/*

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
    import andromeda.events.ModelObjectEvent;

    import vegas.errors.TypeMismatchError;

    /**
     * This class provides a skeletal implementation of the {@code IModelObject} interface, to minimize the effort required to implement this interface.
     * @author eKameleon
     */
    public class AbstractModelObject extends AbstractModel implements IModelObject
    {

        /**
         * Creates a new AbstractModelObject instance.
         * @param id the id of this model.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
         */	
        public function AbstractModelObject( id:* = null , bGlobal:Boolean = false , sChannel:String = null )
        {
            super( id , bGlobal , sChannel );
            initEvent( );
        }

        /**
         * This property defined if the setCurrentVO method can accept the same vo in argument as the current one. 
         */
        public var security:Boolean = true ;

        /**
         * Clear the model.
         */	
        public function clear():void
        {
            _vo = null;
            notifyClear( );
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
         * Returns the event name use in the {@code setVO} method.
         * @return the event name use in the {@code setVO} method.
         */
        public function getEventTypeCHANGE():String
        {
            return _eChange.type ;
        }

        /**
         * Returns the event name use in the {@code clear} method.
         * @return the event name use in the {@code clear} method.
         */
        public function getEventTypeCLEAR():String
        {
            return _eClear.type ;
        }

        /**
         * This method is invoqued in the constructor of the class to initialize all events.
         * Overrides this method.
         */
        public function initEvent():void
        {
            _eChange = createNewModelObjectEvent( ModelObjectEvent.CHANGE_CURRENT_VO );
            _eClear = createNewModelObjectEvent( ModelObjectEvent.CLEAR_VO );
        }

        /**
         * Notify a {@code ModelObjectEvent} when a {@code IValueObject} change in the model.
         */	
        public function notifyChange( vo:IValueObject ):void
        {
            if ( isLocked( ) )
            {
                return ;
            }
            _eChange.setVO( vo );
            dispatchEvent( _eChange );	
        }

        /**
         * Notify a {@code ModelObjectEvent} when the model is cleared.
         */ 
        public function notifyClear():void
        {
            if ( isLocked( ) )
            {
                return ;
            }
            dispatchEvent( _eClear ); 
        }

        /**
         * Sets the current IValueObject selected in this model.
         */
        public function setCurrentVO( vo:IValueObject ):void
        {
            if ( vo == _vo && security )
            {
                return ;	
            }
            validate( vo );
            _vo = vo;
            notifyChange( vo );
        }

        /**
         * Returns the event name use in the {@code setVO} method.
         * @return the event name use in the {@code setVO} method.
         */
        public function setEventTypeCHANGE( type:String ):void
        {
            _eChange.type = type;
        }

        /**
         * Returns the event name use in the {@code clear} method.
         * @return the event name use in the {@code clear} method.
         */
        public function setEventTypeCLEAR( type:String ):void
        {
            _eClear.type = type;
        }

        /**
         * Returns {@code true} if the {@code IValidator} object validate the value. Overrides this method in your concrete IModelObject class.
         * @param value the object to test.
         * @return {@code true} is this specific value is valid.
         */
        public function supports( value:* ):Boolean 
        {
            return value == value ;
        }

        /**
         * Evaluates the condition it checks and updates the IsValid property.
         */
        public function validate(value:*):void 
        {
            if (!supports( value )) 
            {
                throw new TypeMismatchError( this + " validate(" + value + ") is mismatch." ) ;
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