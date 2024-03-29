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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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
    import vegas.media.CoreSound;
    
    import system.events.BasicEvent;
    
    import flash.events.Event;
    import flash.media.SoundTransform;
    
    /**
     * Flash® Player dispatches a SoundEvent object when the user changes the sound by either moving the handle of the volumeBar control or setting the volume or soundTransform property. 
     */
    public class SoundEvent extends BasicEvent
    {
        /**
         * Creates a new SoundEvent instance.
         * @param type the string type of the instance. 
         * @param target the target of the event.
         * @param soundTransform Indicates new values for volume and panning.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function SoundEvent( type:String , target:*=null , soundTransform:SoundTransform=null , context:*=null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
        {
            super( type, target, context, bubbles, cancelable, time );
            _soundTransform = soundTransform ;
        }
        
        /**
         * The name of the event when the localization is changed.
         */
        public static var SOUND_UPDATE:String = "soundUpdate" ;
        
        /**
         * Defines the value of the type property of a soundUpdate event object.
         */
        public function get soundTransform():SoundTransform
        {
            if ( _soundTransform != null )
            {
                return _soundTransform ;
            }
            else if ( target is CoreSound )
            {
                if ( target.channel != null )
                {
                    return target.channel.soundTransform ;
                }
            }
            return null ;
        } 
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():Event
        {
            return new SoundEvent( type , target , soundTransform, context ) ;
        }
        
        /**
         * @private
         */
        private var _soundTransform:SoundTransform ;
    }
}