<?php

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