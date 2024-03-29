﻿/*

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

package vegas.events
{
    import system.data.ValueObject;
    import system.events.BasicEvent;
    
    import vegas.models.ModelObject;
    
    import flash.events.Event;
    
    /**
     * The ModelObjectEvent is the basic event use in a IModelObject to notify changed.
     */
    public class ModelObjectEvent extends BasicEvent
    {
        
        /**
         * Creates a new ModelObjectEvent instance.
         * @param type the type of the event.
         * @param (optional) model the IModelObject reference of this event.
         * @param (optional) the ValueObject of this event.
         * @param target the target of the event.
         * @param info The information object of this event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function ModelObjectEvent( type:String, model:ModelObject = null , vo:ValueObject = null, target:Object = null , context:* = null, bubbles:Boolean = false, cancelable:Boolean=false , time:Number = 0 )
        {
            super(type, target, context, bubbles, cancelable, time );
            setVO( vo ) ;
            setModel ( model ) ;
        }
        
        /**
         * Default event type when an <code class="prettyprint">IValueObject</code> is inserted in a model.
         */
        public static var ADD_VO:String = "addVO" ;
        
        /**
         * Default event type before the change event notify when the current <code class="prettyprint">IValueObject</code> in a model is changed.
         */
        public static var BEFORE_CHANGE_VO:String = "beforeChangeVO" ;
        
        /**
         * Default event type when all <code class="prettyprint">IValueObject</code> in a model are deleted.
         */
        public static var CLEAR_VO:String = "clearVO" ;
            
        /**
         * Default event type when the current <code class="prettyprint">ValueObject</code> is changed in the model.
         */
        public static var CHANGE_VO:String = "changeVO" ;
        
        /**
         * Default event type when an <code class="prettyprint">ValueObject</code> is removed in a model.
         */
        public static var REMOVE_VO:String = "removeVO" ;
            
        /**
         * Default event type when the an <code class="prettyprint">ValueObject</code> in the model is updated.
         */
        public static var UPDATE_VO:String = "updateVO" ;
        
        /**
         * Returns the shallow copy of this object.
         * @return the shallow copy of this object.
         */
        public override function clone():Event 
        {
            return new ModelObjectEvent( type, getModel() , getVO(), target, context ) ;
        }
        
        /**
         * Returns the ModelObject reference of this event.
         * @return the ModelObject reference of this event.
         */
        public function getModel():ModelObject
        {
            return _model as ModelObject ;
        }
        
        /**
         * Returns a ValueObject reference.
         * @return a ValueObject reference.
         */
        public function getVO():ValueObject
        {
            return _vo ;
        }
        
        /**
         * Sets the ModelObject reference of this event.
         */
        public function setModel( model:ModelObject ):void
        {
            _model = model || null ;
        }
        
        /**
         * Sets the ValueObject reference.
         */
        public function setVO( vo:ValueObject ):void
        {
            _vo = vo || null ;
        }
        
        /**
         * @private
         */
        private var _model:ModelObject ;
        
        /**
         * @private
         */
        private var _vo:ValueObject ;
    }
}