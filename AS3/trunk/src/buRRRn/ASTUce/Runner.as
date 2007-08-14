
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
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package buRRRn.ASTUce
    {
    import system.Reflection;
    import system.Console;
    import system.Strings;
    
    import buRRRn.ASTUce.strings;
    import buRRRn.ASTUce.config;
    
    import buRRRn.ASTUce.framework.*;
    
    import buRRRn.ASTUce.runner.BaseTestRunner;
    import buRRRn.ASTUce.ui.ResultPrinter;
    
    /* Class: Runner
       This is the default TestRunner for ASTUce
    */
    public class Runner extends BaseTestRunner
        {
        private var _printer:ResultPrinter;
        
        static protected function displayHeader():void
            {
            //Console.writeLine( buRRRn.ASTUce.info() );
            //Console.writeLine( strings.separator );
            buRRRn.ASTUce.info();
            }
        
        static protected function displayInfos( suite:ITest, result:TestResult ):void
            {
            if( config.showConstructorList )
                {
                Console.writeLine( suite );
                }
            }
        
        protected override function runFailed( message:String ):void
            {
            Console.writeLine( message );
            }
        
        /* Constructor: Runner
           Constructs a TestRunner,
           using the given class writer if provided.
           
           note:
           The default class writer for ResultPrinter is system.Console.
           
           For building a custom class writer, you have to define
           a class with a static method having this signature
           (code)
           static public function writeLine( ...messages ):void
           (end)
        */
        public function Runner( writer:Class = null )
            {
            _printer = new ResultPrinter( writer );
            }
        
        public function get printer():*
            {
            return _printer;
            }
        
        public function set printer( printer:* ):void
            {
            _printer = printer;
            }
        
        public function getTestName( any:* ):String
            {
            if( any == null )
                {
                return "null";
                }
            
            if( any is String )
                {
                return any;
                }
            
            if( any is ITest )
                {
                return any.name;
                }
            
            if( any is Class )
                {
                return Reflection.getClassName( any, true );
                }
            
            return "";
            }
        
        /* Runs a multiple test and collects their results.
        */
        static public function main( ...args ):void
            {
            var result:TestResult;
            var runner:Runner = new Runner();
            var suiteName:String;
            
            displayHeader();
            
            for( var i:int=0; i<args.length; i++ )
                {
                suiteName = runner.getTestName( args[i] );
                Console.writeLine( Strings.format( _strings.runTitle, suiteName, i ) );
                
                try
                    {
                    result = run( args[i], runner );
                    }
                catch( e:NullSuiteError )
                    {
                    runner.runFailed( _strings.nullTestsuite );
                    }
                catch( e:Error )
                    {
                    runner.runFailed( Strings.format( _strings.canNotCreateAndRun, i ) );
                    runner.runFailed( Strings.format( _strings.tab, e.toString() ) );
                    }
                
                Console.writeLine( strings.separator );
                }
            }
        
        /* Runs a single test and collects its results.
           This method can be used to start a test run
           from your program.
           
           Parameters:
           test - can be a ITest (TestCase,TestSuite,etc.), a Class or a String
           
           note:
           In the case of a string parameter, the runner will first try to
           locate a static suite() method, and if it can not find it
           then will try to extract a test suite automatically.
        */
        static public function run( test:*, runner:Runner = null ):TestResult
            {
            if( runner == null )
                {
                runner = new Runner();
                displayHeader();
                }
            
            var suite:ITest;
            
            
            if( test == null )
                {
                throw new NullSuiteError();
                }
            
            if( test is String )
                {
                suite = runner.getTest( test );
                }
            
            if( test is ITest )
                {
                suite = test;
                }
            
            if( test is Class )
                {
                var staticSuite:* = Reflection.getMethodByName( test, "suite" );
                
                if( staticSuite != null )
                    {
                    suite = staticSuite();
                    }
                else
                    {
                    suite = new TestSuite( test );
                    }
                }
            
            return runner.doRun( suite );
            }
        
        public function doRun( suite:ITest ):TestResult
            {
            var result:TestResult = new TestResult();
            result.addListener( printer );
            
            /* note:
               we use the Date class to not be dependent
               on flash getTimer()
            */
            var startTime:Number = new Date().valueOf();
            suite.run( result );
            var endTime:Number   = new Date().valueOf();
            
            var runTime:Number   = endTime - startTime;
            printer.print( result, runTime );
            
            displayInfos( suite, result );
            
            return result;
            }
        
        }
    
    }

internal var _strings:Object = {};
             _strings.runTitle           = "[{0}] #{1}";
             _strings.tab                = "    {0}";
             _strings.nullTestsuite      = "Could not create and run a null test suite";
             _strings.canNotCreateAndRun = "Could not create and run test suite #{0}.";

internal class NullSuiteError extends Error
    {
    
    }


