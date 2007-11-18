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

package andromeda.events
{
	import flash.events.Event;
	
	import andromeda.model.IModelObject;
	import andromeda.vo.IValueObject;
	
	import vegas.events.BasicEvent;	

	/**
	 * The ModelObjectEvent is the basic event use in a IModelObject to notify changed.
	 * @author eKameleon
	 */
	public class ModelObjectEvent extends BasicEvent
	{
		
		/**
		 * Creates a new ModelObjectEvent instance.
		 * @param type the type of the event.
		 * @param (optional) model the IModelObject reference of this event.
		 * @param (optional) the IValueObject of this event.
		 * @param target the target of the event.
		 * @param info The information object of this event.
		 * @param context the optional context object of the event.
		 * @param bubbles indicates if the event is a bubbling event.
		 * @param cancelable indicates if the event is a cancelable event.
		 * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
		 */	
		public function ModelObjectEvent(type:String, model:IModelObject=null , vo:IValueObject=null, target:Object = null , context:* = null, bubbles:Boolean=false, cancelable:Boolean=false , time:Number = 0 )
		{
			super(type, target, context, bubbles, cancelable, time );
			setVO( vo ) ;
			setModel ( model ) ;
		}

		/**
		 * Default event type when the addVO method is invoqued.
		 */
		public static var ADD_VO:String = "onAddVO" ;
	
		/**
		 * Default event type when the clear method is invoqued.
		 */
		public static var CLEAR_VO:String = "onClearVO" ;
	
		/**
		 * Default event type when the setVO method is invoqued.
		 */
		public static var CHANGE_CURRENT_VO:String = "onChangeCurrentVO" ;
	
		/**
		 * Default event type when the removeVO method is invoqued.
		 */
		public static var REMOVE_VO:String = "onRemoveVO" ;
	
		/**
		 * Default event type when the removeVO method is invoqued.
		 */
		public static var UPDATE_VO:String = "onUpdateVO" ;
		
		/**
    	 * Returns the shallow copy of this object.
    	 * @return the shallow copy of this object.
    	 */
		public override function clone():Event 
		{
			return new ModelObjectEvent( getType(), getModel() , getVO(), getTarget(), getContext() ) ;
		}
		
		/**
		 * Returns the IModelObject reference of this event.
		 * @return the IModelObject reference of this event.
		 */
		public function getModel():IModelObject
		{
			return _model as IModelObject ;	
		}
		
		/**
		 * Returns a IValueObject reference.
		 * @return a IValueObject reference.
		 */
		public function getVO():IValueObject
		{
			return _vo ;	
		}

		/**
		 * Sets the IModelObject reference of this event.
		 */
		public function setModel( model:IModelObject ):void
		{
			_model = model || null ;	
		}
	
		/**
		 * Sets a IValueObject reference.
		 */
		public function setVO( vo:IValueObject ):void
		{
			_vo = vo || null ;	
		}

		private var _model:IModelObject ;	
		private var _vo:IValueObject ;
	
	}

}