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

import asgard.display.DisplayLoaderCollector;
import asgard.events.DisplayLoaderEvent;
import asgard.events.LoaderEventType;
import asgard.net.AbstractLoader;
import asgard.net.URLRequest;

import vegas.core.HashCode;
import vegas.errors.IllegalArgumentError;

/**
 * @author eKameleon
 */
class asgard.display.DisplayLoader extends AbstractLoader 
{
	
	// ----o Constructor
	
	function DisplayLoader( mcTarget:MovieClip, nDepth:Number, bAutoShow:Boolean  ) 
	{
		
		super() ;
		
		if (! mcTarget) 
		{
			throw new IllegalArgumentError(this + " mcTarget argument is undefined.") ;
		}
		
		nDepth = (isNaN(nDepth)) ? 1 : nDepth ;
		
		HashCode.identify( mcTarget ) ;
		
		_container = mcTarget.createEmptyMovieClip("__container__" + HashCode.nextName() , nDepth ) ;
		
		HashCode.identify( _container ) ;
		
		_isAutoShow = (bAutoShow == null) ? true : bAutoShow ;
		_isCollected = false ;
		
	}
	
	// ----o Public Methods

	static public function getLoaderUrl():String 
	{
		return _root._url ;
	}

	public function getView():MovieClip 
	{
		return MovieClip(super.getContent()) ;
	}
	
	public function hide():Void 
	{
		_container._visible = false ;
	}

	/*override*/ public function initEvent():Void 
	{
		_e = new DisplayLoaderEvent(null, this) ;
	}

	public function isAutoShow():Boolean 
	{
		return _isAutoShow ;	
	}
	
	public function isVisible():Boolean 
	{
		return _container._visible ;	
	}

	/*override*/ public function load(request:URLRequest):Void 
	{
		if (request.getUrl() != undefined) 
		{
			setUrl( request.getUrl() );
		}
		release() ;
		setContent( _container.createEmptyMovieClip("__mcExternal", 1) ) ;
		notifyEvent(LoaderEventType.START) ;
		getContent().loadMovie( super.getUrl() );
		hide();
		super.load() ;
	}

	/*override*/ public function onLoadInit():Void 
	{
		if (_sName) 
		{
			
			if (!(DisplayLoaderCollector.contains(_sName))) 
			{
				
				_isCollected = true ;
				DisplayLoaderCollector.insert( _sName, this ) ;
				
			} 
			else 
			{
				_isCollected = false ;
				// TODO créer une erreur.
				notifyError( this + " can't be collected to [DisplayCollector] with '" + _sName + "' name. This name already exists." ) ;
			}
		}
		
		super.onLoadInit();
		
		if (_isAutoShow) show() ;
		
	}
	
	/*override*/ public function release():Void 
	{
		super.release() ;
		getContent().removeMovieClip() ;
		_container._visible = _isAutoShow ;
		if (_isCollected) 
		{
			DisplayLoaderCollector.remove(_sName) ;
			_isCollected = false ;	
		}	
	}
	
	public function setAutoShow(b:Boolean):Void 
	{
		_isAutoShow = b ;
	}

	public function show():Void {
		_container._visible = true ;
	}

	// ----o Private Properties
	
	private var _container:MovieClip ;
	private var _isAutoShow:Boolean ;
	private var _isCollected:Boolean ;

}