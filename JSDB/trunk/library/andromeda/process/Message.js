/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedA Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * The Message process.
 * @author eKameleon
 * @extends andromeda.process.Pause
 */
if (andromeda.process.Message == undefined) 
{

	/**
	 * @requires andromeda.process.Pause
	 */
	require("andromeda.process.Pause") ;

	/**
	 * Creates a new Message instance.
	 * @param message the message string representation.
	 * @param face the face of the message.
	 * @param duration the duration of the message.
	 * @param useSeconds indicate if the duration is in seconds or in milliseconds.
	 */
	andromeda.process.Message = function( message /*String*/, face /*String*/, duration /*Number*/ , to /*Number*/, useSeconds /*Boolean*/  ) 
	{ 
		
		andromeda.process.Pause.call(this, (isNaN(duration) ? 1500 : duration) , useSeconds) ;
		
		this.message = message ;
		
		this.face = face ;
		
		this.to = (to == andromeda.process.Message.ALL) ? to : andromeda.process.Message.ME ;		
		
	}

	// Constants
	
	andromeda.process.Message.ALL /*Number*/ = 1 ;
	
	andromeda.process.Message.ME /*Number*/ = 0 ;

	// Inherit

	proto = andromeda.process.Message.extend( andromeda.process.Pause ) ;

	// Public Properties

	proto.message /*String*/ = null ;

	proto.face /*String*/ = null ;

	proto.to /*Number*/ = null ;

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	proto.clone = function () /*Message*/ 
	{
		return new andromeda.process.Message( this.message, this.face, this.duration, this.to, this.useSeconds ) ;
	}

	/**
	 * Returns a Eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	proto.toSource = function () /*String*/
	{
		var useSeconds /*Boolean*/ = (this.useSeconds == true)
		
		var source /*String*/ = "new andromeda.process.Message(" ;
		
		source += (this.message || "").toSource() + "," ;
		source += (this.face || "").toSource() + "," ;
		source += (this.duration || 0).toSource() + "," ;
		source += (this.to || "").toSource() + "," ; 
		source += (this.useSeconds || "").toSource() ; 
		
		source += ")" ;
		
		return source ;	
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance.
	 */
	proto.toString = function () /*String*/
	{
		var txt /*String*/ = "[Message" ;
		if ( this.message != null && (this.message instanceof String || typeof(this.message) == "string") ) 
		{
			txt +=  ":" + this.message ;
		}
		txt += "]" ;
		return txt ;
	}

	delete proto ;

}