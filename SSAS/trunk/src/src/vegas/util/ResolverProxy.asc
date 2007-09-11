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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Allow to link an object with another objet using {@code __resolve} method.
 * Thanks Zwetan >> http://www.zwetan.com/
 * <p>This is a 1 to 1 relationship.
 * <li>EventBroadcaster -> 1 to *    + unidirectional</li>
 * <li>ResolverProxy    -> 1 to 1    + unidirectional or bidirectional</li>
 * </p>
 * <p><b>Note :</b>This can be used to connect a "Model" object to a "View" object as an alternative to  "Model-View-Controller" or "visual proxy".</p>
 * <p><b>Example 1 :</b>
 * {@code
 * var myModel = new Model();
 * createView( "myView" ) ;
 * myView.proxy = myModel ;
 * myModel.proxy = myView;
 * }
 * </p>
 * <p><b>Example 2 :</b>
 * {@code
 * myModel = new Model();
 * createView( "myView" );
 * myView.link( myModel );
 * }
 * </p>
 * <p>The View and the Model share their methods and properties as they were only one object.</p>
 * @author eKameleon
 * @see Mixin
 */
if (vegas.util.ResolverProxy == undefined) 
{

	/**
	 * @requires vegas.core.CoreObject
	 */
	require("vegas.core.CoreObject") ;

	/**
	 * @requires vegas.util.factory.PropertyFactory
	 */
	require("vegas.util.factory.PropertyFactory") ;

	/**
	 * @requires vegas.util.Mixin
	 */
	require("vegas.util.Mixin") ;

	/**
	 * Creates a new ResolverProxy instance.
	 */
	vegas.util.ResolverProxy = function ( proxy ) 
	{
		this.setProxy( proxy ) ;
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.util.ResolverProxy.extend( vegas.core.CoreObject ) ;

	/**
	 * Returns the proxy reference of this ResolverProxy.
	 */
	proto.getProxy = function () 
	{
		return this._proxy ;
	}

	/**
	 * Initialize the mixin of the ResolverProxy methods in the specified target object.
	 */
	vegas.util.ResolverProxy.initialize = function ( target ) 
	{
		var attributes  = 
		[ 
			"linkProxy"
			, "getProxy"
			, "setProxy" 
			, "__resolve"
			, "_proxy"
		] ;
		var mix = new vegas.util.Mixin( vegas.util.ResolverProxy, target, attributes) ;
		mix.run() ;
	}

	/**
	 * Creates a link proxy between 2 proxy object.
	 */		
	proto.linkProxy = function ( linkedProxy ) 
	{
		linkedProxy.setProxy(this) ;
		this.setProxy(linkedProxy) ;
	}	

	/**
	 * Sets the proxy reference of this ResolverProxy.
	 */
	proto.setProxy = function ( proxy ) 
	{
		this._proxy = proxy || null ;
	}

	/**
	 * Internal proxy reference.
	 * @private
	 */	
	proto._proxy = null ;

	/**
	 * Resolve the specified property name.
	 * @private
	 */
	proto.__resolve = function ( name ) 
	{
		
		if ( this._proxy == null ) return ;
		
		if( ! this._proxy.hasOwnProperty( name ) ) 
		{
			if( this._proxy.__proto__[name] == undefined ) 
			{
				return ;
			}
        }
		
		if( typeof( this._proxy[name] ) == "function" ) 
		{
			var p = this._proxy ; 
			return function( ) 
			{
				return p[name].apply( p, Array.fromArguments(arguments) );
			} ;
		} 
		else 
		{
			return this._proxy[name];
		}
	}
		
	delete proto ;
	
}