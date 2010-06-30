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

package vegas.vo  
{
    import buRRRn.ASTUce.framework.TestCase;

    import core.dump;

    import system.data.ValueObject;

    public class SimpleValueObjectTest extends TestCase 
    {
        public function SimpleValueObjectTest(name:String = "")
        {
            super(name);
        }
        
        public var vo:SimpleValueObject ;
        
        public function setUp():void
        {
            vo = new SimpleValueObject() ;
        }
        
        public function tearDown():void
        {
            vo = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( vo ) ;
        }
        
        public function testConstructorWithArgument():void
        {
            vo = new SimpleValueObject( { id : "foo" } ) ;
            assertEquals( "foo" , vo.id ) ;
        }
        
        public function testInterface():void
        {
            assertTrue( vo is ValueObject ) ;
        }
        
        public function testEquals():void
        {
            assertEquals( vo , new SimpleValueObject() ) ;
            
            vo.id = "test" ;
            assertEquals( vo , new SimpleValueObject({id:"test"}) ) ;
        }
        
        public function testFormatToString():void
        {
            assertEquals( vo.formatToString() , "[SimpleValueObject]" ) ;
            assertEquals( vo.formatToString( null ) , "[SimpleValueObject]" ) ;
            assertEquals( vo.formatToString("Test") , "[Test]" ) ;
            assertEquals( vo.formatToString("Test",2) , "[Test]" ) ;
            assertEquals( vo.formatToString("Test","id") , "[Test id:null]" ) ;
        }
        
        public function testId():void
        {
            assertNull( vo.id ) ;
            vo.id = "test" ;
            assertEquals( "test" , vo.id ) ;
        }
        
        public function testToObject():void
        {
            assertEquals( "{id:undefined}" , dump(vo.toObject()) ) ;
            vo.id = "test" ;
            assertEquals( '{id:"test"}' , dump(vo.toObject()) ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( "new vegas.vo.SimpleValueObject({id:undefined})" , vo.toSource() ) ;
            vo.id = "test" ;
            assertEquals( "new vegas.vo.SimpleValueObject({id:\"test\"})" , vo.toSource() ) ;
        }
        
        public function testToStringDefault():void
        {
            assertEquals( "[SimpleValueObject id:null]" , vo.toString() ) ;
        }
        
        public function testToString():void
        {
            vo.id = "test" ;
            assertEquals( "[SimpleValueObject id:test]" , vo.toString() ) ;
        }
    }
}
