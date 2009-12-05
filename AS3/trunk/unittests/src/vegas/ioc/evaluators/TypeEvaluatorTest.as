/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.ioc.evaluators 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.evaluators.Evaluable;
    
    import vegas.CoreObject;
    import vegas.ioc.TypePolicy;
    import vegas.ioc.factory.ObjectConfig;
    
    public class TypeEvaluatorTest extends TestCase 
    {
        public function TypeEvaluatorTest(name:String = "")
        {
            super( name );
        }
        
        public var evaluator1:TypeEvaluator ;
        
        public var evaluator2:TypeEvaluator ;
        
        public function setUp():void
        {
            evaluator1 = new TypeEvaluator() ;
            evaluator2 = new TypeEvaluator( new ObjectConfig() ) ;
        }
        
        public function tearDown():void
        {
            evaluator1 = undefined ;
            evaluator2 = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull(evaluator1 , "TypeEvaluator 01 constructor failed, the instance not must be null.") ;
            assertNotNull(evaluator2 , "TypeEvaluator 02 constructor failed, the instance not must be null.") ;
        }
        
        public function testInherit():void
        {
            assertTrue( evaluator1 is TypeEvaluator , "inherit TypeEvaluator failed.") ;
            assertTrue( evaluator1 is Evaluable    , "implements IEvaluator failed.") ;
        }
        
        public function testConfig():void
        {
            assertNull( evaluator1.config , "evaluator1.config must be null.") ;
            assertNotNull( evaluator2.config , "evaluator1.config not must be null.") ;
            assertTrue( evaluator2.config is ObjectConfig , "evaluator2.config is ObjectConfig failed.") ;
        }    
        
        public function testEvaluator1():void
        {
            assertEquals( evaluator1.eval(String)                  ,     String , "evaluator1.eval(String) failed.") ;
            assertEquals( evaluator1.eval("Object")                ,     Object , "evaluator1.eval('Object') failed.") ;
            assertEquals( evaluator1.eval("vegas.CoreObject") , CoreObject , "evaluator1.eval('vegas.CoreObject') failed.") ;
        }  
        
        public function testEvaluator2():void
        {
            
            var config:ObjectConfig = evaluator2.config ;
            config.typeAliases = [ { alias:"CoreObject" , type:"vegas.CoreObject" } ] ;
            
            config.typePolicy  = TypePolicy.ALIAS ;
            assertEquals( evaluator2.eval("CoreObject") , CoreObject , "01 - evaluator2.eval('CoreObject') failed with config.typePolicy == TypePolicy.ALIAS.") ;
            
            config.typePolicy  = TypePolicy.ALL ;
            assertEquals( evaluator2.eval("CoreObject") , CoreObject , "02 - evaluator2.eval('CoreObject') failed with config.typePolicy == TypePolicy.ALL.") ;
            
            config.typePolicy  = TypePolicy.NONE ;
            assertNull( evaluator2.eval("CoreObject") , "03 - evaluator2.eval('CoreObject') failed, must be null with config.typePolicy == TypePolicy.NONE.") ;
        }
    }
}
