/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.ioc.evaluators 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;

    import system.evaluators.PropertyEvaluator;

    import vegas.ioc.factory.ObjectConfig;

    public class ConfigEvaluatorTest extends TestCase 
    {
        public function ConfigEvaluatorTest(name:String = "")
        {
            super(name);
        }
        
        public var configurator:ObjectConfig ;
        
        public var evaluator:ConfigEvaluator ;
        
        public var init:Object ;
        
        public function setUp():void
        {
            init =
            {
                message : "hello world" ,
                menu    :
                {
                    title : "my title" ,
                    count : 10 ,
                    data  : [ "item1" , "item2", "item3" ]
                }
            } ;
            configurator = new ObjectConfig() ;
            configurator.config = init ;
            evaluator    = new ConfigEvaluator( configurator ) ;
        }
        
        public function tearDown():void
        {
            configurator = null ;
            evaluator    = null ;
        }
        
        public function testInherit():void
        {
            assertTrue( evaluator is PropertyEvaluator ) ;
        }
        
        public function testConstructorWithEmptyArgument():void
        {
            evaluator = new ConfigEvaluator() ;
            assertNotNull( evaluator , "constructor failed, the instance not must be null.") ;
            assertNull( evaluator.target  , "constructor failed, the defined target must be null." ) ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( evaluator , "01 - constructor failed, the instance not must be null.") ;
            assertEquals( evaluator.config , configurator , "02 - constructor failed." ) ;
            assertNotNull( evaluator.target , "03 - constructor failed." ) ;
        }
        
        public function testEval():void
        {
            assertEquals( evaluator.eval( "message" ) , "hello world" ) ;
            assertEquals( evaluator.eval( "menu"       ) , init.menu ) ;
            assertEquals( evaluator.eval( "menu.title")  , "my title")  ; 
            assertEquals( evaluator.eval( "menu.count" ) , 10 ) ; 
            ArrayAssert.assertEquals( evaluator.eval( "menu.data"  ) , [ "item1" , "item2", "item3" ]) ; 
        }
        
        public function testEvalFail():void
        {
            assertNull( evaluator.eval( "test" ) ) ;
            assertNull( evaluator.eval( "menu.test"  ) ) ; // null
        }
    }
}
