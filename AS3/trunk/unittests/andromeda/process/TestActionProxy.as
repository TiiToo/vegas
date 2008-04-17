/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.process 
{
	import buRRRn.ASTUce.framework.TestCase;											

	/**
	 * @author eKameleon
	 */
	public class TestActionProxy extends TestCase 
	{

		public function TestActionProxy(name:String = "")
		{
			super(name);
		}
		
        public var action:ActionProxy ;		
		
		public var scope:Object ;
		
        public function setUp():void
        {
        	
        	
        	scope = {} ;
        	scope.toString = function():String
        	{
        	   return "[scope]" ;	
        	};
            
            var method:Function = function( ...args:Array ):void
            {
            	throw new Error("method with : " + args.length ) ;	
            };
        	
            action = new ActionProxy(scope, method, ["hello world", "hello city", "hello actionscript"] ) ;
            
        }
        
        public function tearDown():void
        {
            action = undefined ;
        }
        
        public function testArgs():void
        {
        	var args:Array = action.args ;
        	assertNotNull ( args        , "args property not must be null." ) ;
        	assertEquals  ( args.length , 3                    , "args property length isn't valid." ) ;
            assertEquals  ( args[0]     , "hello world"        , "args[0] isn't valid." ) ;	
            assertEquals  ( args[1]     , "hello city"         , "args[1] isn't valid." ) ;
            assertEquals  ( args[2]     , "hello actionscript" , "args[2] isn't valid." ) ;
        }
        
        public function testMethod():void
        {
            assertNotNull ( action.method , "method property not must be null." ) ;
        }
		
        public function testScope():void
        {
            assertNotNull ( action.scope , "scope property not must be null." ) ;
            assertEquals  ( action.scope , scope ,  "scope property must be valid." ) ;
        }
        
        public function testClone():void
        {
        	
        	var clone:ActionProxy = action.clone() ;

        	assertNotNull( clone                      , "clone method failed, with a null shallow copy object." ) ;
        	assertNotSame( clone       , action       , "clone method failed, the shallow copy isn't the same with the action object." ) ;
        	assertEquals ( clone.scope , action.scope , "clone method failed, the clone and action scope object must be the same." ) ;
        	assertEquals ( clone.args  , action.args  , "clone method failed, the clone and action args object must be the same." ) ;
        	
        }
        
        public function testRun():void
        {
        	
        }
		
	}
}


