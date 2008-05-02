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
	public class PatchTest extends TestCase 
	{

		public function PatchTest(name:String = "")
		{
			super( name );
		}
         
        public function setUp():void
        {
            Array.prototype.toString = function():String
            {
                 return "[" + this.join(",") + "]" ;    
            };
        }
        
        public function tearDown():void
        {
            Array.prototype.toString = undefined ;
        }
        
        public function testMargin():void
        {
            // FIXME finish unit test of this property
        }
        
        
        public function testAddContext():void
        {
            // FIXME finish unit test.
        }
        
        public function testFromText():void
        {
            // FIXME finish unit test.
        }
        
        public function testSplitMax():void
        {
            // FIXME finish unit test.
        }
        
        public function testToText():void
        {
            // FIXME finish unit test.
        }         
         
	}
}
