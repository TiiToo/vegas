
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
 
*/

if( !buRRRn.ASTUce  )
    {
    /* Singleton: buRRRn.ASTUce
       The ASTUce framework.
    */
    buRRRn.ASTUce = {};
    }

/* StaticMethod: getInfo
   Returns information about the ASTUce framework.
*/
buRRRn.ASTUce.getInfo = function()
    {
    var str, CRLF;
    str = "";
    CRLF = "\n";
    
    if( this.verbose )
        {
        str += this._name + ": " + this._fullName + " v" + this._version;
        }
    else
        {
        str += this._name + " v" + this._version;
        }
    
    /*!## TODO: change copyright notice */
    if( this.verbose )
        {
        str += CRLF;
        str += "Copyright (c) 2004-2005 Zwetan Kjukov, All right reserved." +CRLF
        str += "Made in the EU.";
        }
    
    return str;
    }

/* StaticMethod: main
   Execute the main process of the ASTUce framework.
*/
buRRRn.ASTUce.main = function()
    {
    
    var separator = "----------------------------------------------------------------";
    
	trace( separator );
    
    var runner = new buRRRn.ASTUce.MiniRunner( "Main Tests" );
    
    if( this.testMyself )
        {
        
        runner.setUp = function()
            {
            this.suite.addTest( Tests.AllTests.suite() );
            }
        
        }
    
    if( arguments.length > 0 )
        {
        for( var i=0; i<arguments.length; i++ )
            {
            runner.suite.addTest( arguments[i] );
            }
        }
    
    trace( this.getInfo() );
    trace( separator );
    runner.run();
    trace( separator );
    
    if( this.showConstructorList )
        {
        trace( runner.suite );
        trace( separator );
        }
    }

/* StaticPrivateProperty: _name
   The code name of the framework.
*/
buRRRn.ASTUce._name = "ASTUce";

/* StaticPrivateProperty: _fullName
   The full name of the framework.
*/
buRRRn.ASTUce._fullName = "ActionScript Test Unit compact edition";

/* StaticPrivateProperty: _version
   The version as string of the framework.
*/
buRRRn.ASTUce._version = "1.0.0";

/* StaticPrivateProperty: _platform
   The target platform of the framework.
*/
buRRRn.ASTUce._platform = "ECMA-262";

// ----o load ASTUce framework

load( "./library/buRRRn/ASTUce/Assertion.js" ) ;
load( "./library/buRRRn/ASTUce/AssertionFailedError.js" ) ;
load( "./library/buRRRn/ASTUce/ComparisonFailure.js" ) ;
load( "./library/buRRRn/ASTUce/config.js" ) ;
load( "./library/buRRRn/ASTUce/IProtectable.js" ) ;
load( "./library/buRRRn/ASTUce/ITest.js" ) ;
load( "./library/buRRRn/ASTUce/ITestListener.js" ) ;
load( "./library/buRRRn/ASTUce/MiniRunner.js" ) ;
load( "./library/buRRRn/ASTUce/ResultPrinter.js" ) ;
load( "./library/buRRRn/ASTUce/samples.js" ) ;
load( "./library/buRRRn/ASTUce/strings.js" ) ;
load( "./library/buRRRn/ASTUce/TestCase.js" ) ;
load( "./library/buRRRn/ASTUce/TestFailure.js" ) ;
load( "./library/buRRRn/ASTUce/TestResult.js" ) ;
load( "./library/buRRRn/ASTUce/TestSuite.js" ) ;
