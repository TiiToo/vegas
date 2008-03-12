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
import asgard.events.LoaderEvent;
import asgard.events.LoaderEventType;
import asgard.events.LocalizationEvent;
import asgard.net.LoaderListener;
import asgard.system.EdenLocalizationLoader;
import asgard.system.ILocalizationLoader;
import asgard.system.Lang;
import asgard.system.Locale;

import vegas.data.map.HashMap;
import vegas.events.AbstractCoreEventDispatcher;
import vegas.events.Delegate;
import vegas.events.EventListener;

/**
 * The Localization class allows to manage via textual files with JSON or Eden format to charge the textual contents 
 * of an application according to the parameters of languages chosen by the users.
 * <p>It is possible to define several singletons of the Localization class to manage several elements in the application, but for this it's necessary to use the static property getInstance(sName). 
 * Thus all the authorities become of Singletons reusable a little everywhere in the application rather quickly.</p> 
 * @author eKameleon
 * @see Lang
 * @see Locale
 */
class asgard.system.Localization extends AbstractCoreEventDispatcher implements LoaderListener 
{
	
	/**
	 * Creates a new Localization instance.
	 * @param sName the name of the object.
	 */
	public function Localization(sName:String) 
	{

		super();
		
		_sName = sName ;
		
		_map = new HashMap() ;
		
		_eChange  = new LocalizationEvent ( Localization.CHANGE , this ) ;
		
		_complete = new Delegate(this, onLoadComplete) ;
		_error    = new Delegate(this, onLoadError) ;
		_init     = new Delegate(this, onLoadInit) ;
		_progress = new Delegate(this, onLoadProgress) ;
		_start    = new Delegate(this, onLoadStart) ;
		_timeOut  = new Delegate(this, onLoadTimeOut) ;
		
		setLoader( new EdenLocalizationLoader() ) ;
		
	}

	/**
	 * The name of the event when the localization is changed.
	 */
	public static var CHANGE:String = "change"  ;
	
	/**
	 * The name of the event invoked when the localization is completed.
	 */
	public static var COMPLETE:String = "onLoadComplete" ;
	
	/**
	 * The name of the event invoked when the localization is finished.
	 */
	public static var FINISH:String = "onLoadFinished" ;
	
	/**
	 * The name of the event invoked when the localization failed with an i/o error.
	 */
	public static var IO_ERROR:String = "onLoadError" ;
	
	/**
	 * The name of the event invoked when the localization is in progress.
	 */
	public static var PROGRESS:String = "onLoadProgress" ;
	
	/**
	 * The name of the event invoked when the localization is started.
	 */
	public static var START:String = "onLoadStarted" ;

	/**
	 * The name of the event invoked when the localization is out of time.
	 */
	public static var TIMEOUT:String = "onTimeOut" ;

	/**
	 * The default singleton name of the Localization singletons.
	 */
	public static var DEFAULT_NAME:String = "" ;
	
	/**
	 * (read-write) Returns the current {@code Lang} object selected in the current localization.
	 * @return the current {@code Lang} object.
	 */
	public function get current()
	{
		return getCurrent() ;
	}
	
	/**
	 * (read-write) Sets the current {@code Lang} object.
	 */
	public function set current( lang ):Void
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
	 * Removes all singletons in the internal map of this object..
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
	
	/**
	 * Returns the current {@code Locale} object defines with the specified {@code Lang} object in argument.
	 * @return the current {@code Locale} object defines with the specified {@code Lang} object in argument.
	 */
	public function get(lang:Lang):Locale 
	{
		return _map.get(lang) ;
	}
	
	/**
	 * Returns the current {@code Lang} reference of this instance.
	 * @return the current {@code Lang} reference of this instance.
	 */
	public function getCurrent():Lang 
	{
		return _current ;
	} 
	
	/**
	 * Returns a {@code Localization} singleton reference with the specified name passed-in argument.
	 * @return a {@code Localization} singleton reference with the specified name passed-in argument.
	 */
	public static function getInstance( sName:String ):Localization 
	{
		sName = sName || Localization.DEFAULT_NAME  ;
		if (!__mInstances.containsKey(sName)) 
		{
			__mInstances.put(sName, new Localization(sName)) ;
		}
		return Localization(__mInstances.get(sName)) ;
	}	
	
	/**
	 * Returns the name of the object.
	 * @return the name of the object.
	 */
	public function getName():String 
	{
		return _sName ;	
	}
	
	/**
	 * Apply the current localization over the specified object.
	 * @param o The object to fill with the current localization in the application.
	 * @param sID (optional) if this key is specified the method return the value of the specified key in the current locale object.
	 * @param callback (optional) The optional method to launch after the initialization over the specified object. 
	 */
	public function init( o:Object , sID:String , callback:Function ):Void
	{
		var init = getLocale( sID ) ;
		for (var prop:String in init)
		{
			o[prop] = init[prop] ;	
		}
		if ( callback != null )
		{
			callback.call(o) ;	
		}
	} 

