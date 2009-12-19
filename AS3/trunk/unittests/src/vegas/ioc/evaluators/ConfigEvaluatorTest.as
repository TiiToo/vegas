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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
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
