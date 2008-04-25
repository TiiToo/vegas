<?php

	require("test/vo/UserVO.php") ;
	
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
					"description" => "Returns a user.",
					"access"      => "remote"
				)
			) ;
			
		}
		
		/**
		 * Returns a UserVO instance.
		 */
		function getUser( $name, $age, $url ) 
		{
			return new User( $name, $age, $url ) ;
		}
	
	}

?>