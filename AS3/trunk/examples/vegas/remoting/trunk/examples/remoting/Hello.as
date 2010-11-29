package examples.remoting
{
    import vegas.remoting.RemotingService;
    import vegas.remoting.RemotingServiceListener;
    import vegas.remoting.logger;
    
    /**
     * The custom HelloWorld AMF service listener.
     */
    public class Hello extends RemotingServiceListener
    {
        public function Hello(service:* = null, verbose:Boolean = true)
        {
            super(service, verbose);
        }
        
       /**
         * Invoked when the service notify a success.
         */
        public override function result( result:* , service:RemotingService ):void
        {
            if ( verbose )
            {
                logger.debug( this + " result custom message:" + result ) ;
                // check and use the result object here
            }
        }
    }
}
