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

import Tests.vegas.core.TestInterfaces.TypeableImplementation;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestITypeable extends TestCase
{
	
	function TestITypeable( name:String ) 
	{
		super(name);
	}
	
	public var i:TypeableImplementation ;
	
	public function setUp():Void
	{
		i = new TypeableImplementation() ;
		i.setType(String) ;	
	}

	public function TestGetType():Void 
	{
		assertEquals(i.getType(), String, "ITYP_01 getType method failed.") ;
	}

	public function TestSetType():Void 
	{
		i.setType(String) ;	
		assertEquals(i.getType(), String, "ITYP_02 setType method failed." ) ;
	}


}