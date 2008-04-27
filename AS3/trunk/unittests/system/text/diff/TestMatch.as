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
