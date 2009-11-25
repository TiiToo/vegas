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

/**
 * The user value object class.
 */
class UserVO
{
	
	/**
	 * Creates a new UserVO instance.
	 */
	function UserVO ( $name, $age , $url )
	{
		$this->name = $name ;
		$this->age  = $age  ;
		$this->url  = $url  ;
	}
	
	/**
	 * The age value.
	 */
	var $age ;
	
	/**
	 * The name value.
	 */
	var $name ;
	
	/**
	 * The url value.
	 */
	var $url ;
	
	/**
	 * The AMFPHP private property to register the object.
	 */
	var $_explicitType = "UserVO" ;
	
}
	

?>