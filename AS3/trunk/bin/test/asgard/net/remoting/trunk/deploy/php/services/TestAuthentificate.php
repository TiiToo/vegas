<?php

/**
 * The basic authentification test with credentials and AMFPHP service.
 */
class TestAuthentificate 
{
	
	/**
	 * Creates a new TestAuthentificate instance.
	 */
	function TestAuthentificate() 
	{
		$this->methodTable = array 
		(
        	"register" => array 
        	(
				"access"      => "remote"           ,
				"description" => "Register an user" ,
				"roles"       => "security"
			)
        ) ;
	}
	
	function register() 
	{
		return true ;
	}

	function _authenticate( $user, $pass ) {
		
		if ($user == "vegas" && $pass == "vegas") 
		{
			return "security" ;
		}
		else 
		{
			return false ;
		}
		
	}
}

?>