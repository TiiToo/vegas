<?php

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