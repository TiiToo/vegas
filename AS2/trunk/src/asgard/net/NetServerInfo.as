 /*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */
import andromeda.vo.NetServerInfoVO;

import vegas.util.serialize.Serializer;

/**
 * Defines the information object in a onStatus callback method.
 * @author eKameleon
 */	
class asgard.net.NetServerInfo extends NetServerInfoVO 
{
	
	/**
	 * Creates a new NetServerInfo object.
	 * @param oInfo a primitive object with the properties 'code', 'level', 'description' and 'application'.
	 */
	public function NetServerInfo( oInfo ) 
	{
		super( oInfo ) ;
	}

	/**
	 * Returns the Eden String representation of the object.
	 * @return the Eden String representation of the object.
	 */	
	public function toSource(indent : Number, indentor : String):String 
	{
		return Serializer.getSourceOf(this, [Serializer.toSource(toObject())] ) ; 
	}


}