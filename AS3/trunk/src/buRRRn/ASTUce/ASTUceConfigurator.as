
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
    import system.Configurator;
    
    /* Class: ASTUceConfigurator
       Configure the ASTUce framework
    */
    public class ASTUceConfigurator extends Configurator
        {
        
        public function ASTUceConfigurator( config:Object )
            {
            super( config );
            }
        
        /* Boolean option to configure the getInfo method behaviour.
           
           parameters:
           true  - more verbose
           false - less verbose
        */
        public function get verbose():Boolean
            {
            return _config.verbose;
            }
        
        public function set verbose( value:Boolean ):void
            {
            _config.verbose = value;
            }
        
        /* Boolean option to display all the constructors being tested.
           
           parameters:
           true  - show constructors list
           false - don't show constructor list
           
           note:
           Will show an indented list of tests
           (code)
            All ASTUce tests
            	{
            	Framework Tests
            		{
            		TestCaseTest
            			{
            			testCaseToString( TestCaseTest )
            			testRunAndTearDownFails( TestCaseTest )
            			testWasRun( TestCaseTest )
            			testError( TestCaseTest )
            			...
           (end)
           
        */
        public function get showConstructorList():Boolean
            {
            return _config.showConstructorList;
            }
        
        public function set showConstructorList( value:Boolean ):void
            {
            _config.showConstructorList = value;
            }
        
        /* 
           note:
           if false will show the full indentation
           (code)
            All ASTUce tests
            	{
            	Framework Tests
            		{
            		TestCaseTest
            			{
            			testCaseToString( TestCaseTest )
            			testRunAndTearDownFails( TestCaseTest )
            			testWasRun( TestCaseTest )
            			testError( TestCaseTest )
            			...
           (end)
           
           if true will show the indentation till the
           showSimpleTraceDepth
        */
        public function get showAllAsSimpleTrace():Boolean
            {
            return _config.showAllAsSimpleTrace;
            }
        
        public function set showAllAsSimpleTrace( value:Boolean ):void
            {
            _config.showAllAsSimpleTrace = value;
            }
        
        /* 
           note:
           will limit the depth of description for constructors list
           (code)
            All ASTUce tests
            	{
            	Framework Tests
            		{
            		TestCaseTest
            			{
            			13 Tests ...
            			}
            		Suite tests
            			{
            			7 Tests ...
            			}
           (end)
        */
        public function get showSimpleTraceDepth():int
            {
            return _config.showSimpleTraceDepth;
            }
        
        public function set showSimpleTraceDepth( value:int ):void
            {
            _config.showSimpleTraceDepth = value;
            }
        
        /* 
           note:
           shows the short tests
           (code)
           ...F..E...
           (end)
        */
        public function get showPrinterShortTests():Boolean
            {
            return _config.showPrinterShortTests;
            }
        
        public function set showPrinterShortTests( value:Boolean ):void
            {
            _config.showPrinterShortTests = value;
            }
        
        /* 
           note:
           need to be true to display
           - printHeader
           - printErrors
           - printFailures
           - printFooter
           - empty tests
        */
        public function get showPrinterDetails():Boolean
            {
            return _config.showPrinterDetails;
            }
        
        public function set showPrinterDetails( value:Boolean ):void
            {
            _config.showPrinterDetails = value;
            }
        
        /* 
           note:
           show the header
           (code)
           Time: 0h:0mn:0s:10ms
           (end)
        */
        public function get showPrintHeader():Boolean
            {
            return _config.showPrintHeader;
            }
        
        public function set showPrintHeader( value:Boolean ):void
            {
            _config.showPrintHeader = value;
            }
        
        /* 
           note:
           show the errors details
        */
        public function get showPrintErrors():Boolean
            {
            return _config.showPrintErrors;
            }
        
        public function set showPrintErrors( value:Boolean ):void
            {
            _config.showPrintErrors = value;
            }
        
        /* 
           note:
           show the failures details
        */
        public function get showPrintFailures():Boolean
            {
            return _config.showPrintFailures;
            }
        
        public function set showPrintFailures( value:Boolean ):void
            {
            _config.showPrintFailures = value;
            }
        
        /* note:
           show the footer
           (code)
           OK (10 tests)
           (end)
        */
        public function get showPrintFooter():Boolean
            {
            return _config.showPrintFooter;
            }
        
        public function set showPrintFooter( value:Boolean ):void
            {
            _config.showPrintFooter = value;
            }
        
        /* 
           note:
           sometimes you add a test or a test suite
           that does not contain any tests,
           il will show something as
           (code)
           [unknown]
           (end)
        */
        public function get showEmptyTests():Boolean
            {
            return _config.showEmptyTests;
            }
        
        public function set showEmptyTests( value:Boolean ):void
            {
            _config.showEmptyTests = value;
            }
        
        /* Boolean option to display the source of objects being compared.
           
           parameters:
           true  - show the object source
           false - don't show the source
           
           note:
           It help you to debug to see
           (code)
           AssertionFailedError : expected:<{a:1,b:2,c:3}> but was:<{a:1,b:2,c:4}>
           (end)
           instead of
           (code)
           AssertionFailedError : expected:<[object Object]> but was:<[object Object]>
           (end)
        */
        public function get showObjectSource():Boolean
            {
            return _config.showObjectSource;
            }
        
        public function set showObjectSource( value:Boolean ):void
            {
            _config.showObjectSource = value;
            }
        
        /* Boolean option to invert the order of the arguments: expected, actual
           see <buRRRn.ASTUce.framework.Assert>
           
           parameters:
           true  - the argument order is: actual, expected. (inverted)
           false - the argument order is: expected, actual. (default)
        */
        public function get invertExpectedActual():Boolean
            {
            return _config.invertExpectedActual;
            }
        
        public function set invertExpectedActual( value:Boolean ):void
            {
            _config.invertExpectedActual = value;
            }
        
        /* Boolean option allowing to iterate or not trough inherited tests.
           
           parameters:
           true  - iterate inherited tests
           false - does NOT iterate inherited tests
           
           note:
           If you set this option to false the following test
           SuiteTest( testInheritedTests ) will fail.
           Hopefully the failure message should direct you here ;).
           (code)
           0) testInheritedTests( SuiteTest )
              AssertionFailedError: see buRRRn.ASTUce.config.testInheritedTests
              	at buRRRn.ASTUce.framework::Assert$/fail()
              	at buRRRn.ASTUce.framework::Assert$/assertTrue()
              	at buRRRn.ASTUce.tests.framework::SuiteTest/testInheritedTests()
           (end)
        */
        public function get testInheritedTests():Boolean
            {
            return _config.testInheritedTests;
            }
        
        public function set testInheritedTests( value:Boolean ):void
            {
            _config.testInheritedTests = value;
            }
        
        /* 
           note:
           define the max column chars to display
           before returning to the line.
           -> only usefull to print short tests/failures/errors
        */
        public function get maxColumn():int
            {
            return _config.maxColumn;
            }
        
        public function set maxColumn( value:int ):void
            {
            _config.maxColumn = value;
            }
        
        /* Property: defectHeaderAsError
        */
        public function get defectHeaderAsError():Boolean
            {
            return _config.defectHeaderAsError;
            }
        
        public function set defectHeaderAsError( value:Boolean ):void
            {
            _config.defectHeaderAsError = value;
            }
        
        /* Property: allowErrorTrace
        */
        public function get allowErrorTrace():Boolean
            {
            return _config.allowErrorTrace;
            }
        
        public function set allowErrorTrace( value:Boolean ):void
            {
            _config.allowErrorTrace = value;
            }
        
        /* Property: allowStackTrace
        */
        public function get allowStackTrace():Boolean
            {
            return _config.allowStackTrace;
            }
        
        public function set allowStackTrace( value:Boolean ):void
            {
            _config.allowStackTrace = value;
            }
        
        /* 
           note:
           allow to use the filteredPatterns array
           to filter or not the errors stack trace
           set it to false if you want the full stack.
        */
        public function get filterErrorStack():Boolean
            {
            return _config.filterErrorStack;
            }
        
        public function set filterErrorStack( value:Boolean ):void
            {
            _config.filterErrorStack = value;
            }
        
        /* allow to clean some informations of the stack trace line
           
           ex:
           at buRRRn.ASTUce.samples::ArrayTest/testClone()[C:\code\sandbox\buRRRn\ASTUce\samples\ArrayTest.as:72]
           become
           at buRRRn.ASTUce.samples::ArrayTest/testClone()
           
           note:
           to remove all file system info between [ and ]
           /\[.*\]/ -> ""
           at buRRRn.ASTUce.samples::ArrayTest/testClone()[C:\code\sandbox\buRRRn\ASTUce\samples\ArrayTest.as:72]
           at buRRRn.ASTUce.samples::ArrayTest/testClone()
           
           to remove only the drive (c:\) info (windows)
           /\[[a-zA-Z]\:\\/ -> "["
           at buRRRn.ASTUce.samples::ArrayTest/testClone()[C:\code\sandbox\buRRRn\ASTUce\samples\ArrayTest.as:72]
           at buRRRn.ASTUce.samples::ArrayTest/testClone()[code\sandbox\buRRRn\ASTUce\samples\ArrayTest.as:72]
           
           to remove the drive and path info (c:\some\path) (windows)
           /\[[a-zA-Z].*\\/ -> "["
           at buRRRn.ASTUce.samples::ArrayTest/testClone()[C:\code\sandbox\buRRRn\ASTUce\samples\ArrayTest.as:72]
           at buRRRn.ASTUce.samples::ArrayTest/testClone()[ArrayTest.as:72]
        */
        public function get cleanupErrorStack():Boolean
            {
            return _config.cleanupErrorStack;
            }
        
        public function set cleanupErrorStack( value:Boolean ):void
            {
            _config.cleanupErrorStack = value;
            }
        
        /* Property: cleanupPattern
        */
        public function get cleanupPattern():RegExp
            {
            return _config.cleanupPattern;
            }
        
        public function set cleanupPattern( value:RegExp ):void
            {
            _config.cleanupPattern = value;
            }
        
        /* Property: cleanupReplacement
        */
        public function get cleanupReplacement():String
            {
            return _config.cleanupReplacement;
            }
        
        public function set cleanupReplacement( value:String ):void
            {
            _config.cleanupReplacement = value;
            }
        
        /* An Array of patterns to filter the stack trace.
           
           attention:
           Be carefull with what you add
           adding "buRRRn.ASTUce.framework"
           will filter out
             - buRRRn.ASTUce.framework::Assert$/fail()
             - buRRRn.ASTUce.framework::Assert$/assertTrue()
             - or any other Assert methods
           to not filter the AssertionFailure it is better to
           add the filters this way
           "buRRRn.ASTUce.framework::TestResult"
           "buRRRn.ASTUce.framework::TestCase"
           "buRRRn.ASTUce.framework::TestSuite"
        */
        public function get filteredPatterns():Array
            {
            return _config.filteredPatterns;
            }
        
        public function set filteredPatterns( value:Array ):void
            {
            _config.filteredPatterns = value;
            }
        
        //I want intrinsic::get/set :(
        }
    
    }

