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

import asgard.events.SharedDataEvent;
import asgard.events.SharedDataEventType;
import asgard.net.NetServerConnection;
import asgard.net.SharedDataStatus;

import vegas.events.AbstractCoreEventDispatcher;
import vegas.events.Delegate;

/**
 * The {@code SharedData} class is used to read and store limited amounts of data on a user's computer or on a server.
 * @author eKameleon
 * @version 1.0.0.0
 */
class asgard.net.SharedData extends AbstractCoreEventDispatcher
{
	
	/**
	 * Creates a new SharedData instance.
	 * @param sName the name of the SharedData reference.
	 * @param nc The NetServerConnection reference of this SharedData object.
	 * @param persistant indicates if the internal SharedObject of this SharedData is persistant.
	 * @param autoConnect Indicates if the SharedData is auto connect.
	 */
	function SharedData( sName:String, nc:NetServerConnection, persistant:Boolean, autoConnect:Boolean) 
	{
		
		_isConnected = false ;
		_isFirst = true ;
	
		initEvent() ;
		
		initialize(sName, nc, persistant, autoConnect) ;
		
	}

	/**
	 * [read-only] The collection of attributes assigned to the data property of the object; 
	 * these attributes can be shared and stored.
	 */
	public function get data() 
	{
		return getData() ; 
	}
	
	/**
	 * [read-only] Indicates if the SharedData is connected.
	 */
	public function get isConnected():Boolean 
	{
		return getIsConnected() ;	
	}
	
	/**
	 * For local shared objects, purges all of the data and deletes the shared object from the disk.
	 */
	public function clear():Void 
	{
		_so.clear() ;
	}
	
	/**
	 * Closes the connection between a remote shared object and the server.
	 */
 	public function close():Void 
 	{
		if (_isConnected) 
		{
			_so.close() ;
			_isConnected = false ;
			dispatchEvent(_eClose) ;
		}
	}

	/**
	 * Connects to a remote shared object on the server through the specified connection.
	 * @param nc A NetServerConnection object (such as one used to communicate with Flash Media Server) that is using the Real-Time Messaging Protocol (RTMP). 
	 */
	public function connect( nc:NetServerConnection ):Boolean 
	{
		close() ;
		_isConnected = _so.connect(nc) ;
		return _isConnected ;
	}
	
	/**
	 * Dispatches a context object to all the reference of this SharedData in all remote application.
	 */
	public function fireEvent( eContext ):Void 
	{
  		_so.send(SharedDataEventType.FIRE, eContext );
  	}
	
	/**
	 * Immediately writes a locally persistent shared object to a local file.
	 */
	public function flush():Void 
	{
		_so.flush() ;
	}	

	/**
	 * Returns the collection of attributes assigned to the data property of the object; 
	 * these attributes can be shared and stored.
	 */
	public function getData() 
	{
		return _so.data ;	
	}

	/**
	 * Returns {@code true} if the SharedData is connected.
	 * @return {@code true} if the SharedData is connected.
	 */
	public function getIsConnected():Boolean 
	{
		return _isConnected ;	
	}
	
	/**
	 * Returns the value of the specified property.
	 * @return  the value of the specified property.
	 */
	public function getProperty(sName:String) 
	{
  		return _so.data[sName];
  	}
  	
  	/**
  	 * Initialize all internal events of this SharedData instance.
  	 */
  	public function initEvent():Void
  	{
  		_eChange  = new SharedDataEvent( SharedDataEventType.CHANGE       , this ) ;
		_eClear   = new SharedDataEvent( SharedDataEventType.CLEAR        , this ) ;
		_eClose   = new SharedDataEvent( SharedDataEventType.CLOSE        , this ) ;
		_eFire    = new SharedDataEvent( SharedDataEventType.FIRE         , this ) ;
		_eDelete  = new SharedDataEvent( SharedDataEventType.DELETE       , this ) ;
		_eReject  = new SharedDataEvent( SharedDataEventType.REJECT       , this ) ;
		_eSuccess = new SharedDataEvent( SharedDataEventType.SUCCESS      , this ) ;
		_eSync    = new SharedDataEvent( SharedDataEventType.SYNCHRONISED , this ) ;
  	}
  		
