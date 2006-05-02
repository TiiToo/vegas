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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** Class RemotingAuthentification

	AUTHOR

		Name : RemotingAuthentification
		Package : asgard.remoting
		Version : 2.0.0.0
		Date : 2006-05-02
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new RemotingAuthentification(id:String, pass:String) ;

	PROPERTY SUMMARY
	
		- userID:String
		
			Définit/Renvoie un ID de connexion à utiliser pour établir une connexion au serveur. 
		
		- password:String

			Définit/Renvoie un mot de passe à utiliser pour établir une connexion au serveur. 

	METHOD SUMMARY
	
		- hashCode():String
		
		- toString():String

	INHERIT
	
		CoreObject > RemotingAuthentification
		
	IMPLEMENTS
	
		IHashable, IFormattable

---------- */ 

import vegas.core.CoreObject;

/**
 * @author eKameleon
 * @date 2006-05-02
 */
class asgard.remoting.RemotingAuthentification extends CoreObject {
	
	// ----o Constructor
	
	public function RemotingAuthentification(id:String, pass:String) {
		super();
		userID = id ;
		password = pass ;
	}

	// ----o Public Properties
	
	public var userID:String ;
	public var password:String ;
	
}