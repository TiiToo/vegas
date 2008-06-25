
package test.factory 
{
    import test.Appointment;            

    /**
	 * This factory creates Appointment instances.
	 * @author eKameleon
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
