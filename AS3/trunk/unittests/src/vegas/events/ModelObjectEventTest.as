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

package vegas.events
{
    import buRRRn.ASTUce.framework.TestCase;

    public class ModelObjectEventTest extends TestCase 
    {
        public function ModelObjectEventTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var e:ModelObjectEvent = new ModelObjectEvent("type") ;
            assertNotNull(e , "ModelObjectEvent constructor failed.") ;
        }
        
        public function testClone():void
        {
            var e:ModelObjectEvent = new ModelObjectEvent("type") ;
            var c:ModelObjectEvent = e.clone() as ModelObjectEvent ;
            assertNotNull(c , "01 - ModelObjectEvent clone failed.") ;
        }
    }
}
