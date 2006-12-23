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

import Tests.vegas.core.TestInterfaces.ComparatorImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestIComparator extends TestCase
{

	function TestIComparator( name:String ) 
	{
		super(name);
	}
	
	public var c:ComparatorImplementation ;

	public function setUp():Void
	{
		c = new ComparatorImplementation() ;
	}	
	
	public function testCompare():Void
	{
		assertEquals( c.compare( this, this ), 0, "ICOMPAR_01 compare method failed.") ;
	}

	public function testEquals():Void
	{
		assertTrue( c.equals( this ), "ICOMPAR_02 equals method failed.") ;
	}

}