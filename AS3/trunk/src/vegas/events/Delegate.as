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

package vegas.events
{
	import flash.events.Event;
	
	import vegas.core.CoreObject;
	import vegas.core.ICloneable;
	import vegas.core.IRunnable;
	
	/**
	 * Delegate was originally created by Mike Chambers for Macromedia mx.events package.
	 * <p>This version is also inspired from <a href='http://www.peterjoel.com/blog/index.php?archive=2004_08_01_archive.xml#109320812208031938'>Peter Hall's EventDelegate</a> implementation and from the Francis bourre framework "<a href="http://osflash.org/pixlib">Pixlib</a>".</p>
	 * <p>You can instantiate and keep a reference of a Delegate instance.</p>
	 * <p>In the VEGAS implementation :
 	 * <li>The {@code Delegate} class implements {@code EventListener} interface. you can use a Delegate instances in the {@code addEventListener} method for all {@code EventTarget} implementations.</li>
	 * <li>The {@code Delegate} class implements {@code IRunnable} interface</li>
	 * </p>
 	 * @author eKameleon
	 */
	public class Delegate extends CoreObject implements EventListener, ICloneable, IRunnable
    {
        
		/**
		 * Creates a new Delegate instance.
		 * @param scope the scope to be used by calling this method.
		 * @param method the method to be executed.
		 * @param ...arguments the optional argument to pass in the method.
		 */
        public function Delegate(scope:*, method:Function, ...arguments:Array)
        {
		    _s = scope ;
    		_m = method ;
    		_a = arguments ;
    		_p = Delegate.create.apply(this, [_s].concat([_m], _a) ) ;
        }

		/**
		 * Adds arguments to proxy method.
		 */
 	   public function addArguments( ...arguments:Array ):void 
 	   {
    		if (arguments.length > 0) 
    		{
			    _a = _a.concat( arguments) ;
                _p = Delegate.create.apply(this, [_s].concat([_m], _a) ) ;
		    }
    	}
 
	 	/**
	 	 * Returns a shallow copy of the instance.
		 * @return a shallow copy of the instance.
		 */
     	public function clone():*
     	{
		    return new Delegate( getScope(), getMethod() ) ;
	    }
 
	 	/**
		 * Creates a method that delegates its arguments to a specified scope. This static method is a wrapper for MM compatibility.
		 * @param scope this scope to be used by calling this method.
		 * @param method the method to be called.
		 * @return a Function that delegates its call to a custom scope, method and arguments.
		 */
 	   static public function create(scope:*, method:Function, ...arguments:Array):Function 
 	   {
 	       
 	       var s:* = scope ;
 	       var m:Function = method ;
 	       var a:Array = arguments ;
 	       var f:Function = function():* {	
      			var args:Array = a.concat(arguments) ;
    			return m.apply(s, args) ;
    		} ;

    		return f;
	    }	
	
		/**
		 * Returns the array of all arguments called in the proxy method.
		 * @return the array of all arguments called in the proxy method.
		 */
	    public function getArguments():Array
	    {
		    return _a ;
    	}

		/**
		 * Returns the proxy method reference.
		 * @return the proxy method reference.
	 	 */
    	public function getMethod():Function 
    	{
		    return _m ;
    	}
	
		/**
		 * Returns the scope reference.
		 * @return the scope reference.
		 */
	    public function getScope():*
	    {
		    return _s ;
    	}

		/**
		 * Handles the event.
		 */
        public function handleEvent(e:Event):*
        {
            return _m.apply(_s, [e].concat(_a));
        }

		/**
		 * Run the proxy method in the provided context. 
		 */
	    public function run( ...arguments:Array ):void
	    {
		    addArguments(arguments) ;
    		_p() ;
	    }

		/**
		 * Sets or change arguments of proxy method.
	 	 */
	    public function setArguments( ...arguments:Array ):void
	    {
		    if (arguments.length > 0) 
		    {
			    _a = [].concat(arguments) ;
			    _p = Delegate.create.apply(this, [_s].concat([_m], _a) ) ;

    		}
    		
	    }

    	private var _m:Function ; // method

    	private var _s:* ; // scope

    	private var _a:Array ; // arguments

    	private var _p:Function; // proxy

    }
    
}