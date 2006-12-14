﻿/*

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

/**

	TODO DESCRIPTION (à traduire)
	
		La classe Localization permet de gérer via des fichiers textes au format JSON ou Eden de charger le contenu textuel d'une 
		application en fonction des paramètres de langues choisis par l'utilisateurs.
		
		Il est possible de définir plusieurs instances de la classe Localization pour gérer plusieurs éléments dans l'application, 
		mais pour cela il faut utiliser la propriété statique getInstance(sName). Ainsi toutes les instances deviennent des Singletons
		réutilisables un peu partout dans l'application assez rapidement.
		
		Cette classe fonctionne sur un modèle reposant sur une HashMap contenant des instances de la classe Locale indexées par des identifiants de type Lang.
		Si un objet de type Locale est défini pour une Lang donné, le localizer ne cherche pas à rechargé le fichier externe de configuration.
		
		A noter que la classe Localization utilise en interne une instance de la classe LocalizationLoader qui permet de définir plus facilement certains
		paramètres définissant précisément l'url des fichiers à charger.
		
		Chaque fichier chargé donc contenir dans son nom principal un suffix de type _LANG qui permet de le différencier en fonction de la langue choisie.


*/	

import asgard.events.LoaderEvent;
import asgard.events.LoaderEventType;
import asgard.events.LocalizationEvent;
import asgard.events.UIEventType;
import asgard.net.LoaderListener;
import asgard.system.ILocalizationLoader;
import asgard.system.Lang;
import asgard.system.Locale;
import asgard.system.LocalizationLoader;

import vegas.data.map.HashMap;
import vegas.events.AbstractCoreEventDispatcher;
import vegas.events.Delegate;
import vegas.events.EventListener;

/**
 * The singleton Localization tool.
 * @author eKameleon
 */
class asgard.system.Localization extends AbstractCoreEventDispatcher implements LoaderListener 
{
	
	/**
	 * Creates the Localizationb Singleton.
	 */
	private function Localization(sName:String) 
	{

		super();
		
		_sName = sName ;
		
		_map = new HashMap() ;
		
		_eChange = new LocalizationEvent ( Localization.CHANGE ) ;
		
		_complete = new Delegate(this, onLoadComplete) ;
		_error = new Delegate(this, onLoadError) ;
		_init = new Delegate(this, onLoadInit) ;
		_progress = new Delegate(this, onLoadProgress) ;
		_start = new Delegate(this, onLoadStart) ;
		_timeOut = new Delegate(this, onLoadTimeOut) ;
		
		setLoader( new LocalizationLoader() ) ;
		
	}

	static public var CHANGE:String = UIEventType.CHANGE  ;
	
	static public var COMPLETE:String = "onLoadComplete" ;
	
	static public var FINISH:String = "onLoadFinished" ;
	
	static public var IO_ERROR:String = "onLoadError" ;
	
	static public var PROGRESS:String = "onLoadProgress" ;
	
	static public var START:String = "onLoadStarted" ;
	
	static public var TIMEOUT:String = "onTimeOut" ;

	static public var DEFAULT_NAME:String = "" ;
	
	/**
	 * (read-write) Returns the current localization.
	 */
	public function get current():Lang 
	{
		return getCurrent() ;
	}
	
	/**
	 * (read-write) Sets the current localization.
	 */
	public function set current(lang:Lang):Void
	{
		setCurrent(lang) ;
	}	
	
	/**
	 * (read-only) Returns the name of the current localization.
	 */
	public function get name():String 
	{
		return getName() ;	
	}
	
	/**
	 * Clear the internal map.
	 */
	public function clear():Void 
	{
		_map.clear() ;
	}

	/**
	 * Returns {@code true} if this Localization contains the specified Lang.
	 * @return {@code true} if this Localization contains the specified Lang.
	 */
	public function contains(lang:Lang):Boolean 
	{	
		return _map.containsKey(lang) ;
	}
	
	public function get(lang:Lang):Locale 
	{
		return _map.get(lang) ;
	}
	
	public function getCurrent():Lang 
	{
		return _current ;
	} 
	
	static public function getInstance( sName:String ):Localization 
	{
		sName = sName || Localization.DEFAULT_NAME  ;
		if (!__mInstances.containsKey(sName)) 
		{
			__mInstances.put(sName, new Localization(sName)) ;
		}
		return Localization(__mInstances.get(sName)) ;
	}	

	public function getName():String 
	{
		return _sName ;	
	}

	static public function release(sName:String):Localization 
	{
		if (!sName) sName = Localization.DEFAULT_NAME ;
		return Localization.__mInstances.remove(sName) ;
	}

	public function getLoader():ILocalizationLoader
	{
		return _loader ;
	}

	public function getLocale( sID:String ) 
	{
		if (sID) {
			return this.get(_current)[sID] || null ;
		} else {
			return this.get(_current) || null ;
		}
	}

