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
 
/**
 * Delegate was originally created by Mike Chambers for Macromedia mx.events package.
 * <p>This version is also inspired from <a href='http://www.peterjoel.com/blog/index.php?archive=2004_08_01_archive.xml#109320812208031938'>Peter Hall's EventDelegate</a> implementation and from the Francis bourre framework "<a href="http://osflash.org/pixlib">Pixlib</a>".</p>
 * <p>You can instantiate and keep a reference of a Delegate instance.</p>
 * <p>In the VEGAS implementation :
 * <li>The {@code Delegate} class implements {@code EventListener} interface. you can use a Delegate instances in the {@code addEventListener} method for all {@code EventTarget} implementations.</li>
 * <li>The {@code Delegate} class implements {@code IRunnable} interface</li>
 * </p>
 * <p><b>Example 1</b></p>
 * {@code
 * var o = {} ;
 * o.toString = function () 
 * {
 *     return "[myObject]" ;
 * }
 * 
 * var action = function () 
 * {
 *     trace(this + " - action") ;
 *     var l = arguments.length ;
 *     for (var i = 0 ; i<l ; i++) 
 *     {
 *         trace("   > " + arguments[i]) ;
 *     }
 * }
 * 
 * var fProxy = vegas.events.Delegate.create(o, action, "arg3") ;
 * fProxy("arg1", "arg2") ;
 * }
 * <p><b>Example 2</b></p>
 * {@code
 * var fProxy = new Delegate(o, action, "arg3") ;
 * fProxy.run("arg1", "arg2") ; // TODO voir l'ordre des arguments
 * }
 * @author eKameleon
 */
if (vegas.events.Delegate == undefined) {
	
	/**
	 * @requires vegas.events.EventListener
	 */
	require("vegas.events.EventListener") ;
	
	/**
	 * Creates a new Delegate instance.
	 * @param scope the scope to be used by calling this method.
	 * @param method the method to be executed.
	 */
	vegas.events.Delegate = function(scope, method /*, [arg1, arg2, ..., argN]*/ ) 
	{
		this._s = scope ;
		this._m = method ;
		this._a = [].concat( (Array.fromArguments(arguments)).splice(2) ) ;
		this._p = vegas.events.Delegate.create.apply(this, [this._s, this._m].concat(this._a) ) ;
	}
	
	/**
	 * @extends vegas.events.EventListener
	 */ 
	vegas.events.Delegate.extend(vegas.events.EventListener) ;
 
	/**
	 * Add arguments to proxy method.
	 */
 	vegas.events.Delegate.prototype.addArguments = function (/*[arg1, arg2, ..., argN]*/) 
 	{
		var args = Array.fromArguments(arguments) ;
		if (args.length > 0) 
		{
			this._a = this._a.concat(args) ;
			this._p = vegas.events.Delegate.create.apply(this, [this._s, this._m].concat(this._a) ) ;
		}
	}

	/**
	 * Returns a shallow copy of the instance.
	 * @return a shallow copy of the instance.
	 */
	vegas.events.Delegate.prototype.clone = function () 
	{
		return new vegas.events.Delegate(this.getScope(), this.getMethod()) ;
	}
 
 	/**
	 * Creates a method that delegates its arguments to a specified scope. This static method is a wrapper for MM compatibility.
	 * @param scope this scope to be used by calling this method.
	 * @param method the method to be called.
	 * @return a Function that delegates its call to a custom scope, method and arguments.
	 */
	/*static*/ vegas.events.Delegate.create = function (scope /*Object*/ , method /*Function*/ ) /*Function*/ 
	{
		var args /*Array*/ = Array.fromArguments(arguments) ;
		args = args.splice(2) ;
		return function() 
		{
			var ar /*Array*/ = Array.fromArguments(arguments).concat(args) ;
			method.apply(scope, ar) ;
		}
	}

	/**
	 * Returns the array of all arguments called in the proxy method.
	 * @return the array of all arguments called in the proxy method.
	 */
	vegas.events.Delegate.prototype.getArguments = function () /*Array*/ 
	{
		return this._a ;
	}

	/**
	 * Returns the proxy method reference.
	 * @return the proxy method reference.
	 */
	vegas.events.Delegate.prototype.getMethod = function () /*Function*/ 
	{
		return this._m ;
	}

	/**
	 * Returns the scope reference.
	 * @return the scope reference.
	 */
	vegas.events.Delegate.prototype.getScope = function () /*Object*/ 
	{
		return this._s ;
	}
	
	/**
	 * Handles the event.
	 */
	vegas.events.Delegate.prototype.handleEvent = function ( e /*Event*/ ) 
	{
		return this._m.apply( this._s, [e].concat(this._a) ) ;
	}

	/**
	 * Run the proxy method in the provided context. 
	 */
	vegas.events.Delegate.prototype.run = function() 
	{
		this.addArguments.apply(this, Array.fromArguments(arguments)) ;
		this._p() ;
	}

	/**
	 * Sets or change arguments of proxy method.
	 */
	vegas.events.Delegate.prototype.setArguments = function () 
	{
		var args = Array.fromArguments(arguments) ;
		if (args.length > 0) 
		{
			this._a = [].concat(args) ;
			this._p = vegas.events.Delegate.create.apply(this, [this._s, this._m].concat(this._a) ) ;
		}
	}

}
