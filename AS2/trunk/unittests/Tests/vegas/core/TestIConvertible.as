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

import Tests.vegas.core.TestInterfaces.ConvertibleImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestIConvertible extends TestCase
{
	
	/**
	 * Creates a new TestIConvertible instance.
	 */
	function TestIConvertible( name:String ) 
	{
		super(name);
	}

	public var imp:ConvertibleImplementation ;

	public function setUp():Void
	{
		imp = new ConvertibleImplementation() ;
	}	

	public function testToBoolean():Void
	{
		assertTrue( imp.toBoolean(), "ICONVERT_01 toBoolean method failed.") ;
	}

	public function testToNumber():Void
	{
		assertTrue( imp.toNumber() == 1, "ICONVERT_02 toNumber method failed.") ;
	}

	public function testToObject():Void
	{
		assertTrue( imp.toObject().prop, "ICONVERT_03 toObject method failed.") ;
	}

}