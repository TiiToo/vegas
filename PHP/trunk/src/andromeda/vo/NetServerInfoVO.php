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
 * The information value object send by the server to the client.
 * @author eKameleon
 */
class NetServerInfoVO 
{

    /**
	 * Creates a new NetServerInfoVO instance.
	 */
	function NetServerInfoVO( $code=null , $description=null , $level=null, $line=null, $methodName=null , $serviceName=null ) 
	{
		$this->code         = $code ;
		$this->description  = $description ;
		$this->level        = $level ;
		$this->line         = $line ;
		$this->methodName   = $methodName ;
		$this->serviceName  = $serviceName ;
    } 

	/**
	 * The code of the error.
	 */
	var $code /*String*/ = null ;
	
	/**
	 * The default description of the error.
	 */
	var $description /*String*/ = null  ;

	/**
	 * The level of this information object.
	 */
	var $level /*String*/ = null ;  
	
	/**
	 *  The line number of the error.
	 */
	var $line /*Number*/ = null ;
	
	/**
	 * The name of the method called.
	 */
	var $methodName /*String*/ = null  ;
	
	/**
	 * The name of the service used.
	 */
	var $serviceName  /*String*/  = null ;
	
	/**
	 * Register the explicit type in AMF class mapping.
	 */
	var $_explicitType = "NetServerInfoVO";
	
}

?>
