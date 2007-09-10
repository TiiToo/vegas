﻿/*

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

package pegas.process
{
    import vegas.events.Delegate;
    
    /**
     * This {@code IAction} object run a proxy method.
     * @author eKameleon
     * @see vegas.events.Delegate
     */
	public class ActionProxy extends SimpleAction
	{
	
	    /**
    	 * Creates a new ActionProxy instance.
    	 * @param scope The scope of the proxy method invoqued in this process.
    	 * @param method The method invoqued in this process.
    	 * @param args The Arguments injected in the method.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
    	 */
    	function ActionProxy( scope:*, method:Function , args:Array=null , bGlobal:Boolean = false , sChannel:String = null ) ;
    	{
		    super();
		    this.args   = args ;
		    this.method = method ;
		    this.scope  = scope ;
	    }
		
		/**
		 * The array representation of the proxy method invoqued in this process.
		 */
		public var args:Array ;
		
		/**
		 * The proxy method invoqued in this process.
		 */
		public var method:Function ;
		
		/**
		 * The scope reference of the proxy method of this process.
		 */
		public var scope:Object ;

	    /**
	     * Returns a shallow copy of this object.
	     * @return a shallow copy of this object.
	     */
		public override function clone():*
		{
			return new ActionProxy( scope, method, args ) ;
		}

    	/**
	     * Run the process.
	     */
		public override function run( ...arguments:Array ):void 
		{
			notifyStarted() ;
			setRunning(true) ;
			Delegate.create.apply(this, [scope, method].concat(args)) ();
			setRunning(false) ;
			notifyFinished() ;
		}

	}

}