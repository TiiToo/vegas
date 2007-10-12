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

/**
 * Configure the ASTUce framework messages.
 * Attention : The framework can test itself only with english messages due to the ComparisonFailureTest which compare results to english message.
 * @author eKameleon
 */
class buRRRn.ASTUce.Strings 
{
	
	/**
	 * {0}expected not same
 	 */
	public static var expectedNotSame:String = "{0}expected not same";

	/**
	 * {0}expected same:<{1}> was not:<{2}> 
	 */
	public static var expectedSame:String = "{0}expected same:<{1}> was not:<{2}>";
	
	/**
	 * {0}expected:<{1}> but was:<{2}>
	 */
	public static var expectedButWas:String = "{0}expected:<{1}> but was:<{2}>";
	
	/**
	 * The method name is null
	 */
	public static var methodNameNull:String = "The method name is null";
	
	/**
	 * The method name is undefined 
	 */
	public static var methodNameUndef:String = "The method name is undefined";
	
	/**
	 * Method "{0}" not found
	 */
	public static var methodNotFound:String = "Method \"{0}\" not found";
	
	/**
	 * Method "{0}" should be public
	 */
	public static var methodshouldBePublic:String = "Method \"{0}\" should be public";
	
	/**
	 * Object "{0}" is not a constructor
	 */
	public static var objectNotCtor:String = "Object \"{0}\" is not a constructor";
	
	/**
	 * Constructor "{0}" is not public
	 */
	public static var ctorNotPublic:String = "Constructor \"{0}\" is not public";
	
	/**
	 * No tests found in "{0}"
	 */
	public static var noTestsFound:String = "No tests found in \"{0}\"";
	
	/**
	 * The argument "test" does not exist in the objects namespace (check your includes!)
	 */
	public static var argTestDoesNotExist:String = "the argument \"test\" does not exist in the objects namespace (check your includes!)";
	
	/**
	 * The argument "test" does not inherit from TestCase or TestSuite
	 */
	public static var argTestNotATest:String = "the argument \"test\" does not inherit from TestCase or TestSuite";
	
	/**
	 * Test method "{0}" isn't public
	 */
	public static var testMethNotPublic:String = "Test method \"{0}\" isn't public";
	
	/**
	 * Cannot instantiate "{0}" test case
	 */
	public static var canNotCreateTest:String = "Cannot instantiate \"{0}\" test case";
	
	/**
	 * error
	 */
	public static var nameError:String = "error";
	
	/* Property: nameFailure
	   failure
	*/
	public static var nameFailure:String = "failure";
	
	/**
	 * Time: {0}
	 */
	public static var PrtTime:String  = "Time : {0}";
	
	/**
	 * {0}h:{1}mn:{2}s:{3}ms
	 */
	public static var PrtElapsedTime:String = "{0}h:{1}mn:{2}s:{3}ms";
	
	/**
	 * There was {0} {1}
	 */
	public static var PrtOneDefect:String = "There was {0} {1}:";
	
	/**
	 * There were {0} {1}s
	 */
	public static var PrtMoreDefects:String = "There were {0} {1}s:";
	
	/**
	 * OK ({0} test{1})
	 */
	public static var PrtOK:String = "OK ({0} test{1})";
		
	/**
	 * FAILURES!!!
	 */
	public static var PrtFailure:String = "FAILURES !!!";
	
	/**
	 * Tests run: {0},  Failures: {1},  Errors: {2}
	 */
	public static var PrtFailureDetails:String = "Tests run : {0},  Failures: {1},  Errors: {2}";
	
}