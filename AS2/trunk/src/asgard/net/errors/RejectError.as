
/**
 * The error throws when a rejection is invoked from a server application.
 * This error notify a fatal level message in the vegas.errors.* logging category.
 * @author eKameleon
 */
class asgard.net.errors.RejectError extends Error 
{

	/**
	 * Creates a new RejectError instance.
	 * @param msg The message of the error.
	 * @param code The code of the error.
	 */
	public function RejectError(msg:String, code:String, level:String )
	{
		super( msg );
		if ( msg != null )
		{
			this.message = msg ;
		}
		if ( code != null )
		{
			this.code  = code ;
		}
	}
	
	/**
	 * The default error code value.
	 */
	public static var DEFAULT_ERROR_CODE:String = "reject" ; 
	
	/**
	 * The default error level value.
	 */
	public static var DEFAULT_ERROR_LEVEL:String = "level" ; 	

	/**
	 * The code of the reject error.
	 */
	public var code:String ;
	
	/**
	 * The name of the file who creates the error.
	 */
	public var fileName:String ;	
	
	/**
	 * The level of the reject error.
	 */
	public var level:String ;
	
	/**
	 * The line number of the error.
	 */
	public var lineNumber:Number ;	
	
    /**
     * Register the class to AMF communication.
     */
    public static function register( id:String ):Boolean
    {
        return Object.registerClass( id || "RejectError" , RejectError ) ;
    }
	
}
