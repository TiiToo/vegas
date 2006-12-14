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

import vegas.data.collections.SimpleCollection;
import vegas.data.iterator.Iterator;
import vegas.util.Mixin;

/**
 * Allow to link an object with multiple objets using {@code __resolve} method.
 * @author eKameleon
 */
class vegas.util.ResolverMultiProxy 
{
	
	/**
	 * Creates a new ResolverMultiProxy instance.
	 */
	function ResolverMultiProxy ( p_proxy ) 
	{
		_proxys = new SimpleCollection() ;
    }

	/**
	 * Adds a new proxy reference in the proxy model.
	 */
	public function addProxy( proxy ):Boolean 
	{
		if (_proxys.contains(proxy)) 
		{
			return false ;
		}
		return _proxys.insert(proxy) ;
	}

	/**
	 * Initialize a proxy on a specific target.
	 */
	static public function initialize( target )  
	{
		var attributes:Array =[ "_proxys", "addProxy", "removeProxy", "__resolve" ];
		var mix:Mixin = new Mixin(ResolverMultiProxy, target, attributes) ;
		mix.run() ;
    }

	/**
	 * Removes a proxy reference in the proxy model.
	 */
	public function removeProxy( proxy ):Boolean 
	{
		return _proxys.remove( proxy ) ;
	}
	
	/**
	 * Resolve the specified property name.
	 */
	public function __resolve( str:String ) 
	{
		if ( _proxys.isEmpty() ) 
		{
			return ;
		}
		var it:Iterator = _proxys.iterator() ;
		while (it.hasNext()) 
		{
			var proxy = it.next() ;
			if( !proxy.hasOwnProperty( str ) ) 
			{
				if( proxy.__proto__[str] == undefined ) 
				{
					break ;
				}
			}
			else if( typeof(proxy[str]) == "function" ) 
			{
				return function() 
				{
					return proxy[str].apply( proxy, arguments );
				};
			} 
			else 
			{
				return proxy[str];
			}
		}
    }
	
	private var _proxys:SimpleCollection ;
	
}

