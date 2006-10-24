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

/** MassiveLoader

	AUTHOR

		Name : MassiveLoader
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2006-03-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Abstract Class.

	METHOD SUMMARY

		- clear():Void
		
		- enqueue( loader:ILoader, sName:String, sURL:String ):String
		
		- getDelay():Number
		
		- getRunning():Boolean
		
		- isEmpty():Boolean
		
		- load():Void
		
		- onLoadComplete(e:LoaderEvent):Void
		
		- onLoadError(e:LoaderEvent):Void
		
		- onLoadInit(e:LoaderEvent):Void
		
		- onLoadProgress(e:LoaderEvent):Void
		
		- onLoadStart(e:LoaderEvent):Void
		
		- onLoadTimeOut(e:LoaderEvent):Void
		
		- run():Void
		
		- setDelay(n:Number):Void
		
		- size():Number
		
		- toArray():Array

	INHERIT
	
		CoreObject
			|
			AbstractCoreEventDispatcher
			 |
			 AbstractLoader
			 	|
			 	MassiveLoader
			 	
	IMPLEMENTS
	
		EventTarget, IFormattable, IHashable, IEventDispatcher, ILoader
	
*/	

import asgard.events.LoaderEvent;
import asgard.events.LoaderEventType;
import asgard.net.AbstractLoader;
import asgard.net.ILoader;
import asgard.net.LoaderListener;

import vegas.core.HashCode;
import vegas.data.iterator.Iterator;
import vegas.data.map.HashMap;
import vegas.data.queue.LinearQueue;
import vegas.errors.Warning;
import vegas.events.Delegate;
import vegas.events.TimerEventType;
import vegas.util.Timer;

/**
 * @author eKameleon
 * @version 1.0.0.0
 **/

// TODO : revoir le chargement successif ... problème

class asgard.net.MassiveLoader extends AbstractLoader implements LoaderListener 
{

	/**
	 * Create a new MassiveLoader.
	 */ 
	public function MassiveLoader() 
	{
		
		super() ;
		
		_timer = new Timer(120, 1) ;
		_timer.addEventListener(TimerEventType.TIMER, new Delegate(this, _next)) ;
			
		_timerComplete = new Timer(120, 1) ;
		_timerComplete.addEventListener(TimerEventType.TIMER, new Delegate(this, _onLoadComplete)) ;
		
		_mListeners = new HashMap() ;
		_mListeners.put(LoaderEventType.COMPLETE, new Delegate(this, onLoadComplete)) ;
		_mListeners.put(LoaderEventType.IO_ERROR, new Delegate(this, onLoadError)) ;
		_mListeners.put(LoaderEventType.INIT, new Delegate(this, onLoadInit)) ;
		_mListeners.put(LoaderEventType.PROGRESS, new Delegate(this, onLoadProgress)) ;
		_mListeners.put(LoaderEventType.START, new Delegate(this, onLoadStart)) ;
		_mListeners.put(LoaderEventType.TIMEOUT, new Delegate(this, onLoadTimeOut)) ;
		
		_qBuffer = new LinearQueue() ;
		
	}

	// ----o Public Methods

	public function clear():Void 
	{
		_qBuffer.clear() ;	
	}
	
	public function enqueue( loader:ILoader, sName:String, sURL:String ):String 
	{

		try {
			if (sName) loader.setName(sName) ;
			if (loader.getName() == undefined) {
				throw new Warning("You passed ILoader object without any name property in " + this + ".enqueue()." ) ;
			}
		}
		catch(e:Warning) 
		{
			e.toString() ;
		}
		catch(e:Error)
		{
			e.toString() ;	
		}

		try {
			if (sURL) loader.setUrl(sURL) ;
			if (loader.getUrl() == undefined) {
				throw new Warning("You passed ILoader object without any url property in " + this + ".enqueue().") ;
			}
		} catch(e:Warning) {
			e.toString() ;					
		}
		
		if (loader.getName() == undefined) {
			loader.setName( "loader_library" + HashCode.next() ) ;
		} 
		
		_qBuffer.enqueue(loader) ;
		
		return loader.getName() ;
		
	}

