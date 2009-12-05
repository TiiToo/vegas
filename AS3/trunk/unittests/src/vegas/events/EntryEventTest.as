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
  
*/

package vegas.events
{
    import buRRRn.ASTUce.framework.TestCase;

    import system.data.Entry;
    import system.data.maps.MapEntry;
    
    public class EntryEventTest extends TestCase 
    {
        public function EntryEventTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var e:EntryEvent = new EntryEvent("type", new MapEntry("key", "value")) ;
            assertNotNull(e , "EntryEvent constructor failed.") ;
        }
        
        public function testClone():void
        {
            var i:Entry      = new MapEntry("key", "value") ;
            var e:EntryEvent = new EntryEvent("type", i) ;
            var c:EntryEvent = e.clone() as EntryEvent ;
            assertNotNull(c , "01 - EntryEvent clone failed.") ;
            assertEquals(c.key   , e.key, "02 - EntryEvent clone failed.") ;
            assertEquals(c.value , e.value, "03 - EntryEvent clone failed.") ;
        }
        
        public function testToString():void
        {
            var e:EntryEvent = new EntryEvent("type", new MapEntry("key", "value")) ;
            assertEquals(e.toString() , '[EntryEvent type="type" entry=[MapEntry key:key value:value] target=null context=null bubbles=false cancelable=false eventPhase=2]',  "EntryEvent toString failed.") ;
        }
    }
}
