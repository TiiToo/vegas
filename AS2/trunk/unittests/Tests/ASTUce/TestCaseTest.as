
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

import buRRRn.ASTUce.AssertionFailedError;
import buRRRn.ASTUce.ITest;
import buRRRn.ASTUce.TestCase;
import buRRRn.ASTUce.TestResult;
import buRRRn.ASTUce.TestSuite;

import Tests.ASTUce.NoArgTestCaseTest;
import Tests.ASTUce.TestCaseTests.TornDown;
import Tests.ASTUce.WasRun;

import vegas.events.Delegate;

class Tests.ASTUce.TestCaseTest extends TestCase
    {
    
    function TestCaseTest( name )
        {
        super( name );
        }
    
    function testSuccess()
        {
        var success:TestCase = new TestCase( "success" );
        
        success.runTest = function()
            {
            
            } ;
        
        verifySuccess( success );
        }
    
    function testFailure()
        {
        var failure:TestCase = new TestCase( "failure" );
        
        failure.runTest = Delegate.create(this, fail) ;
        
        verifyFailure( failure );
	}
    
    function testError()
	{
        var err:TestCase = new TestCase( "error" );
        
        err.runTest = function()
		{
            throw new Error();
		} ;
        
        verifyError( err );
	}
    
    function testSetupFails()
	{
        var fails:TestCase = new TestCase( "success" );
        
        fails.setUp = function()
		{
            throw new Error();
		} ;
        
        fails.runTest = function()
		{
            
		} ;
        
        verifyError( fails );
	}
    
    function testTearDownFails()
        {
        var fails:TestCase = new TestCase( "success" );
        
        fails.tearDown = function()
		{
            throw new Error();
        } ;
        
        fails.runTest = function()
		{
            
        } ;
        
        verifyError( fails );
	}
    
    function testCaseToString()
    {
        assertEquals( "TestCaseTest(testCaseToString)", this.toString(), "TC_001" );
    }
    
    public function testRunAndTearDownFails()
	{
        var fails:TornDown = new TornDown();
        
        fails.tearDown = function()
        {
            TornDown.prototype.tearDown.apply( this );
            throw new Error();
		} ;
        
        fails.runTest = function()
		{
            throw new Error();
        } ;
        
		verifyError( fails );
		assertTrue( fails._tornDown, "TC_002" );
        }
    
    public function testTearDownAfterError()
	{
        var fails:TornDown = new TornDown();
		
		verifyError( fails );
		assertTrue( fails._tornDown, "TC_003" );
	}
    
    public function testTearDownSetupFails()
    {
        var fails:TornDown = new TornDown();
        
        fails.setUp = function()
        {
            throw new Error();
		} ;
        
        fails.tearDown = function()
        {
            
        } ;
        
        verifyError( fails );
		assertTrue( !fails._tornDown, "TC_004" );
	}
    
    public function testWasRun()
	{
        var test:WasRun = new WasRun();
        
        test.run();
        
        assertTrue( test._wasRun, "TC_005" );
        }
    
    function testExceptionRunningAndTearDown()
        {
        var t:TornDown = new TornDown();
        
        t.tearDown = function()
		{
			throw new Error( "tearDown" );
		} ;
        
        var result:TestResult = new TestResult();
        t.run( result );
        
        var failure = result.errors[0];
        
        assertEquals( "tearDown", failure.thrownException.message, "TC_006" );
        }
    
    function testNoArgTestCasePasses()
        {
        var t:ITest = new TestSuite( NoArgTestCaseTest );
        var result:TestResult = new TestResult();
        
        t.run( result );
        
		assertTrue( result.runCount     == 1, "TC_007a" );
		assertTrue( result.failureCount == 0, "TC_007b" );
		assertTrue( result.errorCount   == 0, "TC_007c" );
        }
    
    function testNamelessTestCase()
        {
        var t:TestCase = new TestCase();
        
        try
            {
            t.run();
            fail();
            }
        catch( e )
            {
            if( e instanceof AssertionFailedError )
                {
                return;
                }
            }
        
        fail( "TC_008" );
        }
    
    function verifyError( test:TestCase )
        {
        var result:TestResult = test.runEmpty();
		assertTrue( result.runCount     == 1, "TC_009a" );
		assertTrue( result.failureCount == 0, "TC_009b" );
		assertTrue( result.errorCount   == 1, "TC_009c" );
        }
    
    function verifyFailure( test:TestCase )
        {
        var result:TestResult = test.runEmpty();
		assertTrue( result.runCount     == 1, "TC_010a" );
		assertTrue( result.failureCount == 1, "TC_010b" );
		assertTrue( result.errorCount   == 0, "TC_010c" );
        }
    
    function verifySuccess( test:TestCase )
        {
        var result:TestResult = test.runEmpty();
		assertTrue( result.runCount     == 1, "TC_011a" );
		assertTrue( result.failureCount == 0, "TC_011b" );
		assertTrue( result.errorCount   == 0, "TC_011c" );
        }
    
    }

