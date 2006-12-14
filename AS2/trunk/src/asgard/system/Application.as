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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** Application
 
	AUTHOR
 
		Name : Application
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2005-09-15
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
 
	STATIC METHOD SUMMARY
		
		- Application.isWeb : renvoie true si le fichier SWF est chargé 
			dans une page web avec le protocole HTTP ou HTTPS.
			
		- Application.isOnline : renvoie true si le fichier SWF est chargé 
			depuis internet avec n'importe quel protocole (HTTP, HTTPS ou FTP).
		
		- Application.isLocal : renvoie true si le fichier SWF est chargé
			depuis un fichier local (c-a-d utilisation du protocole FILE).
		
		- Application.isLocalWeb : renvoie true si le fichier est local et si on peut detecter
			la présence d'un moyen de communication entre le player flash et une aide a l'accessiblité.
   			Note : fonctionne avec IE sur windows, non testé autres navigateurs et autres systemes.
		
		- Application.isProjector : renvoie true, si le fichier est local mais
			n'est ni le flash IDE ni une page web locale.
		
		- Application.getIDEPath : renvoie le chemin du logiciel d'authoring Flash
			si le fichier SWF est détecté étant en mode IDE.

	SEE ALSO
	
		ApplicationType

	THANKS 
	
		Zwetan NG > Burrrn.com [FMX] flash dans plusieurs environnements.

**/

import asgard.system.ApplicationType;

class asgard.system.Application {

	// ----o Constructor
	
	private function Application() {
		//
	}

	// ----o Methods
	
	static public function getFullPath():String {
		return _level0._url ;
	}
	
	static public function getProtocol():String {
		return Application.getFullPath().split("://")[0] ;
	}
	
	static public function isFlashIDE():Boolean {
		return( _level0.$appPath != null );
	}
	
	static public function isWeb():Boolean {
		var protocol:String = Application.getProtocol();
		return( (protocol == ApplicationType.HTTP) || (protocol == ApplicationType.HTTPS) ) ;
	}

	static public function isOnline():Boolean {
		var protocol:String = Application.getProtocol() ;
		return ( (protocol == ApplicationType.FTP) || Application.isWeb() );
	}
	
	static public function isLocal():Boolean {
		var protocol:String = Application.getProtocol();
		return( protocol == ApplicationType.FILE );
	}
	
	static public function isLocalWeb():Boolean {
		var activeX = System.capabilities.hasAccessibility ;
		return( Application.isLocal() && (activeX == true) ) ;
	}

	static public function isProjector():Boolean {
		return( 
			Application.isLocal() &&
           !Application.isFlashIDE() &&
           !Application.isLocalWeb() 
		) ;
	}
	
	static public function getIDEPath():String {
		return (Application.isFlashIDE()) ? _level0.$appPath : "" ;
	}

}







