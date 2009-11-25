<?php

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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

require("../src/test/vo/UserVO.php") ;

/**
 * This service test the class mapping with AMFPHP.
 */
class TestClassMapping 
{
	
	function TestClassMapping () 
	{
	
		$this->methodTable = array 
		(
			"getUser" => array
			(
				"description" => "Returns an UserVO reference.",
				"access"      => "remote"
			)
		) ;
		
	}
	
	/**
	 * Returns a UserVO instance.
	 */
	function getUser( $name, $age, $url ) 
	{
		return new UserVO( $name, $age, $url ) ;
	}

}

?>