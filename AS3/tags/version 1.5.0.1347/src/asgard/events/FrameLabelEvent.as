/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.events 
{    import system.events.ActionEvent;
    import system.events.BasicEvent;
    
    import flash.display.FrameLabel;
    import flash.events.Event;
    
    /**     * The FrameLabelEvent dispatch a FrameLabel object.     */    public class FrameLabelEvent extends BasicEvent
    {
        /**
         * Creates a new FrameLabelEvent instance.
         * @param type the string type of the instance. 
         * @param frame The FrameLabel reference of this event.
         * @param target the target of the event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function FrameLabelEvent( type:String , frame:FrameLabel = null , target:Object = null, context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
        {
            super(type, target, context, bubbles, cancelable, time) ;
            _frame = frame ;
        }
        
        /**
         * The name of the event when a frame label is found in a MovieClip during this playing process.
         * @eventType frameLabel
         */
        public static const FRAME_LABEL:String = "frameLabel" ;
        
        /**
         * Determinates the FrameLabel reference.
         */
        public function get frameLabel():FrameLabel
        {
            return _frame ;
        }
        
        /**
         * @private
         */
        public function set frameLabel( frame:FrameLabel ):void
        {
            _frame = frame ;
        }
        
        /**
         * Returns the shallow copy of this object.
         * @return the shallow copy of this object.
         */
        public override function clone():Event 
        {
            return new ActionEvent( type, frameLabel, target, context ) ;
        }
        
        /**
         * Returns the string representation of this event.
         * @return the string representation of this event.
         */
        public override function toString():String 
        {
            return formatToString( "FrameLabelEvent", "type", "frameLabel", "target", "context", "bubbles", "cancelable", "eventPhase" ); 
        }
        
        /**
         * @private
         */
        private var _frame:FrameLabel ;
    }}