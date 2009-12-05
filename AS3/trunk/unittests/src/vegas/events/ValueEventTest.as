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

    public class ValueEventTest extends TestCase 
    {
        public function ValueEventTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var e:ValueEvent = new ValueEvent("type", "value") ;
            assertNotNull(e , "ValueEvent constructor failed.") ;
        }
        
        public function testClone():void
        {
            var e:ValueEvent = new ValueEvent("type", "value") ;
            var c:ValueEvent = e.clone() as ValueEvent ;
            assertNotNull(c , "01 - ValueEvent clone failed.") ;
            assertEquals(c.value , e.value, "02 - ValueEvent clone failed.") ;
        }
        
        public function testToString():void
        {
            var e:ValueEvent = new ValueEvent("type", "value") ;
            assertEquals(e.toString() , '[ValueEvent type="type" value="value" target=null context=null bubbles=false cancelable=false eventPhase=2]',  "ValueEvent toString failed.") ;
        }
    }
}
