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

package examples.factory 
{
    import examples.core.Appointment;

    /**
     * This factory creates Appointment instances.
     */
    public class AppointmentFactory 
    {
        /**
         * Creates a new Appointment instance.
         */
        public function build( scheduledStart:String=null , scheduledEnd:String=null ):Appointment
        {
            return new Appointment( scheduledStart, scheduledEnd ) ;
        }
        
        /**
         * Creates a new Appointment instance (static method).
         */
        public static function create( scheduledStart:String=null , scheduledEnd:String=null  ):Appointment
        {
            return new Appointment( scheduledStart, scheduledEnd ) ;
        }
    }
}
