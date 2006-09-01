package vegas.logging
{
    
    import vegas.core.CoreObject ;
    
    public class LogEventLevel extends CoreObject
    {
        
        // ----o Constructor 
	
    	public function LogEventLevel( name:String, value:int ) 
	    {
    		_name = name ;
    		_value = value ;
    	}
    	
	    // ----o Constant

    	static public const ALL:LogEventLevel = new LogEventLevel("ALL", 0) ;
    	
    	static public const DEBUG:LogEventLevel = new LogEventLevel("DEBUG", 8) ;
    	
    	static public const ERROR:LogEventLevel = new LogEventLevel("ERROR", 8) ;
    	
    	static public const FATAL:LogEventLevel = new LogEventLevel("FATAL", 1000) ;
    
    	static public const INFO:LogEventLevel = new LogEventLevel("INFO", 4) ;	
    	
    	static public const WARN:LogEventLevel = new LogEventLevel("WARN", 6) ; ;

        // ----o Public Methods
        
        static public function isValidLevel( level:LogEventLevel ):Boolean 
        {
            var levels:Array = [ ALL, DEBUG, ERROR, FATAL, INFO, WARN ] ;
            var l:uint = levels.length ;
    		while (--l > -1)
    		{
                if (level.valueOf() == levels[l].valueOf() ) 
                {
                    return true ;  
                }
    		}  
    		return false ;
    	}
		
		override public function toSource( ...arguments:Array ):String 
	    { 
		    return 'new vegas.logging.LogEventLevel("' + this._name + '",' + this._value + ')' ;
    	}
		
	    override public function toString():String 
	    { 
		    return _name ; 
    	}
    	
    	public function valueOf():int
    	{
    	    return _value ;
    	}
    	
    	// ----o Private Properties
    	
    	private var _name:String ;
    	private var _value:int ;

    }
}