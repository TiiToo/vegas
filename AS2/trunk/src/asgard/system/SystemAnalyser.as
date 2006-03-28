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

/* ---------- 	SystemAnalyser

	AUTHOR

		Name : SystemAnalyser
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2005-07-04
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION 
		
		Classe Singleton [DP], permet de récupérer toutes les informations du système de l'utilisateur.

	PROPERTIES
	
		properties : tableau [Array] contenant les propriétés que le SystemAnalyser peut analyser.
	
	METHODS
	
		- getSystemProperty(prop:String) : Permet de récupérer la valeur d'une propriété de la classe System.capabilities
		
		- run() lance une recherche de toutes les propriétés de la classe System.capabilities définies dans le manager

	EVENTS
	
		SystemEvent.VIEW_SYSTEM_EVENT 
		
			handler(ev:SystemEvent) 
			
				émis lors de l'analyse du System.capabilities.
				
			ev.context : un objet avec 2 propriétés 
				
				- id : chaine de caractère correspondant au nom de la propriété en cours d'analyse
				- value : valeur de la propriété provenant du System.capabilities en cours d'analyse	
				
			ev.target : cible de l'instance du SystemAnalyser
			
			ev.type : nom de l'événement "viewSystem"
	
	NB 
	
		il est possible d'ajouter des propriétés ou de changer l'ordre d'analyse de celles ci
		en réorganisant tout simplement le tableau public properties.

----------  */

import vegas.core.IRunnable ;
import vegas.core.IFormattable ;
import vegas.data.iterator.ArrayIterator ;
import vegas.events.EventDispatcher ;

import asgard.system.SystemAnalyserFormat;
import asgard.system.SystemEvent;

class asgard.system.SystemAnalyser extends EventDispatcher implements IRunnable, IFormattable {

	// ----o Constructor
	
	private function SystemAnalyser() {}
	
	// ----o Static
	
	static private var __INSTANCE__:SystemAnalyser ;
	
	static public function getInstance(Void):SystemAnalyser {
		if (__INSTANCE__ == undefined) __INSTANCE__ = new SystemAnalyser() ;
		return __INSTANCE__ ;
		
	}
	
	// ----o Public Properties
	
	public var properties:Array = [ 
		"language", 
		"os", 
		"manufacturer", 
		"playerType", 
		"version", 
		"localFileReadDisable", 
		"screenDPI", 
		"avHardwareDisable", 
		"hasAudio", 
		"hasAudioEncoder", 
		"hasMP3", 
		"hasStreamingAudio", 
		"hasStreamingVideo", 
		"hasVideoEncoder", 
		"hasEmbeddedVideo", 
		"hasScreenBroadcast", 
		"hasScreenPlayback" 
	] ;
		
	// ----o Public Methods
	
	public function getSystemProperty(prop:String) {
		return System.capabilities[prop] ;
	}

	public function run():Void { 
        var it:ArrayIterator = new ArrayIterator(properties) ; 
        while(it.hasNext()) { 
            var cur:String = it.next() ; 
			var ev:SystemEvent = new SystemEvent(this, cur, System.capabilities[cur]) ;
			dispatchEvent( ev, false) ; 
        } 
	}

	public function toString():String {
		return (new SystemAnalyserFormat()).formatToString(this) ;
	}

	
}