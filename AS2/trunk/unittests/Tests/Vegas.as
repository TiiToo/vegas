
import asgard.display.DisplayObject;
import asgard.display.StageAlign;
import asgard.display.StageScaleMode;

import buRRRn.ASTUce.Config;

import Tests.VegasRunner;

// TODO use the vegas.logging package to trace the tests.

/**
 * The main Unit Tests application.
 * @author eKameleon
 */
class Tests.Vegas extends DisplayObject
{
	
	/**
	 * Creates the Vegas Singleton.
	 */
	private function Vegas( target:MovieClip )
	{
		
		super( "application", target ) ;
		
		Vegas.application = this ; // ??? 
		
		Stage.align = StageAlign.TOP_LEFT ;
        Stage.scaleMode = StageScaleMode.NO_SCALE ;
        Stage.showMenu = false ;
        
        var format:TextFormat = new TextFormat("Courier New", 13) ;
        format.leftMargin  = 3 ;
        format.rightMargin = 3 ;
        
        field = view.createTextField("field", 1, 0, 0, Stage.width, Stage.height) ;
        field.multiline = true ;
        field.setNewTextFormat(format) ;
        field.textColor = 0xFFFFFF ;
        
        Stage.addListener(this) ;
        
        onResize() ;
        
        // ASTUce configuration
        
        Config.verbose = false;
        
        // Config.showObjectSource     = true;
        // Config.invertExpectedActual = false;
        // Config.testPrivateMethods   = false;
        // Config.testInheritedTests   = false;
        
		//Config.showConstructorList = false ;
        Config.testMyself = true ;

		// new TestSuite( Tests.vegas.core.TestCoreObject ) 
		// new TestSuite(Tests.ASTUce.SuiteTest) 
        
		run() ;
		
	}
   	
   	static public var application:Vegas ;
   
   	public var field:TextField ;

	static public var separator:String = " ";

	/**
	 * Returns information about the ASTUce framework.
	 */
	static public function getInfo():String
	{
		var str:String = "" ;
		var CRLF:String = "\n" ;
    
    	if( Config.verbose )
        {
        	str += _name + ": " + _fullName + " v" + _version;
        }
    	else
        {
        	str += _name + " v" + _version;
        }
    
		if( Config.verbose )
        {
        	str += CRLF;
        	str += "Copyright (c) 2004-2007 Zwetan Kjukov, All right reserved." + CRLF ;
        	str += "Made in the EU.";
        }
    
    	return str;
	}
	
	/**
	 * Launch the application.
	 */
	static public function main( target:MovieClip ):Void
	{
		if (Vegas.application == null)
		{
			Vegas.application = new Vegas( target ) ;
		}	
	}

	/**
	 * Invoqued when the Stage is resized.
	 */	
	public function onResize():Void
	{
		field._width = Stage.width  ;
		field._height = Stage.height ;	
	}
	
	/**
	 * Run the ASTUce Unit Tests.
	 */
	public function run():Void
	{
				
		write( separator );
    
    	var runner:VegasRunner = new VegasRunner( "Main Tests" );
    
    	if( Config.testMyself )
        {
        	runner.setUp = function()
            {
            	this.suite.addTest( Tests.AllTests.suite() );
            } ;
        }
    
    	if( arguments.length > 0 )
        {
        	for( var i=0; i<arguments.length; i++ )
            {
            	runner.suite.addTest( arguments[i] );
            }
        }
    
    	write( getInfo() );
    	
    	write( separator );
    	
    	runner.run();
    	
    	write( separator );
    	
    	if( Config.showConstructorList )
        {
        	write( runner.suite );
        	write( separator );
        }
        
	}

	static public function tracer( message ):Void
	{
		application.write(message) ;	
	}

	public function write( message ):Void
	{
		
		trace( message ) ;
		
		var txt:String = field.text ? (field.text + "\r") : "" ;
		txt += message.toString() ;
		field.text = txt ;
		// field.scroll = field.maxscroll ;
		 
	}

    /**
     * The language extension.
     */
    static private var _ext:String = "AS2";

	/**
	 * The code name of the framework.
 	 */
	static public var _name:String = "ASTUce";
		
	/***
	 * The full name of the framework.
	 */
	static public var _fullName:String = "ActionScript Test Unit compact edition";

    /**
     * The target platform of the framework.
     */
    static private var _platform:String = "Flash ActionScript v2.0";
    	
	/**
	 * The version as string of the framework.
	 */
	static public var _version:String = "1.0.0.0 (VEGAS version)";

	
}