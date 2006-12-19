
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASTUce: ActionScript Test Unit compact edition AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

import buRRRn.ASTUce.*;

class Tests.ASTUce.TestListenerTest extends TestCase implements ITestListener
    {
    
    private var _result:TestResult;
    private var _startCount:Number;
    private var _endCount:Number;
    private var _failureCount:Number;
    private var _errorCount:Number;
    
    function TestListenerTest( name )
        {
        super( name );
        }
    
    /* Method: addError
       An error occurred.
    */
    function addError( test:ITest, e:Error ):Void
        {
        _errorCount++;
        }
    
    /* Method: addFailure
       A failure occurred.
    */
    function addFailure( test:ITest, afe:AssertionFailedError ):Void
        {
        _failureCount++;
        }
    
    /* Method: endTest
       A test ended.
    */
    function endTest( test:ITest ):Void
        {
        _endCount++;
        }
    
    /* Method: startTest
       A test started.
    */
    function startTest( test:ITest ):Void
        {
        _startCount++;
        }
    
    function setUp()
        {
        _result = new TestResult();
        _result.addListener( this );
        
        _startCount   = 0;
        _endCount     = 0;
        _failureCount = 0;
        _errorCount   = 0;
        }
    
    function testError()
        {
        var test:TestCase = new TestCase( "noop" );
        
        test.runTest = function()
            {
            throw new Error();
            }
        
        test.run( _result );
        
        assertEquals( 1, _errorCount, "TL_001a" );
        assertEquals( 1, _endCount,   "TL_001b" );
        }
    
    function testFailure()
        {
        var test:TestCase = new TestCase( "noop" );
        
        test.runTest = function()
            {
            fail();
            }
        
        test.run( _result );
        
        assertEquals( 1, _failureCount, "TL_002a" );
        assertEquals( 1, _endCount,     "TL_002b" );
        }
    
    function testStartStop()
        {
        var test:TestCase = new TestCase( "noop" );
        
        test.runTest = function()
            {
            
            }
        
        test.run( _result );
        
        assertEquals( 1, _startCount, "TL_003a" );
        assertEquals( 1, _endCount,   "TL_003b" );
        }
    
    }

