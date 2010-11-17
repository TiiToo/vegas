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
    import vegas.events.ValueEvent;
    
    /**
     * This class provides a simple representation of the IModelObject interface.
     */
    public class ChangeModel extends CoreModel 
    {
        /**
         * Creates a new ChangeModel instance.
         * @param global the flag to use a global event flow or a local event flow (default true).
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         * @param id the id of this model.
         */
        public function ChangeModel( global:Boolean = true, channel:String = null , id:* = null )
        {
            super( global , channel , id ) ;
            initEventType();
        }
        
        /**
         * Determinates the selected value in this model.
         */
        public function get current():*
        {
            return _current ;
        }
        
        /**
         * @private
         */
        public function set current( o:* ):void
        {
            if ( o == _current && security )
            {
                return ;
            }
            if ( _current != null )
            {
                notifyBeforeChange( _current ) ;
                _current = null ;
            }
            if ( o != null )
            {
                _current = o ;
                notifyChange( _current );
            }
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
            _current = null;
            notifyClear() ;
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
            _sBeforeChangeType = ValueEvent.BEFORE_CHANGE ;
            _sChangeType       = ValueEvent.CHANGE ;
            _sClearType        = ValueEvent.CLEAR  ;
        }
        
        /**
         * Notify an <code class="prettyprint">EntryEvent</code> before the current <code class="prettyprint">value</code> selected in the model is changed.
         */ 
        public function notifyBeforeChange( value:* ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            if ( hasEventListener( _sBeforeChangeType ) )
            {
                dispatchEvent( new ValueEvent( _sBeforeChangeType , value ) ) ;
            }
        }
        
        /**
         * Notify an <code class="prettyprint">EntryEvent</code> when a value is selected and changed in the model.
         */
        public function notifyChange( value:*  ):void
        {
            if ( isLocked( ) )
            {
                return ;
            }
            if ( hasEventListener( _sChangeType ) )
            {
               dispatchEvent( new ValueEvent( _sChangeType , value ) ) ;
            }
        }
        
        /**
         * Notify an <code class="prettyprint">EntryEvent</code> when the model is cleared.
         */ 
        public function notifyClear():void
        {
            if ( isLocked( ) )
            {
                return ;
            }
            if ( hasEventListener( _sClearType ) )
            {
                dispatchEvent( new ValueEvent( _sClearType ) ) ;
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
         * @private
         */
        protected var _current:* ;
        
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
    }
}
