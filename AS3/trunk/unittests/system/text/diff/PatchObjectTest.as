/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/
package system.text.diff 
{
	import buRRRn.ASTUce.framework.TestCase;					

	/**
	 * Read the http://neil.fraser.name/writing/diff/ page to understand the algo.
	 * @author eKameleon
	 */
	public class PatchObjectTest extends TestCase 
	{

		public function PatchObjectTest(name:String = "")
		{
			super( name );
		}
		
		public var o:PatchObject ;
		
        public function setUp():void
        {
            o = new PatchObject() ;  
        }
        
        public function tearDown():void
        {
            o = undefined ;
        }		
		 
        public function testDiffs():void
        {
        	var result:Boolean = o.diffs is Array; 
        	assertTrue( result , "PatchObject.diffs property is Array failed : " + result  ) ;
		}
        
        public function testLength1():void
        {
            var test:Boolean = o.length1 is uint ;
            assertTrue( test , "PatchObject.length1 is uint : " + test ) ;
            assertEquals( o.length1 , 0, "PatchObject.length1 is 0 : " + o.length1 ) ;
        }        

        public function testLength2():void
        {
            var test:Boolean = o.length2 is uint ;
            assertTrue( test , "PatchObject.length2 is uint : " + test ) ;
            assertEquals( o.length2 , 0, "PatchObject.length2 is 0 : " + o.length2 ) ;
        }   

        public function testStart1():void
        {
            assertTrue( (o.start1 is uint) , "PatchObject.start1 is uint failed : " + (o.start1 is uint) ) ;
            assertEquals( o.start1, 0 , "PatchObject.start2 is 0 with an empty instance." ) ;

        }   

        public function testStart2():void
        {
            assertTrue( o.start2 is uint , "PatchObject.start2 is uint failed : " + (o.start2 is uint) ) ;
            assertEquals( o.start2, 0 , "PatchObject.start2 is 0 with an empty instance." ) ;
        }
        
        public function testToString():void
        {
            assertEquals( o.toString() , "@@ -0,0 +0,0 @@\n" , "PatchObject.toString() failed with an empty instance : " + o.toString() ) ;
        }	 
		 
	}
}
