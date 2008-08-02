/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.core 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import vegas.data.Map;
    import vegas.data.iterator.Iterator;
    import vegas.data.map.HashMap;    

    /**
     * The TypeAliases type instance.
     * @author eKameleon
     */
    public class TypeAliasesTest extends TestCase 
    {

        /**
         * Creates a new TypeAliasesTest instance.
         */
        public function TypeAliasesTest(name:String = "")
        {
            super( name );
        }
        
        public var aliases:TypeAliases ;
        
        public function setUp():void
        {
            aliases = new TypeAliases() ;
        }
        
        public function tearDown():void
        {
            aliases = undefined ;
        }        
        
        public function testConstructor():void
        {
        	assertNotNull( aliases , "TypeAliases constructor failed, the instance not must be null.") ;
        }
        
        public function testClear():void
        {
        	aliases.put("hello", "world") ;
        	aliases.clear() ;
            assertTrue( aliases.isEmpty() , "TypeAliases.clear() failed.") ;
        }
        
        public function testContainsAlias():void
        {
            aliases.put("hello", "world") ;
            assertTrue( aliases.containsAlias("hello") , "TypeAliases.containsAlias('hello') failed.") ;
            aliases.clear() ;
        }         
        
        public function testContainsValue():void
        {
            aliases.put("hello", "world") ;
            assertTrue( aliases.containsValue("world") , "TypeAliases.containsValue('world') failed.") ;
            aliases.clear() ;
        } 
        
        public function testGetAliases():void
        {
            aliases.put("hello", "world") ;
            aliases.put("hi"   , "ioc") ;
            var ar:Array = aliases.getAliases() ;
            assertNotNull( ar, "TypeAliases.getAliases() failed the array not must be null.") ;
            assertEquals( ar.length , 2, "TypeAliases.getAliases() failed with size.") ;
            aliases.clear() ;
        }
        
        public function testGetMap():void
        {
            aliases.put("hello", "world") ;
            aliases.put("hi"   , "ioc") ;
            var map:Map = aliases.getMap() ;
            assertNotNull( map, "TypeAliases.getMap() failed the Map not must be null.") ;
            assertTrue( map is HashMap, "TypeAliases.getMap() failed must be a HashMap.") ;
            aliases.clear() ;
        }
        
        public function testGetValue():void
        {
            aliases.put("hello", "world") ;
            assertEquals( aliases.getValue("hello") , "world", "TypeAliases.getValue('hello') failed.") ;
            aliases.clear() ;
        } 
        
        public function testGetValues():void
        {
            aliases.put("hello", "world") ;
            aliases.put("hi"   , "ioc") ;
            var ar:Array = aliases.getValues() ;
            assertNotNull( ar, "TypeAliases.getValues() failed the array not must be null.") ;
            assertEquals( ar.length , 2, "TypeAliases.getValues() failed with size.") ;
            aliases.clear() ;
        }        
        
        public function testIsEmpty():void
        {
            aliases.put("hello", "world") ;
            assertFalse( aliases.isEmpty() , "01 - TypeAliases.isEmpty() failed.") ;
            aliases.clear() ;
            assertTrue( aliases.isEmpty() , "02 - TypeAliases.isEmpty() failed.") ;
        }        
        
        public function testIterator():void
        {
            aliases.put("hello", "world") ;
            var it:Iterator = aliases.iterator() ;
            assertTrue( it.hasNext() , "01 - TypeAliases.iterator failed.") ;
            assertEquals( it.next() , "world", "02 - TypeAliases.iterator failed.") ;
            assertEquals( it.key() , "hello", "03 - TypeAliases.iterator failed.") ;
            aliases.clear() ;
        }
        
        public function testPut():void
        {
        	assertTrue( aliases.put("hello", "world") , "01 - TypeAliases.put failed.") ;
        	assertFalse( aliases.put(null, "world") , "02 - TypeAliases.put failed.") ;
        	assertFalse( aliases.put("hello", null) , "03 - TypeAliases.put failed.") ;
        	assertFalse( aliases.put(null, null) , "04 - TypeAliases.put failed.") ;
            aliases.clear() ;        	
        }
        
        public function testSize():void
        {
            aliases.put("hello", "world") ;
            aliases.put("hi"   , "ioc") ;
            assertEquals( aliases.size() , 2 , "01 - TypeAliases.size failed.") ;
            aliases.clear() ;
            assertEquals( aliases.size() , 0 , "02 - TypeAliases.size failed.") ;
        }  
             
    }
}
