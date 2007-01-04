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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

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
        
        Config.verbose = true ;
        
        // Config.showObjectSource     = true;
        // Config.invertExpectedActual = false;
        // Config.testPrivateMethods   = false;
        // Config.testInheritedTests   = false;
        
		// Config.showConstructorList = false ;
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