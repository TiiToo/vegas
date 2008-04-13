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
package system.text.utils 
{
	import buRRRn.ASTUce.framework.TestCase;				

	/**
	 * Read the http://neil.fraser.name/writing/diff/ page to understand the algo.
	 * @author eKameleon
	 */
	public class TestMatch extends TestCase 
	{

		public function TestMatch(name:String = "")
		{
			super( name );
		}
		
        public function testBalance():void
        {
        	assertEquals( Match.balance, 0.5, "Match.balance constant value failed." ) ;
        }
        
        public function testMaxBits():void
        {
            assertEquals( Match.maxBits, getMaxBits(), "Match.maxBits constant value failed." ) ;
        }
        
        public function testMaxLength():void
        {
            assertEquals( Match.maxLength, 1000, "Match.maxLength constant value failed." ) ;
        }
        
        public function testMinLength():void
        {
            assertEquals( Match.minLength, 100, "Match.minLength constant value failed." ) ;
        }
        
        public function testThreshold():void
        {
            assertEquals( Match.threshold, 0.5, "Match.threshold constant value failed." ) ;
        }
        
        public function testAlphabet():void
        {
        	// FIXME finish unit test.
        }
        
        public function testBitap():void
        {
            // FIXME finish unit test.
        }
        
        public function testBitapScore():void
        {
        	// FIXME finish unit test.
        }
        
        public function testMain():void
        {
        	// FIXME finish unit test.
        }  
        
	}
}
