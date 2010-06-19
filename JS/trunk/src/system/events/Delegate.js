/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/
 
/**
 * Delegate an event in a proxy eventlistener.
 * <p>This version is also inspired from <a href='http://www.peterjoel.com/blog/index.php?archive=2004_08_01_archive.xml#109320812208031938'>Peter Hall's EventDelegate</a> implementation and from the Francis bourre framework "<a href="http://osflash.org/pixlib">Pixlib</a>".</p>
 * <p>You can instantiate and keep a reference of a Delegate instance.</p>
 * <p>Note :
 * <li>The {@code Delegate} class implements {@code EventListener} interface. you can use a Delegate instances in the {@code addEventListener} method for all {@code EventTarget} implementations.</li>
 * <li>The {@code Delegate} class implements {@code Runnable} interface</li>
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
 *     trace( this + " action : " + Array.fromArguments( arguments ) ) ;
 * }
 * 
 * var proxy = system.events.Delegate.create(o, action, "arg3") ;
 * proxy("arg1", "arg2") ; // [myObject] action : arg1,arg2,arg3
 * }
 * <p><b>Example 2</b></p>
 * {@code
 * var proxy = new system.events.Delegate(o, action, "arg3") ;
 * proxy.run("arg1", "arg2") ; // [myObject] action : arg3,arg1,arg2
 * }
 */
if ( system.events.Delegate == undefined ) 
{
    /**
     * @requires system.events.EventListener
     */
    require("system.events.EventListener") ;
    
    /**
     * Creates a new Delegate instance.
     * @param scope the scope to be used by calling this method.
     * @param method the method to be executed.
     */
    system.events.Delegate = function(scope, method /*, [arg1, arg2, ..., argN]*/ ) 
    {
        this._s = scope ;
        this._m = method ;
        this._a = [].concat( (Array.fromArguments(arguments)).splice(2) ) ;
        this._p = system.events.Delegate.create.apply(this, [this._s, this._m].concat(this._a) ) ;
    }
    
    /////////////
    
    /**
     * Creates a method that delegates its arguments to a specified scope. This static method is a wrapper for MM compatibility.
     * @param scope this scope to be used by calling this method.
     * @param method the method to be called.
     * @return a Function that delegates its call to a custom scope, method and arguments.
     */
    system.events.Delegate.create = function (scope /*Object*/ , method /*Function*/ ) /*Function*/ 
    {
        var args /*Array*/ = Array.fromArguments(arguments) ;
        args = args.splice(2) ;
        return function() 
        {
            var ar /*Array*/ = Array.fromArguments(arguments).concat(args) ;
            method.apply(scope, ar) ;
        }
    }
    
    /////////////
    
    /**
     * @extends system.events.EventListener
     */ 
    proto = system.events.Delegate.extend( system.events.EventListener ) ;
    
    /**
     * Add arguments to proxy method.
     */
    proto.addArguments = function (/*[arg1, arg2, ..., argN]*/) 
    {
        var args = Array.fromArguments(arguments) ;
        if (args.length > 0) 
        {
            this._a = this._a.concat(args) ;
            this._p = system.events.Delegate.create.apply(this, [this._s, this._m].concat(this._a) ) ;
        }
    }
    
    /**
     * Returns a shallow copy of the instance.
     * @return a shallow copy of the instance.
     */
    proto.clone = function () 
    {
        return new system.events.Delegate(this.getScope(), this.getMethod()) ;
    }
    
    /**
     * Returns the array of all arguments called in the proxy method.
     * @return the array of all arguments called in the proxy method.
     */
    proto.getArguments = function () /*Array*/ 
    {
        return this._a ;
    }
    
    /**
     * Returns the proxy method reference.
     * @return the proxy method reference.
     */
    proto.getMethod = function () /*Function*/ 
    {
        return this._m ;
    }
    
    /**
     * Returns the scope reference.
     * @return the scope reference.
     */
    proto.getScope = function () /*Object*/ 
    {
        return this._s ;
    }
    
    /**
     * Handles the event.
     */
    proto.handleEvent = function ( e /*Event*/ ) 
    {
        return this._m.apply( this._s, [e].concat(this._a) ) ;
    }
    
    /**
     * Run the proxy method in the provided context. 
     */
    proto.run = function() 
    {
        this.addArguments.apply(this, Array.fromArguments(arguments)) ;
        this._p() ;
    }
    
    /**
     * Sets or change arguments of proxy method.
     */
    proto.setArguments = function () 
    {
        var args = Array.fromArguments(arguments) ;
        if (args.length > 0) 
        {
            this._a = [].concat(args) ;
            this._p = system.events.Delegate.create.apply(this, [this._s, this._m].concat(this._a) ) ;
        }
    }
    
    ///////
    
    delete proto ;
}
