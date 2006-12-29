/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import pegas.events.ActionEvent;
import pegas.process.Action;

import vegas.core.ICloneable;
import vegas.core.ISerializable;
import vegas.events.AbstractCoreEventDispatcher;

/**
 * @author eKameleon
 */
class pegas.process.AbstractAction extends AbstractCoreEventDispatcher implements Action, ICloneable, ISerializable 
{

	/**
	 * Creates a new AbstractAction instance.
	 */	
	private function AbstractAction() 
	{
		
		_eChange = new ActionEvent(ActionEvent.CHANGE, this) ;
		_eClear = new ActionEvent(ActionEvent.CLEAR, this) ;
		_eFinish = new ActionEvent(ActionEvent.FINISH, this) ;
		_eInfo = new ActionEvent(ActionEvent.INFO, this) ;
		_eLoop = new ActionEvent(ActionEvent.LOOP, this) ;
		_eProgress = new ActionEvent(ActionEvent.PROGRESS, this) ;
		_eResume = new ActionEvent(ActionEvent.RESUME, this) ;
		_eStart = new ActionEvent(ActionEvent.START, this) ;
		_eStop = new ActionEvent(ActionEvent.STOP, this) ;
		
	}
	
	public var looping:Boolean ;

	public function get running():Boolean 
	{
		return getRunning() ;	
	}
	
	public function clone() 
	{
		//
	}

	public function getRunning():Boolean 
	{
		return _isRunning ;	
	}

	public function notifyChanged():Void 
	{
		dispatchEvent(_eChange) ;
	}

	public function notifyCleared():Void 
	{
		dispatchEvent(_eClear) ;
	}	

	public function notifyFinished():Void 
	{
		dispatchEvent(_eFinish) ;
	}
	
	public function notifyInfo( oInfo ):Void 
	{
		dispatchEvent(_eInfo) ;
	}
	
	public function notifyLooped():Void 
	{
		dispatchEvent(_eLoop) ;
	}

	public function notifyProgress():Void 
	{
		dispatchEvent(_eProgress) ;
	}
	
	public function notifyResumed():Void 
	{
		dispatchEvent(_eResume) ;
	}
	
	public function notifyStarted():Void 
	{
		dispatchEvent(_eStart) ;
	}
	
	public function notifyStopped():Void 
	{
		dispatchEvent(_eStop) ;
	}

	public function notifyTimeOut():Void
	{
		dispatchEvent( new ActionEvent(ActionEvent.TIMEOUT ) ) ;
	}

	public function run():Void 
	{
		// 
	}

	public function toSource(indent:Number, indentor:String):String 
	{
		return null ;
	}

	private var _eChange:ActionEvent ;
	private var _eClear:ActionEvent ;
	private var _eFinish:ActionEvent ;
	private var _eInfo:ActionEvent ;
	private var _eLoop:ActionEvent ;
	private var _eProgress:ActionEvent ;
	private var _eResume:ActionEvent ;
	private var _eStart:ActionEvent ;
	private var _eStop:ActionEvent ;
	
	private var _isRunning:Boolean ;

	/*protected*/ private function _setRunning(b:Boolean):Void 
	{
		_isRunning = b ;	
	}

}
