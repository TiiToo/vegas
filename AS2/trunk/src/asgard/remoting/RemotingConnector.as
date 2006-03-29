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

/** Class RemotingConnector

	AUTHOR

		Name : RemotingConnector
		Package : asgard.remoting
		Version : 2.0.0.0
		Date : 2005-12-01
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- gatewayUrl:String
			
			Chemin de la passerelle.
		
		- methodName:String
		
			Nom de la méthode à éxécuter sur le serveur.
		
		- multipleSimultaneousAllowed:Boolean
			
			Lorsque cette valeur est vraie, le composant autorise la méthode trigger()
			à être appelée, même si des résultats n'ont pas encore été renvoyés
			à partir d'un appel précédent.
		
		- params:Array
			
			Un tableau contenant les propriétés que l'on veut envoyer vers la méthode
			que l'on souhaite éxécuter.
		
		
		- results:Object [Read Only]
			
			Renvoi le résultat de la dernière connexion.
		
		- running:Boolean [Read Only]
		
			Indique si la connexion est en cours ou pas
		
		- serviceName:String
		
			Nom du service.


	METHOD SUMMARY

		- query ( methodName:String, params:Object )
			lance automatiquement un service en fonction d'une méthode et de ses paramètres.
		
		- getService():Service
		
		- getResults():Object
		
			Renvoi le résultat de la dernière connexion.
		
		- notifyError(code:String):Void
		
		- onFault(oF:FaultEvent):Void
		
		- onResult(oR:ResultEvent):Void
		
		- run()
			
			lance la connexion si elle n'est pas déjà en cours
		
		- toString():String
		
			Renvoi la structure du RemotingConnector sous forme d'une chaine de caractère.

		- trigger()
			
			lance la connexion à un service Remoting.

	EVENT SUMMARY
	
		- RemotingEvent
	
			- RemotingEventType.CHANGED : "changed"
		
			- RemotingEventType.CLEARED : "cleared"
		
			- RemotingEventType.ERROR : "error"

			- RemotingEventType.FAULT : "fault"
			
			- RemotingEventType.FINISHED  : "finished"
			
			- RemotingEventType.PROGRESS : "progress"
			
			- RemotingEventType.RESULT : "result"
			
			- RemotingEventType.STARTED   : "started"

	
	INHERIT
	
		AbstractAction
		
	IMPLEMENTS
	
		Action, ICloneable, Responder, IRunnable


	TODOLIST (Pas encore implémenté)
			
		Enqueue connection with multipleSimultaneousAllowed
			
		userID
			Définit/Renvoie un ID de connexion à utiliser pour établir une connexion au serveur. 
		
		password
			Définit/Renvoie un mot de passe à utiliser pour établir une connexion au serveur. 
		
		shareConnections: Boolean
			Lorsque cette valeur est vraie, 
			plusieurs instances de ce composant peuvent partager une connexion
			à condition d'utiliser une URL de passerelle commune. 

	TODO : finir les tests du système événementiel.

---------- */ 

import mx.remoting.Service;
import mx.rpc.FaultEvent;
import mx.rpc.RelayResponder;
import mx.rpc.Responder;
import mx.rpc.ResultEvent;

import asgard.events.RemotingEvent;
import asgard.events.RemotingEventType;
import asgard.process.AbstractAction;
import asgard.remoting.RemotingFormat;

import vegas.events.Delegate;

class asgard.remoting.RemotingConnector extends AbstractAction implements Responder {

	// ----o Constructor
	
	public function RemotingConnector (str:String) {
		if (str) gatewayUrl = str ;
		_global.System.onStatus = Delegate.create (this, _onStatus) ;
	}

	// ----o Public Properties
	
	public var gatewayUrl:String ;
	public var methodName:String ;
	public var multipleSimultaneousAllowed:Boolean ;
	public var params:Array ; 
	public var serviceName:String ;
	
	// ----o Public Methods

	public function close() {
		_service.connection.close() ;
	}

	public function clone() {
		var rc:RemotingConnector = new RemotingConnector() ;
		rc.gatewayUrl = gatewayUrl ;
		rc.methodName = methodName ;
		rc.multipleSimultaneousAllowed = multipleSimultaneousAllowed ;
		rc.params = params ;
		rc.serviceName = serviceName ;
		return rc ;
	}

	public function getResults() { 
		return _results ;
	}


	public function getService():Service { 
		return _service ;
	}

	public function query( name:String, args:Array ):Void {
		if (running) return ;
		methodName = name ;
		params = args ;
 		run() ;
	}

	public function run():Void {
		if (running && multipleSimultaneousAllowed == false)  {
			notifyProgress() ;
		} else {
			notifyStarted() ;
			_setRunning(true) ;
			_service = new Service( gatewayUrl , null , serviceName, null, this) ;
			_service[methodName].apply(_service, params ) ; 		
		}
	}

	public function notifyError(code:String):Void {
		_setRunning(false) ;
		var ev:RemotingEvent = new RemotingEvent(RemotingEventType.ERROR, this)  ;
		ev.code = code || RemotingEventType.ERROR ;
		dispatchEvent( ev ) ;
		notifyFinished() ;
	}	

	public function onFault( fault:FaultEvent ):Void {
		_setRunning(false) ;
		notifyFinished() ;
		var ev:RemotingEvent = new RemotingEvent(RemotingEventType.FAULT, this)  ;
		ev.fault = fault.fault ;
		dispatchEvent( ev ) ;
		notifyFinished() ;
	}
	
	public function onResult( result:ResultEvent ):Void {
		_setRunning(false) ;
		_results = result.result ;
		var ev:RemotingEvent = new RemotingEvent(RemotingEventType.RESULT, this)  ;
		ev.result = _results ;
		dispatchEvent( ev ) ;
		notifyFinished() ;
	}

	public function toString():String {
		return (new RemotingFormat()).formatToString(this) ; 
	}

	public function trigger():Void { 
		run() ;
	}
	
	// ----o Virtual Properties
	
	public function get service():Service { 
		return getService() ;
	}
	
	public function get results() { 
		return getResults() ;
	}

	// ----o Private Properties

	private var _service:Service ;
	private var _relay:RelayResponder ;
	private var _callActive:Boolean ;
	private var _results ; // results
	
	// ----o Private Methods
	
	private function _onStatus ( ev:Object ):Void {
		if (ev.level == "error") notifyError(ev.code) ;
	}

}