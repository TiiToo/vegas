﻿/*
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
	public class TestGetMaxBits extends TestCase 
	{

		public function TestGetMaxBits(name:String = "")
		{
			super( name );
		}
		 
        public function testGetMaxBits():void
        {
        	assertEquals( getMaxBits() , 32 , "getMaxBits() method failed." ) ;
        }
        
	}
}
