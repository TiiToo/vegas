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
 * This factory class creates virtual properties.
 * <p>You must defined your virtual properties in public if you use this class in AS2 class.</p>
 * @author eKameleon
 */
if (vegas.util.factory.PropertyFactory == undefined) 
{

	/**
	 * Creates the PropertyFactory singleton.
	 */	
	vegas.util.factory.PropertyFactory = {} ;


	/**
	 * Creates a new Read Write or Read Only virtual property.
	 * @see Object.__defineGetter__ method.
	 * @see Object.__defineSetter__ method. 
	 */
	vegas.util.factory.PropertyFactory.create = function (o, propName/*String*/, isReadOnly/*Boolean*/)/*Boolean*/ 
	{
		var suffix /*String*/ = propName.ucFirst() ;
		o.__defineGetter__(propName, o["get"+suffix]) ;
		if (!isReadOnly)
		{
			o.__defineSetter__(propName, o["set"+suffix]) ;
		}
		return o.hasOwnProperty(propName) ;
	}
	
}