	/**
	 * Releases the specified {@code Localization} singleton with the specified name in argument.
	 * @return the reference of the removed Localization object.
	 */
	public static function release(sName:String):Localization 
	{
		if (!sName) sName = Localization.DEFAULT_NAME ;
		return Localization.__mInstances.remove(sName) ;
	}

	/**
	 * Returns the ILocalizationLoader reference of this instance (default an EdenLocalizationLoader instance).
	 * @return the ILocalizationLoader reference of this instance.
	 */
	public function getLoader():ILocalizationLoader
	{
		return _loader ;
	}

	/**
	 * Returns the locale object with all this properties.
	 * @param sID (optional) if this key is specified the method return the value of the specified key in the current locale object.  
	 * @return the locale object with all this properties.
	 */
	public function getLocale( sID:String ) 
	{
		if (sID) 
		{
			return this.get(_current)[sID] || null ;
		}
		else 
		{
			return this.get(_current) || null ;
		}
	}

	/**
	 * Returns {@code true} if the Localization model is empty.
	 * @return {@code true} if the Localization model is empty.
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
	 * Invoked if the Localization loader notify an error.
	 * Overrides this method.
	 */
	public function onLoadError(e:LoaderEvent):Void 
	{
		// override
	}

	/**
	 * Invoked if the Localization loader notify is complete.
	 * Overrides this method.
	 */
	public function onLoadComplete(e:LoaderEvent):Void 
	{
		// override
	}

	/**
	 * Invoked if the Localization loader notify is init.
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

	/**
	 * Invoked when the localization loading is in progress. Overrides this method.
	 */
	public function onLoadProgress( e:LoaderEvent ):Void 
	{
		// override
	}

	/**
	 * Invoked when the localization loading is started. Overrides this method.
	 */
	public function onLoadStart( e:LoaderEvent ):Void 
	{
		// override
	}
	
	/**
	 * Invoked when the localization loading is out of time. Overrides this method.
	 */
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
	 * @param lang a valid Lang object. This argument is valid if the {@link Lang.validate} method return {@code true}.
	 */
	public function remove(lang:Lang):Void 
	{
		if ( Lang.validate(lang) ) 
		{
			_map.remove(lang) ;
		}
	}

	/**
	 * Sets the current localization with the specified Lang.
	 */
	public function setCurrent( lang ):Void 
	{
		if (Lang.validate(lang)) 
		{
			_current = Lang.get(lang) ;
			if ( contains( _current ) ) 
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
	 * Sets the current loader of this Localization (default an EdenLocalizationLoader instance).
	 */
	public function setLoader( loader:ILocalizationLoader ):Void
	{
	
		var l:AbstractCoreEventDispatcher = AbstractCoreEventDispatcher(_loader) ;
		
		if (l != null)
		{
			l.setParent( null ) ; // use bubbling
			l.removeEventListener(LoaderEventType.COMPLETE, _complete) ;
			l.removeEventListener(LoaderEventType.INIT, _init) ;
			l.removeEventListener(LoaderEventType.PROGRESS, _progress) ;
			l.removeEventListener(LoaderEventType.START, _start) ;
			l.removeEventListener(LoaderEventType.IO_ERROR, _error) ;
			l.removeEventListener(LoaderEventType.TIMEOUT, _timeOut) ;
		}
		
		if (loader == null)
		{
			loader = new EdenLocalizationLoader() ;
		}
		
		_loader = loader ;
		
		l = AbstractCoreEventDispatcher(_loader) ;
		
		if (l != null)
		{
			l.setParent( getEventDispatcher() ) ; // use bubbling
			l.addEventListener(LoaderEventType.COMPLETE, _complete) ;
			l.addEventListener(LoaderEventType.INIT, _init) ;
			l.addEventListener(LoaderEventType.PROGRESS, _progress) ;
			l.addEventListener(LoaderEventType.START, _start) ;
			l.addEventListener(LoaderEventType.IO_ERROR, _error) ;
			l.addEventListener(LoaderEventType.TIMEOUT, _timeOut) ;
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
	
	/**
	 * @private
	 */
	private var _map:HashMap = null ;

	/**
	 * @private
	 */
	private var _complete:EventListener ;
	
	/**
	 * @private
	 */
	private var _current:Lang = null ;

	/**
	 * @private
	 */
	private var _eChange:LocalizationEvent = null ;

	/**
	 * @private
	 */
	private var _error:EventListener ;

	/**
	 * @private
	 */
	private var _init:EventListener ;

	/**
	 * @private
	 */
	private var _loader:ILocalizationLoader = null ;

	/**
	 * @private
	 */
	private static var __mInstances:HashMap = new HashMap () ;

	/**
	 * @private
	 */
	private var _progress:EventListener ;

	/**
	 * @private
	 */
	private var _sName:String = null ;

	/**
	 * @private
	 */
	private var _start:EventListener ;

	/**
	 * @private
	 */
	private var _timeOut:EventListener ;


}