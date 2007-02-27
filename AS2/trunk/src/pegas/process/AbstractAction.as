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
import vegas.events.AbstractCoreEventDispatcher;

/**
 * This class simplify the implementation of the Action interface.
 * @author eKameleon
 */
class pegas.process.AbstractAction extends AbstractCoreEventDispatcher implements Action, ICloneable
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
	
	/**
	 * The flag to determinate if the Action object is looped.
	 */
	public var looping:Boolean ;

	/**
	 * (read-only) Returns {@code true} if the process is in progress.
	 * @return {@code true} if the process is in progress.
	 */
	public function get running():Boolean 
	{
		return getRunning() ;	
	}
	
	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	public function clone() 
	{
		//
	}

	/**
	 * Returns {@code true} if the process is in progress.
	 * @return {@code true} if the process is in progress.
	 */
	public function getRunning():Boolean 
	{
		return _isRunning ;	
	}

	/**
	 * Notify an ActionEvent when the process is changed.
	 */
	public function notifyChanged():Void 
	{
		dispatchEvent(_eChange) ;
	}

	/**
	 * Notify an ActionEvent when the process is cleared.
	 */
	public function notifyCleared():Void 
	{
		dispatchEvent(_eClear) ;
	}	

	/**
	 * Notify an ActionEvent when the process is finished.
	 */
	public function notifyFinished():Void 
	{
		dispatchEvent(_eFinish) ;
	}

	/**
	 * Notify an ActionEvent when an info is dispatched.
	 */
	public function notifyInfo( oInfo ):Void 
	{
		dispatchEvent(_eInfo) ;
	}
	
	/**
	 * Notify an ActionEvent when the process is looped.
	 */
	public function notifyLooped():Void 
	{
		dispatchEvent(_eLoop) ;
	}

	/**
	 * Notify an ActionEvent when the process is in progress.
	 */
	public function notifyProgress():Void 
	{
		dispatchEvent(_eProgress) ;
	}
	
	/**
	 * Notify an ActionEvent when the process is resumed.
	 */
	public function notifyResumed():Void 
	{
		dispatchEvent(_eResume) ;
	}

	/**
	 * Notify an ActionEvent when the process is started.
	 */
	public function notifyStarted():Void 
	{
		dispatchEvent(_eStart) ;
	}

	/**
	 * Notify an ActionEvent when the process is stopped.
	 */
	public function notifyStopped():Void 
	{
		dispatchEvent(_eStop) ;
	}

	/**
	 * Notify an ActionEvent when the process is out of time.
	 */
	public function notifyTimeOut():Void
	{
		dispatchEvent( new ActionEvent(ActionEvent.TIMEOUT ) ) ;
	}

	/**
	 * Run the process.
	 */
	public function run():Void 
	{
		// 
	}

	/**
	 * Returns a Eden representation of the object.
	 * @param indent:Number optional the starting of the indenting
	 * @param identor:String the string value used to do the indentation
	 * @return a string representing the source code of the object.
	 */
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

	/**
	 * This protected method is an internal method to change the _isRunning value.
	 */
	/*protected*/ private function _setRunning(b:Boolean):Void 
	{
		_isRunning = b ;	
	}

}
