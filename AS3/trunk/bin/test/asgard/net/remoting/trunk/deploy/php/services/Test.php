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
			
        ) ;
		
	}
	
	/**
	 * Basic "hello world" method.
	 * @param $who a String value.
	 * @return a string
	 */
	 
	function hello( $who ) 
	{
		if ( $who == "" )
		{
			trigger_error("The argument of the 'hello' method not must be empty.") ;
		}
		return "hello " . $who . " !" ;
	}

	/**
	 * Returns a Date object.
	 * @return a Date object.
	 */
	function getDate($date) 
	{
		return $date ;
	}
	
}

?>