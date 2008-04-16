/*

 Diff Match and Patch
 
 The Initial Developer of the Original Code is Neil Fraser <fraser@google.com>
  Copyright 2006 Google Inc.
 http://code.google.com/p/google-diff-match-patch/
 
 This library is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2.1 of the License, or (at your option) any later version.
 
 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public
 License along with this library; if not, write to the Free Software
 Foundation, Inc, 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA
 
 Contributors : AS3 version author Alcaraz Marc (aka eKameleon) <ekameleon@gmail.com> (2007-2008).

*/
package system.text.diff 
{
	import buRRRn.ASTUce.framework.TestCase;					

	/**
	 * Read the http://neil.fraser.name/writing/diff/ page to understand the algo.
	 * @author eKameleon
	 */
	public class TestPatchObject extends TestCase 
	{

		public function TestPatchObject(name:String = "")
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
