/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import buRRRn.ASTUce.TestCase;

import vegas.core.HashCode;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestHashCode extends TestCase 
{
	
	/**
	 * Creates a new TestHashCode instance.
	 */
	function TestHashCode( name:String ) 
	{
		super(name);
	}
	
	public function testEquals()
	{
		var o = {} ;
		var value = HashCode.equals(o, o) ;
		assertTrue( value , "HASH_01 - equals method failed : " + value) ;
	}

	public function testIdentify():Void 
	{
		var o = {} ;
		var value = HashCode.identify(o) ;
		assertTrue( !isNaN(value) , "HASH_02 - identifiy method failed : " + value) ;
	}
	
	public function testNext():Void 
	{
		var value = HashCode.next() ;
		assertTrue( !isNaN(value) , "HASH_03 - next method failed, the value is not a number : " + value) ;
	}

	public function testNextName():Void 
	{
		var o = {} ;
		var previous = HashCode.identify(o) ;
		var next = HashCode.nextName() ;
		assertTrue( Number(next) > previous , "HASH_04 - nextName method failed, previous:" + previous + ", next:" + next ) ;
	}
	
	public function initialize():Void 
	{
		var o = {} ;
		var b = HashCode.initialize(o) ;
		assertTrue( b , "HASH_05 - initialize method failed : " + b ) ;
	}	

}