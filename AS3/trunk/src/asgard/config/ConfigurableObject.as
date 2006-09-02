package asgard.config
{
   
    import vegas.core.CoreObject;
    import vegas.errors.Warning ;

    public class ConfigurableObject extends CoreObject implements IConfigurable
    {
        
        // ----o Constructor
        
        public function ConfigurableObject()
        {
            super();
            isConfigurable = true ;
        }
        
        // ----o Public Methods
	 
       	public function setup():Void
        {
            throw new Warning(this + ".setup(), you must override this method !") ;
        }
    	
        // ----o Virtual Properties
    
    	public function get isConfigurable():Boolean
    	{
    		return _isConfigurable ;
    	}
    	
    	public function set isConfigurable(b:Boolean):Void
    	{
    		_isConfigurable = (b == true) ;
    		if (_isConfigurable)
    		{
    			ConfigCollector.insert(this) ;	
    		}
    		else
    		{
    			ConfigCollector.remove(this) ;
    		}
    	}

        // ----o Private Properties
    	 
    	private var _isConfigurable:Boolean ;
        
    }

}