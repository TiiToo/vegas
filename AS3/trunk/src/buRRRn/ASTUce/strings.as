
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
    
    /* Contains the string resources of the ASTUce framework.
       
       attention:
       The framework can test itself only with english messages
       due to the ComparisonFailureTest which compare results to english message.
    */
    public class strings
        {
        
        /* ----------------------------------------------------------------
        */
        static public var separator:String = "----------------------------------------------------------------";
        
        /* {0}expected not same
        */
        static public var expectedNotSame:String = "{0}expected not same";
        
        /* {0}expected same:<{1}> was not:<{2}>
        */
        static public var expectedSame:String = "{0}expected same:<{1}> was not:<{2}>";
        
        /* {0}expected:<{1}> but was:<{2}>
        */
        static public var expectedButWas:String = "{0}expected:<{1}> but was:<{2}>";
        
        /* The method name is null
        */
        static public var methodNameNull:String = "The method name is null";
        
        /* The method name is undefined
        */
        static public var methodNameUndef:String = "The method name is undefined";
        
        /* The method name is the empty string
        */
        static public var methodNameEmpty:String = "The method name is the empty string";
        
        /* Method "{0}" not found
        */
        static public var methodNotFound:String = "Method \"{0}\" not found";
        
        /* Method "{0}" should be public
        */
        static public var methodshouldBePublic:String = "Method \"{0}\" should be public";
        
        /* Object "{0}" is not a constructor
        */
        static public var objectNotCtor:String = "Object of type \"{0}\" is not a constructor";
        
        /* Constructor "{0}" is not public
        */
        static public var ctorNotPublic:String = "Constructor \"{0}\" is not public";
        
        /* Constructor "{0}" is malformed, probably the "name" argument is missing
        */
        static public var ctorIsMalformed:String = "Constructor \"{0}\" is malformed, probably the \"name\" argument is missing";
        static public var ctorIsMalformedMethod:String = "Method \"{0}\" can not be created because constructor \"{1}\" is malformed";
        
        /* Constructor "{0}" is not instanciable ({1})
        */
        static public var ctorNotInstanciable:String = "Constructor \"{0}\" is not instanciable";
        static public var ctorNotInstanciableMethod:String = "Method \"{0}\" can not be created because constructor \"{1}\" is not instanciable";
        
        /* Constructor "{0}" does not implement ITest
        */
        static public var ctorNotATest:String = "Constructor \"{0}\" does not implement ITest";
        
        /* Cannot instantiate test case "{0}" ({1})
        */
        static public var canNotInstanciateTestCase:String = "Cannot instantiate test case \"{0}\" ({1})";
        
        /* No tests found in "{0}"
        */
        static public var noTestsFound:String = "No tests found in \"{0}\"";
        
        /* the argument "test" does not exist in the objects namespace (check your includes!)
        */
        static public var argTestDoesNotExist:String = "the argument \"test\" does not exist in the namespace";
        
        /* the argument "test" does not implement ITest
        */
        static public var argTestNotATest:String = "the argument \"test\" does not implement ITest";
        
        /* Test method "{0}" isn't public
        */
        static public var testMethNotPublic:String = "Test method \"{0}\" isn't public";
        
        /* Cannot instantiate "{0}" test case
        */
        static public var canNotCreateTest:String = "Cannot instantiate \"{0}\" test case";
        
        /* error
        */
        static public var nameError:String = "error";
        
        /* failure
        */
        static public var nameFailure:String = "failure";
        
        /* Time: {0}
        */
        static public var PrtTime:String = "Time: {0}";
        
        /* {0}h:{1}mn:{2}s:{3}ms
        */
        //static public var PrtElapsedTime:String = "{0}h:{1}mn:{2}s:{3}ms";
        static public var PrtElapsedTime:String = "{h}h:{mn}mn:{s}s:{ms}ms";
        
        /* {0}) {1}
        */
        static public var PrtDefectHeader:String = "{0,4}) {1}";
        
        static public var PrtDefectTrace:String  = "{0,4}  {1}";
        
        /* There was {0} {1}
        */
        static public var PrtOneDefect:String = "There was {0} {1} :";
        
        /* There were {0} {1}s
        */
        static public var PrtMoreDefects:String = "There were {0} {1}s :";
        
        /* OK ({0} test{1})
        */
        static public var PrtOK:String = "OK ({0} test{1})";
        
        /* FAILURES!!!
        */
        static public var PrtFailure:String = "FAILURES!!!";
        
        /* Tests run: {0},  Failures: {1},  Errors: {2}
        */
        static public var PrtFailureDetails:String = "Tests run: {0},  Failures: {1},  Errors: {2}";
        
        /* <RETURN> to continue
        */
        static public var PrtWaitPrompt:String = "[ENTER] to continue";
        
        /* .
        */
        static public var PrtShortTest:String = ".";
        
        /* E
        */
        static public var PrtShortError:String = "E";
        
        /* F
        */
        static public var PrtShortFailure:String = "F";
        
        }
    
    }

