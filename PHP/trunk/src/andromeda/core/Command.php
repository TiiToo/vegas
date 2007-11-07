<?php

/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * A command is a easy entry with name and value property to launch a global command in the Commands static tool class.
 * <p><b>Example :</b></p>
 * {code
 * function trace( $message )
 * {
 *     echo $message . "<br>" ;
 * }
 * 
 * $command = new Command( "myCommand" , "myValue" , "myChannel" ) ;
 * trace($command) ;
 * }
 * @author eKameleon
 */
class Command 
{

 	/**
	 * Creates a new Command instance.
	 */ 
	public function Command( $name=NULL , $value=NULL, $channel=NULL ) 
	{
		$this->name    = $name    ;
		$this->value   = $value   ;
		$this->channel = $channel ;
	}

	/**
	 * The internal string message used in the constructor if the constructor notify an IllegalArgumentError.
	 */
	const CONSTRUCTOR_ERROR /* String */= ", you can't create this instance without 'name' definition." ;
	
	/**
	 * The channel of this command.
	 */
	var $channel /* String */;

	/**
	 * The command's type name.
	 */
	var $name /* String */ ;
	
	/**
	 * The value of this command.
	 */
	var $value ;
	
	/**
	 * Register the explicit type in the AMF class mapping.
	 */
	var $_explicitType = "Command";
	
	/**
	 * Returns a String representation of the object.
	 * @return a String representation of the object.
	 */
	public function __toString() /*String*/
	{
		
		$txt /*String*/ = "[Command" ;
		
		if ( isset($this->name) ) 
		{
			$txt .= " name:" + $this->name ;
		}
		
		if ( isset($this->channel) ) 
		{
			$txt .= " channel:" + $this->channel ;
		}
		
		$txt .= "]";
		
		return $txt ; 
		
    }

}

?>
