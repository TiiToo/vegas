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

package vegas.ioc 
{
    import buRRRn.ASTUce.framework.TestCase;

    public class ObjectReceiverTest extends TestCase 
    {
        public function ObjectReceiverTest(name:String = "")
        {
            super(name);
        }
        
        public var receiver:ObjectReceiver ;
        
        public function setUp():void
        {
            receiver = new ObjectReceiver( "signal" , "slot" , 10 , true , ObjectOrder.BEFORE ) ;
        }
        
        public function tearDown():void
        {
            receiver = null ;
        }
        
        public function testDefaultConstructor():void
        {
            receiver = new ObjectReceiver("signal") ;
            assertEquals( "signal" , receiver.signal ) ;
            assertNull( receiver.slot ) ;
            assertEquals( 0 , receiver.priority ) ;
            assertFalse( receiver.autoDisconnect ) ;
            assertEquals( ObjectOrder.AFTER , receiver.order ) ;
            
            receiver = new ObjectReceiver(null) ;
            assertNull( receiver.signal ) ;
        }
        
        public function testConstructor():void
        {
            assertEquals( "signal" , receiver.signal ) ;
            assertEquals( "slot" , receiver.slot ) ;
            assertEquals( 10 , receiver.priority ) ;
            assertTrue( receiver.autoDisconnect ) ;
            assertEquals( ObjectOrder.BEFORE , receiver.order ) ;
        }
        
        public function testOrder():void
        {
            assertEquals( ObjectOrder.BEFORE , receiver.order ) ;
            receiver.order = ObjectOrder.AFTER ;
            assertEquals( ObjectOrder.AFTER , receiver.order ) ;
            receiver.order = ObjectOrder.BEFORE ;
            assertEquals( ObjectOrder.BEFORE , receiver.order ) ;
            receiver.order = "unknow" ;
            assertEquals( ObjectOrder.AFTER , receiver.order ) ;
        }
        
        public function testToString():void
        {
            assertEquals( '[ObjectReceiver signal:"signal" slot:"slot" order:"before"]' , receiver.toString() ) ;
        }
    }
}
