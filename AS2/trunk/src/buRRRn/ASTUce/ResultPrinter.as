/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASTUce: ActionScript Test Unit compact edition. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
   
   	- Marc ALCARAZ (aka eKameleon) : adaptation to VEGAS framework.
     
*/

import buRRRn.ASTUce.AssertionFailedError;
import buRRRn.ASTUce.ITest;
import buRRRn.ASTUce.ITestListener;
import buRRRn.ASTUce.Strings;
import buRRRn.ASTUce.TestFailure;
import buRRRn.ASTUce.TestResult;

import vegas.core.CoreObject;
import vegas.string.StringFormatter;
import vegas.util.TypeUtil;

/**
 * @author eKameleon
 */
class buRRRn.ASTUce.ResultPrinter extends CoreObject implements ITestListener 
{
	
	/**
	 * Creates a new ResultPrinter instance.
	 */
	public function ResultPrinter( writer:Function ) 
	{
		
		_writer = _global.trace ; //default writer
        
        _column = 0 ;
        
        if( (writer != null) && TypeUtil.typesMatch( writer , Function ) )
        {
            _writer = writer ;
		}
		
	}

	/**
	 * Returns the internal writer method of this instance.
	 */
    public function get writer():Function
	{
		return _writer ;
	}

	public function addError(test : ITest, e : Error) : Void 
	{
		writeLine( "E" );
	}

	public function addFailure(test : ITest, afe : AssertionFailedError) : Void 
	{
		writeLine( "F" );
	}

    public function elapsedTimeAsString( runTime:Number ):String
	{
		var ms, s, m, h ;
		var dat:Date = new Date( runTime.valueOf() );
        ms = dat.getUTCMilliseconds();
        s  = dat.getUTCSeconds();
        m  = dat.getUTCMinutes();
        h  = dat.getUTCHours();
        return new StringFormatter( Strings.PrtElapsedTime).format( h, m, s, ms ) ;
	}

	public function endTest(test : ITest) : Void 
	{
		//
	}
	
    public function print( result:TestResult, runTime:Number ):Void
	{
        printHeader( runTime );
        printErrors( result );
        printFailures( result );
        printFooter( result );
	}

	/**
	 * 
 	 */
    public function printErrors( result:TestResult ):Void
	{
		printDefects( result.errors, result.errorCount, Strings.nameError ) ;
	}

	/**
	 * 
	 */
    public function printFailures( result:TestResult ):Void
	{
        printDefects( result.failures, result.failureCount, Strings.nameFailure ) ;
	}

	/**
	 * The runTime parameter can either be a Number or a Date. 
 	 */
    public function printHeader( runTime:Number ):Void
	{
		writeLine( "" );
		writeLine( new StringFormatter( Strings.PrtTime ).format( elapsedTimeAsString( runTime ) ) ) ;
	}

	/**
	 * 
	 */	
    public function printDefects( booBoos:Array, /*Int*/ count:Number, type:String ):Void
	{
        var i:Number ;
        if( count == 0 )
		{
			return;
		}
		if( count == 1 )
		{
			writeLine( "" );
			writeLine( new StringFormatter( Strings.PrtOneDefect ).format( count, type ) ) ;
		}
        else
		{
            writeLine( "" );
            writeLine( new StringFormatter( Strings.PrtMoreDefects ).format( count, type ) ) ;
		}
		var len:Number = booBoos.length ;
	    for( i = 0 ; i < len ; i++ )
		{
			printDefectHeader( booBoos[i], i );
			printDefectTrace( booBoos[i] );
		}
	}
    
	/**
	 * 
	 */
    public function printDefectHeader( booBoo:TestFailure, /*Int*/ count:Number ):Void
	{
        writeLine( count + ") " + booBoo.failedTest );
	}
    
	/**
	 * 
	 */
    public function printDefectTrace( booBoo:TestFailure ):Void
	{
        /*!## TODO: find a way to have more detais about the code stack */
        //writeLine( booBoo.exceptionMessage ); //short error message
        writeLine( booBoo.thrownException ); //long error message
        writeLine( "" );
	}
    
	public function printFooter( result:TestResult ):Void
	{
        if( result.wasSuccessful() == true )
		{
			writeLine( "" );
			writeLine( new StringFormatter( Strings.PrtOK ).format( result.runCount, (result.runCount == 1 ? "": "s") ) ) ;
		}
        else
		{
			writeLine( "" );
			writeLine( Strings.PrtFailure ) ;
			writeLine( new StringFormatter( Strings.PrtFailureDetails).format( result.runCount, result.failureCount, result.errorCount ) ); //core2
		}
        writeLine( "" );
	}
    
	public function startTest(test : ITest) : Void 
	{
		//
	}

    public function writeLine( message:String ):Void
	{
		writer.call(this, message) ;
	}
    
    private var _column:Number;
    
    private var _writer:Function;

}