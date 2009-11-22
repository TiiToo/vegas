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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package examples.core
{
    /**
     * Represents a commitment representing a time interval with start and end times and a duration.
     */
    public class Appointment
    {
        /**
         * Creates a new Appointment instance.
         */
        public function Appointment( scheduledStart:String=null , scheduledEnd:String=null )
        {
            this.scheduledEnd   = scheduledEnd   ;
            this.scheduledStart = scheduledStart ;
        }
        
        /**
         * Indicates the scheduled end time of the appointment.
         */
        public var scheduledEnd:String ;
        
        /**
         * Indicates the scheduled start time of the appointment.
         */
        public var scheduledStart:String ;
        
        /**
         * The subject of the appointment.
         */
        public var subject:String ;
        
        /**
         * Defines the start and the end of the appointment.
         */
        public function setShedule( start:String , end:String ):void
        {
            scheduledStart = start ;
            scheduledEnd   = end   ;
        }
    }
}