	/**
	 * Initialize the SharedData instance.
	 * @param sName the name of the SharedData reference.
	 * @param nc The NetServerConnection reference of this SharedData object.
	 * @param persistant indicates if the internal SharedObject of this SharedData is persistant.
	 * @param autoConnect Indicates if the SharedData is auto connect.
	 */
	public function initialize(sName:String, nc:NetServerConnection, persistant:Boolean, autoConnect:Boolean):Void 
	{
		if (_so ) 
		{
			_so.close() ;
		}
		_so = SharedObject.getRemote(sName, nc.uri, persistant) ;
		_so.onSync = Delegate.create(this, _onSync) ;
		_so[SharedDataEventType.FIRE] = Delegate.create(this, _onFired) ;	
		if (autoConnect) 
		{
			connect(nc) ;
		}
	}

	/**
	 * Locks the object.
	 */
	public function lock():Void 
	{
		super.lock() ;
		_so.setFps(0);
	}
	
	/**
	 * Resets all the properties of the SharedData.
	 */
	public function reset():Void 
	{
		var o:Object = getData() ;
		for (var each:String in o) 
		{
			delete o[each] ;
		}
	}	
	
	/**
	 * Specifies the number of times per second that a client's changes to a shared object are sent to the server.
	 */
	public function setFps(n:Number):Boolean 
	{
  		return _so.setFps(n);
  	}
  	
  	/**
  	 * Updates the value of a property (defined with the data property) in a shared object and indicates to the server that the value of the property has changed.
  	 */
  	public function setProperty(sName:String, value ):Void 
  	{
  		_so.data[sName] = value ;
		_so.flush() ;
  	}
	
	/**
	 * Returns the current size of the shared object, in bytes.
	 * @return the current size of the shared object, in bytes.
	 */
	public function size():Number 
	{
		return _so.getSize() ;	
	}

	/**
	 * Unlock Method like server side SSAS
	 */
 	public function unLock():Void 
 	{
 		super.unLock() ;
		_so.setFps(0) ;
		_so.setFps(-1) ;
	}

	private var _eChange:SharedDataEvent ;
	private var _eClear:SharedDataEvent;
	private var _eClose:SharedDataEvent ;	
	private var _eDelete:SharedDataEvent ;	
	private var _eFire:SharedDataEvent ;
	private var _eReject:SharedDataEvent ;		
	private var _eSuccess:SharedDataEvent ;		
	private var _eSync:SharedDataEvent ;		

	private var _isConnected:Boolean ;
	private var _isFirst:Boolean ;
	
	private var _so:SharedObject ;
		
	private function _onSync( list ):Void 
	{
		
		if (_isFirst) 
		{
			_isFirst = false ;
			dispatchEvent(_eSync) ;
			for (var name:String in _so.data ) 
			{
				_eChange.setProperty(name, _so.data[name]) ;
				dispatchEvent( _eChange ) ;
			}
			return ;
		}
		
		for (var prop:String in list) 
		{
			
			var item:Object = list[prop] ;
			var code:SharedDataStatus = SharedDataStatus.format( item.code )  ;
			var name:String = item.name ;
			var value = _so.data[name] ;

			//**** DEBUG
			// var txt:String = "> " + this + "._onSync :: " + code ;
			// if(name) txt += " , name:" + name ;
			// if(value) txt += " , value:" + value ;
			// trace (txt) ;
			//***/
			
			switch (code) 
			{
				case SharedDataStatus.CLEAR :
				{
					dispatchEvent(_eClear);
					break ;
				}
				case SharedDataStatus.CHANGE :
				{
					_eChange.setProperty(name, value) ;
					dispatchEvent(_eChange);
					break ;
				}	
				case SharedDataStatus.DELETE :
				{
					_eDelete.setProperty(name) ;
					dispatchEvent(_eDelete );
					break ;
				}
				case SharedDataStatus.REJECT :
				{
					_eReject.setProperty(name, value) ;
					dispatchEvent(_eReject );
					break ;
				}
				case SharedDataStatus.SUCCESS :
				{
					_eSuccess.setProperty(name, value) ;
					dispatchEvent(_eSuccess );
					break ;
				}
			}
   		}
	}

	private function _onFired( eventContext ):Void 
	{
		_eFire.setContext ( eventContext ) ;
   		dispatchEvent( _eFire ) ;
	}
	
}