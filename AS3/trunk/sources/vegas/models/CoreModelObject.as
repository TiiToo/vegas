/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

package vegas.models
{
    import system.data.ValueObject;
    
    import vegas.events.ModelObjectEvent;
    
    /**
     * This class provides a skeletal implementation of the <code class="prettyprint">IModelObject</code> interface, to minimize the effort required to implement this interface.
     */
    public class CoreModelObject extends CoreModel implements ModelObject
    {
        /**
         * Creates a new CoreModelObject instance.
         * @param global the flag to use a global event flow or a local event flow (default true).
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         * @param id the id of this model.
         */
        public function CoreModelObject( global:Boolean = true , channel:String = null , id:* = null )
        {
            super( global , channel , id ) ;
            initEventType();
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
        public function createNewModelObjectEvent( type:String , vo:ValueObject=null ):ModelObjectEvent 
        {
            return new ModelObjectEvent( type || null , this , vo ) ;
        }
        
        /**
         * Returns the current <code class="prettyprint">ValueObject</code> selected in this model.
         * @return the current <code class="prettyprint">ValueObject</code> selected in this model.
         */
        public function getCurrentVO():ValueObject
        {
            return _vo ;
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">setCurrentVO</code> method before is changed.
         * @return the event name use in the <code class="prettyprint">setCurrentVO</code> method before is changed.
         */
        public function getEventTypeBEFORE_CHANGE():String
        {
            return _sBeforeChangeType ;
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">setVO</code> method.
         * @return the event name use in the <code class="prettyprint">setVO</code> method.
         */
        public function getEventTypeCHANGE():String
        {
            return _sChangeType ;
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">clear</code> method.
         * @return the event name use in the <code class="prettyprint">clear</code> method.
         */
        public function getEventTypeCLEAR():String
        {
            return _sClearType ;
        }
        
        /**
         * This method is invoked in the constructor of the class to initialize all events.
         * Overrides this method.
         */
        public function initEventType():void
        {
            _sBeforeChangeType = ModelObjectEvent.BEFORE_CHANGE_VO ;
            _sChangeType       = ModelObjectEvent.CHANGE_VO ;
            _sClearType        = ModelObjectEvent.CLEAR_VO  ;
        }
        
        /**
         * Notify a <code class="prettyprint">ModelObjectEvent</code> before the current <code class="prettyprint">ValueObject</code> selected in the model is changed.
         */ 
        public function notifyBeforeChange( vo:ValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            if ( hasEventListener( _sBeforeChangeType ) )
            {
                dispatchEvent( createNewModelObjectEvent( _sBeforeChangeType, vo ) ) ;
            }
        }
        
        /**
         * Notify a <code class="prettyprint">ModelObjectEvent</code> when a <code class="prettyprint">ValueObject</code> change in the model.
         */
        public function notifyChange( vo:ValueObject ):void
        {
            if ( isLocked( ) )
            {
                return ;
            }
            if ( hasEventListener( _sChangeType ) )
            {
                dispatchEvent( createNewModelObjectEvent( _sChangeType , vo ) ) ;
            }
        }
        
        /**
         * Notify a <code class="prettyprint">ModelObjectEvent</code> when the model is cleared.
         */ 
        public function notifyClear():void
        {
            if ( isLocked( ) )
            {
                return ;
            }
            if ( hasEventListener( _sClearType ) )
            {
                dispatchEvent( createNewModelObjectEvent( _sClearType ) ) ;
            } 
        }
        
        /**
         * Sets the current <code class="prettyprint">ValueObject</code> selected in this model.
         */
        public function setCurrentVO( vo:ValueObject ):void
        {
            if ( vo == _vo && security )
            {
                return ;
            }
            if ( _vo != null )
            {
                notifyBeforeChange( _vo ) ;
                _vo = null ;
            }
            if ( vo != null )
            {
                validate( vo );
                 _vo = vo ;
                notifyChange( vo );
            }
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">setCurrentVO</code> method before is changed.
         * @return the event name use in the <code class="prettyprint">unchange</code> method.
         */
        public function setEventTypeBEFORE_CHANGE( type:String ):void
        {
            _sBeforeChangeType = type;
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">setVO</code> method.
         * @return the event name use in the <code class="prettyprint">setVO</code> method.
         */
        public function setEventTypeCHANGE( type:String ):void
        {
           _sChangeType = type;
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">clear</code> method.
         * @return the event name use in the <code class="prettyprint">clear</code> method.
         */
        public function setEventTypeCLEAR( type:String ):void
        {
            _sClearType = type;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the <code class="prettyprint">IValidator</code> object validate the value. Overrides this method in your concrete IModelObject class.
         * @param value the object to test.
         * @return <code class="prettyprint">true</code> is this specific value is valid.
         */
        public function supports( value:* ):Boolean 
        {
            return value == value ;
        }
        
        /**
         * Evaluates the specified value and throw a <code class="prettyprint">TypeError</code> object if the value is not valid.
         * @throws TypeError if the value is not valid.
         */
        public function validate( value:* ):void 
        {
            if (!supports( value )) 
            {
                throw new TypeError( this + " validate(" + value + ") is mismatch." ) ;
            }
        }
        
        /**
         * @private
         */
        protected var _sBeforeChangeType:String ;
        
        /**
         * @private
         */
        protected var _sChangeType:String ;
        
        /**
         * @private
         */
        protected var _sClearType:String ;
        
        /**
         * @private
         */
        protected var _vo:ValueObject ;
    }
}