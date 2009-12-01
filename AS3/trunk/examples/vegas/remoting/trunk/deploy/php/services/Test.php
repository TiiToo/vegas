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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * The basic Test AMFPHP service.
 */
class Test 
{
	
	/**
	 * Creates a new Test instance.
	 */
	function Test () 
	{
		$this->methodTable = array 
		(
        	"hello" => array 
        	(
				"access"      => "remote"           ,
				"description" => "return a message" ,
			)
			,
			"getDate" => array 
			(
				"access"      => "remote"      , 
				"description" => "return date" ,
				"returns"     => "date"
			)
			,
			"run" => array 
			(
				"access"      => "remote"      , 
				"description" => "return a test" 
			)
        ) ;
	}
	
	function hello( $who ) 
	{
		if ( $who == "" )
		{
			trigger_error("The argument of the 'hello' method not must be empty.") ;
		}
		return "hello " . $who . " !" ;
	}
	
	function getDate($date) 
	{
		return $date ;
	}
	
	function run()
	{
		return "test" ;
	}
	
}

?>