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
package andromeda.ioc.io 
{
    import andromeda.ioc.core.ObjectDefinition;
    
    import buRRRn.ASTUce.framework.TestCase;                        				

    /**
     * Test the AssemblyTest instance.
	 * @author eKameleon
	 */
	public class AssemblyEntryTest extends TestCase 
	{
        
        /**
         * Creates a new AssemblyEntryTest instance.
         * @param name The name of the test case.
         */
		public function AssemblyEntryTest(name:String = "")
		{
			super(name);
		}
		
		public var definition:ObjectDefinition ;
		
		public var entry:AssemblyEntry ;

        public function setUp():void
        {
            definition = new ObjectDefinition( "id", "type", false, false) ;
            entry = new AssemblyEntry( "id" , definition ) ;
        }

        public function tearDown():void
        {
            definition = undefined ;            
        }
        
        public function testConstructor():void
        {
        	assertNotNull( entry as AssemblyEntry , "AssemblyEntry constructor failed" ) ;
        }
        
        public function testDefinition():void
        {
        	assertSame( entry.definition , definition , "AssemblyEntry.definition failed.") ;
        }
                    
        public function testName():void
        {
        	assertEquals( entry.name , "id" , "AssemblyEntry.definition failed.") ;
        }        
        
	}
}

