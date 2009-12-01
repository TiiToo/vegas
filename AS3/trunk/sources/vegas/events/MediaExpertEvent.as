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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.events 
{
    import system.events.BasicEvent;
    
    import flash.events.Event;
    
    /**
     * Dispatched when a Microphone or Camera status is changed "muted" or "unmuted" or if this activity is changed.
     * @see vegas.media.CameraExpert
     * @see vegas.media.MicrophoneExpert
     */
    public class MediaExpertEvent extends BasicEvent 
    {
        /**
         * Creates a new MediaExpertEvent instance.
         * @param type the string type of the instance.
         * @param target the target of the event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function MediaExpertEvent(type:String, target:Object = null, context:* = null, bubbles:Boolean = false, cancelable:Boolean = false, time:Number = 0)
        {
            super(type, target, context, bubbles, cancelable, time);
        }
        
        /**
         * The name of the event when the Microphone is muted.
         */
        public static const MUTED:String = "muted" ;
        
        /**
         * The name of the event when the Microphone is unmuted.
         */        
        public static const UNMUTED:String = "unmuted" ;
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():Event
        {
            return new MediaExpertEvent( type , target , context ) ;
        }
    }
}
