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

/** ResolverProxy

	AUTHOR

		Name : ResolverProxy 
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2005-05-21
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
		Allow to link an object with another objet using __resolve
		instead of ASBroadcaster, EventBroadcaster, EventDispatcher, etc...
   
		ATTN: this a 1 to 1 relationship
		EventBroadcaster -> 1 to *    + unidirectional
		ResolverProxy    -> 1 to 1    + unidirectional or bidirectional
   
	NOTE: this can be used to connect a "Model" object
		  to a "View" object as an alternative to
		  "Model-View-Controller" or "visual proxy".
        
     EXAMPLES
     
         ex1:
         myModel = new Model();
         _root.createView( "myView" );
         myView.proxy = myModel;
         myModel.proxy = myView;
         
         ex2:
         myModel = new Model();
         _root.createView( "myView" );
         myView.link( myModel );
         
         the View and the Model share their methods
         and properties as they were only one object.

	INHERIT
	
		CoreObject → ResolverProxy

	IMPLEMENTS

		IFormattable, IHashable

	SEE ALSO
	
		Mixin
    
	TODO A tester !

	THANKS 
	
		Zwetan >> http://www.zwetan.com/	
		
**/

import vegas.core.CoreObject;
import vegas.util.factory.PropertyFactory;
import vegas.util.Mixin;

class vegas.util.ResolverProxy extends CoreObject {
	
	// ----o Constructor
	
	public function ResolverProxy ( p_proxy ) {
		_proxy = p_proxy ;
    }
	
	// ----o Statics
	
	static public function initialize( target )  {
		var attributes:Array = [ "linkProxy", "getProxy", "_proxy", "proxy", "__resolve", "setProxy" ] ;
		var mix:Mixin = new Mixin(ResolverProxy, target, attributes) ;
		mix.run() ;
    }
	
	// ----o Public Properties
	
	public var proxy ; // [R/W]
	
	// ----o Public Methods
		
	public function linkProxy( linkedProxy ) {
		linkedProxy.proxy = this ;
		_proxy = linkedProxy ;
    }


	public function getProxy() {
		return _proxy ;
    }
	
	public function setProxy( o ) {
		_proxy = o;
	}

	public function __resolve( name:String ) {
		if ( _proxy == null ) return ;
		if( !_proxy.hasOwnProperty( name ) ) {
			if( _proxy.__proto__[name] == undefined ) return ;
        }
		if( typeof(_proxy[name]) == "function" ) {
			var p = _proxy ; 
			return function() {
				return p[name].apply( p, arguments );
			};
		} else {
			return _proxy[name];
		}
    }

	// ----o Virtual Properties
	
	static private var __PROXY__:Boolean = PropertyFactory.create(ResolverProxy, "proxy", true) ;
	
	// ----o Private Properties
	
	private var _proxy ;
	
}

