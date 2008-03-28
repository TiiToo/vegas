/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ASTUce: ActionScript Test Unit compact edition AS3]. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
  	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2007-2008)

*/
package buRRRn.ASTUce.extensions
    {
    import flash.utils.getTimer;
    
    import buRRRn.ASTUce.framework.*;
    
    /* A Decorator that runs a test
       and fails if the maximum elapsed time was exceeded.
       
       Even if the code is very close,
       a <TimedTest> is not the same as a <TimedTestCase>,
       it allows you to run any tests implementing ITest,
       and its inner-working is on the test method, not the runTest method,
       also it adds AssertionFailedError directly to the result.
       
       To use TimedTest, create a Test like:
       (code)
       var suite:TestSuite = new TestSuite( "a group of timed tests" );
       suite.addTest( new SomeTest() );
       suite.addTest( new SomeTest() );
       
       var test:ITest = new TimedTest( suite, 100 );
       (end)
       The TimedTest will check if all the tests contained in the
       TestSuite execute within the provided timeout of 100ms.
    */
    public class TimedTest extends TestDecorator
        {
        private var _maxElapsedTime:int;
        private var _startTime:int;
        private var _elapsedTime:int;
        private var _timeExceeded:Boolean;
        
        public function TimedTest( test:ITest, maxElapsedTime:int )
            {
            super( test );
            
            if( maxElapsedTime < 0 )
                {
                throw new ArgumentError( "maxElapsedTime must be > 0" );
                }
            
            _maxElapsedTime = maxElapsedTime;
            _elapsedTime    = 0;
            _timeExceeded   = false;
            }
        
        protected function get elapsedTime():int
            {
             if( _elapsedTime == 0 )
                {
                _elapsedTime = getTimer() - _startTime;
                }
            
            return _elapsedTime;
            }
        
        public override function run( result:TestResult ):void
            {
            _startTime = getTimer();
            
            super.run( result );
            
            if( elapsedTime > _maxElapsedTime )
                {
                _timeExceeded = true;
                result.addFailure( this,
                                   new AssertionFailedError("Maximum elapsed time (" + _maxElapsedTime + " ms) exceeded!") );
                }
            
            }
        
        public override function toString( ...args ):String
            {
            var msg:String;

            if( _timeExceeded )
                {
                msg = " [exceeded: " + elapsedTime + " ms]";
                }
            else
                {
                msg = " [timed: " + elapsedTime + " ms]";
                }
            
            if( test.countTestCases == 1 )
                {
                msg = " test" + msg;
                }
            else
                {
                msg = " tests" + msg;
                }
            
            msg = " : "+ test.countTestCases + msg;
            
            if( (test is TestSuite) ||
                (test is TestCase) )
                {
                return test["name"] + msg;
                }
            
            return super.toString.apply( super, args ) + msg;
            }
        
        }
    
    }