	public function getDelay():Number {
		return _timer.getDelay() ;	
	}

	public function getRunning():Boolean {
		return _isRunning ;	
	}

	public function isEmpty():Boolean {
		return _qBuffer.isEmpty() ;	
	}

	public function load():Void 
	{
		if ( !_isRunning && !isEmpty() ) 
		{
			var ar:Array = toArray() ;
			var len:Number = ar.length ;
			while (--len > -1) {
				var oLoader:ILoader = ar[len] ;
				if (oLoader.getUrl() == undefined) 
				{
					notifyError( this + ".run() encounters ILoader object without url property, load fails." ) ;
					return ;
				}
			}
			notifyEvent(LoaderEventType.START) ;
			_setRunning(true) ;
			_next() ;
		}
	}

	public function onLoadComplete(e:LoaderEvent):Void 
	{
		if (isEmpty()) 
		{
			_timerComplete.start() ;
		}
		else 
		{
			_timer.start() ;
		}
	}

	public function onLoadError(e:LoaderEvent):Void 
	{
		if (isEmpty()) 
		{
			_timerComplete.start() ;
		}
		else 
		{
			_timer.start() ;
		}
	}

	public function onLoadInit( e:LoaderEvent ):Void 
	{
		// internal method - override this method
	}

	public function onLoadProgress(e : LoaderEvent) : Void 
	{
		// internal method - override this method
	}

	public function onLoadStart(e : LoaderEvent) : Void 
	{
		// internal method - override this method
	}

	/**
	 * invoqué quand le chargement d'un ILoader n'a pas réussi dans le délais prévu.
	 */
	public function onLoadTimeOut(e : LoaderEvent) : Void 
	{
		if (isEmpty()) {
			_timerComplete.start() ;
		} else {
			_timer.start() ;
		}
	}
	
	/**
	 * Permet de lancer le chargement massif de tous les ILoader placé en queue dans le MassiveLoader.
	 */
	public function run():Void 
	{
		super.run() ;
	}

	/**
	 * Permet de définir le délais entre chaque chargement d'un nouveau ILoader 
	 */
	public function setDelay(n:Number):Void 
	{
		_timer.setDelay(n) ;
		_timerComplete.setDelay(n) ;
	}
	
	/**
	 * Renvoi le nombre de ILoader encore présent dans le buffer du MassiveLoader 
	 */
	 public function size():Number 
	 {
		return _qBuffer.size() ;	
	}
	
	/**
	 * Renvoi la liste des ILoader défini dans le MassiveLoader.
	 */
	public function toArray():Array 
	{
		return _qBuffer.toArray() ;	
	}

	// ----o Private Properties
	
	private var _qBuffer:LinearQueue ;
	private var _timer:Timer ;
	private var _timerComplete:Timer ;
	private var _mListeners:HashMap ;
	private var _oCurrentLoader:ILoader ;
	
	// ----o Private Methods

	private function _next():Void 
	{
		if (_oCurrentLoader != undefined) _unRegisterCurrentLoader() ;
		_oCurrentLoader = ILoader( _qBuffer.poll() );
		AbstractLoader(_oCurrentLoader).setParent( getEventDispatcher() ) ;
		_registerCurrentLoader() ;
		_oCurrentLoader.load();
	}

	private function _onLoadComplete():Void 
	{
		_unRegisterCurrentLoader() ;
		
		notifyEvent( LoaderEventType.COMPLETE );
		
	}

	private function _registerCurrentLoader():Void 
	{
		var it:Iterator = _mListeners.iterator() ;
		while(it.hasNext()) {
			var value:Delegate = it.next() ;
			var key:String = it.key() ;
			AbstractLoader(_oCurrentLoader).addEventListener(key, value) ;	
		}		
	}
	
	private function _unRegisterCurrentLoader():Void 
	{
		var it:Iterator = _mListeners.iterator() ;
		while(it.hasNext()) 
		{
			var value:Delegate = it.next() ;
			var key:String = it.key() ;
			AbstractLoader(_oCurrentLoader).removeEventListener(key, value) ;	
		}
	}
	
}