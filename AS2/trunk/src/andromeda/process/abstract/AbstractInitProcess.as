
import pegas.process.SimpleAction;

/**
 * This Action lauch an initialize process.
 * @author ekameleon
 */
class andromeda.process.abstract.AbstractInitProcess extends SimpleAction 
{

	/**
	 * Creates a new AbstractRunFlashVars instance.
	 */	
	function AbstractInitProcess(bGlobal : Boolean, sChannel : String) 
	{
		super(bGlobal, sChannel);
	}
	
	/**
	 * Launch the initialize process in this method.
	 * Overrides this method.
	 */
	public function init():Void
	{
		// override
	}

	/**
	 * Run the process.
	 */
	public function run():Void
	{
		notifyStarted() ;		
		init() ;
		notifyFinished() ;	
	}
	
}