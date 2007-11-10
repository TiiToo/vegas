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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */

import pegas.process.AbstractAction;

import vegas.events.Delegate;

/**
 * This {@code Action} object run a proxy method.
 * <p><b>Example :</b></p>
 * {@code
 * import pegas.process.ActionProxy ;
 * import vegas.core.CoreObject     ;
 * import vegas.events.Delegate     ;
 * import vegas.events.Event        ;
 * 
 * var debug:Function = function( e:Event ):Void
 * {
 *     trace( this + " debug : " + e ) ;
 * }
 * 
 * var method:Function = function( message:String ):Void
 * {
 *      trace( this + " message: " + message ) ;
 * }
 * 
 * var scope:CoreObject    = new CoreObject() ;
 * var process:ActionProxy = new ActionProxy( scope, method ) ;
 * 
 * process.addGlobalEventListener( new Delegate( this, debug ) ) ;
 * 
 * process.run() ;
 * }
 */
class pegas.process.ActionProxy extends AbstractAction 
{

	/**
	 * Creates a new ActionProxy instance.
	 * @param scope The scope of the proxy.
	 * @param method The method of the proxy.
	 * @param ...arguments All the optionals arguments to pass in the proxy method when is invoked.
	 */
	public function ActionProxy( scope:Object, method:Function ) 
	{
		obj  = scope ;
		func = method ;
		args = arguments.splice(2) ;
	}

	/**
	 * The Array representation of all arguments passed-in the proxy method.
	 */
	public var args:Array ;
	
	/**
	 * The method reference of this proxy process.
	 */
	public var func:Function ;
	
	/**
	 * The scope reference of this proxy process.
	 */
	public var obj:Object ;
	
	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	public /*override*/ function clone() 
	{
		var p:ActionProxy = new ActionProxy(obj, func);
		p.args = args ;
		return p ;
	}
	
	/**
	 * Run the process.
	 */
	public /*override*/ function run():Void 
	{
		notifyStarted() ;
		_setRunning(true) ;
		Delegate.create.apply(this, [obj, func].concat(args)) ();
		_setRunning(false) ;
		notifyFinished() ;
	}

}

