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
 * Factory of the pattern Decorator based on the prototype methods injection (Mixin).
 * @author eKameleon
 */
if (vegas.util.Mixin == undefined) 
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
	 * Creates a new Mixin instance.
	 * @param fConstructor the function constructor to used to create a mixin.
	 * @param target the target reference to injected new method with the mixin.
	 * @param attributes the array of all attributes to used in the mixin operation. 
	 */
	vegas.util.Mixin = function ( fConstructor/*Function*/, target, attributes/*Array*/ ) 
	{
		this.setAttributes(attributes) ;
		this.setConstructor(fConstructor);
		this.setTarget(target) ;
	}

	/**
	 * @extends vegas.core.IRunnable
	 */
	proto = vegas.util.Mixin.extend(vegas.core.IRunnable) ;

	/**
	 * Returns the array of all attributes.
	 * @return the array of all attributes.
	 */
	proto.getAttributes = function () /*Array*/ 
	{
		return this._ar ;
	}
	
	/**
	 * Returns the function constructor to used to create a mixin.
	 * @return the function constructor to used to create a mixin.
	 */
	proto.getConstructor = function () /*Function*/ 
	{
		return this._c ;
	}	
	
	/**
	 * Returns the target reference to injected new method with the mixin.
	 * @return the target reference to injected new method with the mixin.
	 */
	proto.getTarget = function () 
	{
		return this._target ;
	}
	
	/**
	 * Runs the process.
	 */
	proto.run = function () /*Void*/ 
	{
		if ( !this._ar || !this._c || !this._target ) 
		{
			return ;
		}
		var instance = new this._c() ;
		var l /*Number*/ = this._ar.length ;
		while(--l > -1) 
		{
			var prop /*String*/ = this._ar[l] ;
			this._target[prop] = instance[prop] ; 
		}
	}

	/**
	 * Sets the array of all attributes.
	 */
	proto.setAttributes = function ( ar /*Array*/ ) /*void*/ 
	{
		this._ar = ar ;
	}

	/**
	 * Sets the function constructor to used to create a mixin.
	 */
	proto.setConstructor = function ( f /*Function*/ ) /*void*/ 
	{
		this._c = f ;
	}

	/**
	 * Sets the target reference to injected new method with the mixin.
	 */
	proto.setTarget = function (o) /*void*/ 
	{
		this._target = o ;
	}

	proto._ar /*Array*/ = null ;
	proto._c /*Function*/ = null ;
	proto._target = null ;

	delete proto ;
		
}