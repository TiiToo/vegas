
package test
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
        	scheduledEnd   = end ;
        }
        
    }

}