	/**
	 * Returns {@code true} if the Localization model is empty.
	 */
	public function isEmpty():Boolean 
	{
		return _map.isEmpty() ;
	}

	/**
	 * Notify when the Localization change.
	 */
	public function notifyChange():Void 
	{
		dispatchEvent( _eChange ) ;
	}
	
	/**
	 * Invoqued if the Localization loader notify an error.
	 * Overrides this method.
	 */
	public function onLoadError(e:LoaderEvent):Void 
	{
		// override
	}

	/**
	 * Invoqued if the Localization loader notify is complete.
	 * Overrides this method.
	 */
	public function onLoadComplete(e:LoaderEvent):Void 
	{
		// override
	}

	/**
	 * Invoqued if the Localization loader notify is init.
	 */
	public function onLoadInit( e:LoaderEvent ) : Void 
	{
		var oLocale:Locale = new Locale() ;
		var jsonData = e.getData() ;
		for (var each:String in jsonData) 
		{
			oLocale[each] = jsonData[each] ;	
		}
		put (_current, oLocale ) ;
		notifyChange() ;
	}

	public function onLoadProgress( e:LoaderEvent ):Void 
	{
		// override
	}

	public function onLoadStart( e:LoaderEvent ):Void 
	{
		// override
	}

	public function onLoadTimeOut( e:LoaderEvent ):Void 
	{
		// override
	}

	/**
	 * Put the specified Lang in the Localization model.
	 */
	public function put(lang:Lang, oL:Locale) 
	{
		return _map.put(lang, oL) ;
	}

	/**
	 * Remove the specified Lang in the Localization model.
	 */
	public function remove(lang:Lang):Void 
	{
		if (Lang.validate(lang)) 
		{
			_map.remove(lang) ;
		}
	}

	/**
	 * Sets the current localization with the specified Lang.
	 */
	public function setCurrent(lang:Lang):Void 
	{
		if (Lang.validate(lang)) 
		{
			_current = lang ;
			if ( contains(lang) ) 
			{
				notifyChange() ;
			}
			else 
			{
				ILocalizationLoader(_loader).load(_current) ;
			}
		}
	}
	
	/**
	 * Sets the current loader of this Localization.
	 */
	public function setLoader( loader:ILocalizationLoader ):Void
	{
		
		if (_loader != null)
		{
			AbstractCoreEventDispatcher(_loader).setParent( null ) ; // use bubbling
		
			AbstractCoreEventDispatcher(_loader).removeEventListener(LoaderEventType.COMPLETE, _complete) ;
			AbstractCoreEventDispatcher(_loader).removeEventListener(LoaderEventType.INIT, _init) ;
			AbstractCoreEventDispatcher(_loader).removeEventListener(LoaderEventType.PROGRESS, _progress) ;
			AbstractCoreEventDispatcher(_loader).removeEventListener(LoaderEventType.START, _start) ;
			AbstractCoreEventDispatcher(_loader).removeEventListener(LoaderEventType.IO_ERROR, _error) ;
			AbstractCoreEventDispatcher(_loader).removeEventListener(LoaderEventType.TIMEOUT, _timeOut) ;
			
		}
		
		_loader = loader ;
		
		if (_loader != null)
		{
		
			AbstractCoreEventDispatcher(_loader).setParent( getEventDispatcher() ) ; // use bubbling
			
			AbstractCoreEventDispatcher(_loader).addEventListener(LoaderEventType.COMPLETE, _complete) ;
			AbstractCoreEventDispatcher(_loader).addEventListener(LoaderEventType.INIT, _init) ;
			AbstractCoreEventDispatcher(_loader).addEventListener(LoaderEventType.PROGRESS, _progress) ;
			AbstractCoreEventDispatcher(_loader).addEventListener(LoaderEventType.START, _start) ;
			AbstractCoreEventDispatcher(_loader).addEventListener(LoaderEventType.IO_ERROR, _error) ;
			AbstractCoreEventDispatcher(_loader).addEventListener(LoaderEventType.TIMEOUT, _timeOut) ;
		}
	}

	/**
	 * Returns the string representation of this object.
	 * @return the string representation of this object.
	 */
	public function toString():String 
	{
		var txt:String = "[Localization" ; 
		 if (_sName.length > 0) txt += "." + _sName ;
		 txt += "]" ;
		 return txt ;	
	}

	private var _map:HashMap = null ;
	
	private var _complete:EventListener ;

	private var _current:Lang = null ;

	private var _eChange:LocalizationEvent = null ;

	private var _error:EventListener ;

	private var _init:EventListener ;

	private var _loader:ILocalizationLoader = null ;

	static private var __mInstances:HashMap = new HashMap () ;

	private var _progress:EventListener ;

	private var _sName:String = null ;
	
	private var _start:EventListener ;

	private var _timeOut:EventListener ;


}