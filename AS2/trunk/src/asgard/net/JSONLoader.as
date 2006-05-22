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

/** JSONLoader

	AUTHOR

		Name : JSONLoader
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2006-03-23
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- bytesLoaded:Number [Read Only]
		
		- bytesTotal:Number [Read Only]
		
		- data [R/W]
		
		- dataFormat [R/W]
		
		- fieldName:String // TODO voir si cette méthode doit rester en place ou pas ?
		
		- name:String [R/W]
		
		- running:Boolean [Read Only]
		
		- timeOut:Number [R/W]
		
		- percent:Number [Read Only]

	METHOD SUMMARY
	
		- addEventListener(eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void
		
		- addGlobalEventListener(listener:EventListener, priority:Number, autoRemove:Boolean):Void
		
		- addRequestHeader( header, headerValue:String ):Void
		
		- checkData():Void
		
		- deserializeData():Void
		
		- dispatchEvent( event , [isQueue, [target, [context]]]):Event
		
		- getBytesLoaded():Number
		
		- getBytesTotal():Number
		
		- getContent()
		
		- getContentType():String
		
		- getData()
		
		- getDataFormat():String
		
		- getEventDispatcher():EventDispatcher 

 		- getEventListeners(eventName:String):EventListenerCollection
		
		- getGlobalEventListeners():EventListenerCollection
		
		- getName():String
		
		- getParent():EventDispatcher
		
		- getRegisteredEventNames():Set
	
		- getPercent():Number
		
		- getRunning():Boolean
		
		- getTimeOut():Number
		
		- getUrl()
	
 		- hasEventListener(eventName:String):Boolean	
		
		- hashCode():Number
		
		- initEvent():Void
		
		- initEventDispatcher():EventDispatcher 
 		
 		- isLoaded():Boolean
		
		- load():Void
		
		- notifyError(sError:String, nCode:Number):Void
		
		- notifyEvent(eventType:String):Void
		
		- onLoadInit():Void
		
		- release():Void

		- removeEventListener(eventName:String, listener, useCapture:Boolean ):EventListener
		
		- removeGlobalEventListener(o):EventListener
		
		- run():Void
		
		- setContent(o:LoadVars):Void

		- setContentType(sType:String):Void

		- setData(o):Void
		
		- setDataFormat(f:String):Void
		
		- setName(sName:String):Void
		
		- setParent(parent:EventDispatcher):Void	
		
		- setTimeOut(n:Number):Void
		
		- setUrl(sURL:string):Void
		
		- toString():String

	INHERIT
	
		CoreObject → AbstractCoreEventDispatcher → AbstractLoader → URLLoader → JSONLoader
			 	
	IMPLEMENTS
	
		EventTarget, IFormattable, IHashable, IEventDispatcher, ILoader
	
**/	

import asgard.net.DataFormat;
import asgard.net.URLLoader;

import vegas.string.JSON;

// TODO tester fieldName et DataFormat.VARIABLES

/**
 * @author eKameleon
 */
class asgard.net.JSONLoader extends URLLoader {
	
	// ----o Constructor
	
	function JSONLoader() {
		super() ;
	}

	// ----o Public Properties
	
	public var fieldName:String ;

	// ----o Public Methods

	public function deserializeData():Void {
		
		var source:String ;
		
		switch (getDataFormat()) {

				case DataFormat.VARIABLES :

					source = this.getData()[fieldName] ;
					
					break ;

				case DataFormat.BINARY :
				case DataFormat.TEXT :

					source = this.getData() ;
					
					break ;

		}
		setData( JSON.deserialize( source )  ) ;
		
	}

}