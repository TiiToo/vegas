package test
{
    import andromeda.ioc.factory.ObjectFactory;    

    /**
     * This class is a helper to test the #this notation if the ref attributes in the IoC object definitions.
     */
    public class FactoryReference
    {
    
        /**
         * Creates a new FactoryReference instance.
         */
        public function FactoryReference( factory:ObjectFactory = null )
        {
            this.factory = factory ;
        }
        
        /**
         * The factory reference of this object.
         */
        public var factory:ObjectFactory ;
                
    }

}