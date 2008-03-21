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
 * The {@code ConstructorUtil} utility class is an all-static class with methods for working with function constructor in AS2.
 * @author eKameleon
 */
if (vegas.util.ConstructorUtil == undefined) 
{
	
	vegas.util.ConstructorUtil = {}

	/**
	 * Creates an returns a basic instance of the constructor function passed in argument.
	 * @param c the function constructor.
	 * @return a new instance of the specified constructor function.
	 */
	vegas.util.ConstructorUtil.createBasicInstance = function(c /*Function*/ ) 
	{
		return new c() ;
	}
	
	/**
	 * Creates an instance of the constructor function passed in argument.
	 * This method launch the constructor of the class with all arguments in the {@code args} array.
	 * @param c the function constructor.
	 * @param args the array of all arguments to pass in the constructor of the new instance.
	 * @return a new instance of the specified constructor function.
	 */	
	vegas.util.ConstructorUtil.createInstance = function(c/*Function*/ , args/*Array*/ ) 
	{
		if (c == null) return null ;
		var i = vegas.util.ConstructorUtil.createBasicInstance(c) ;
		c.apply(i, args) ;
		return i ;
	}
	
	/**
	 * Transforms and returns the reference of the visual object passed in argument. 
	 * The visual object are {@code MovieClip} and {@code TextField} class instances.
	 * @param c the function constructor to apply on the visual object.
	 * @param oVisual the {@code MovieClip} or {@code TextField} reference
	 * @param oInit an object to initialize the specified visual reference.
	 * @return the new reference transformed with the specified constructor. 
	 */
    vegas.util.ConstructorUtil.createVisualInstance = function(c /*Function*/, oVisual, oInit) 
    {
    	oVisual.__proto__ = c.prototype ;
		if (oInit) 
		{
			for (var each /*String*/ in oInit) 
			{
				oVisual[each] = oInit[each] ;
			}
		}	
		c.apply(oVisual) ;   
		return oVisual ;
    }	

	/**
	 * Returns the name string representation of the specified instance passed in arguments.
	 * @param instance the reference of the object to apply reflexion.
	 */
	vegas.util.ConstructorUtil.getName = function ( instance ) /*String*/ 
	{
		return instance.getConstructorName() || null ;
	}

	/**
	 * Returns the package string representation of the specified instance passed in arguments.
	 * @param instance the reference of the object to apply reflexion.
	 */
	vegas.util.ConstructorUtil.getNamespace = function ( instance ) /*String*/ 
	{
		var path /*String*/ = vegas.util.ConstructorUtil.getPath(instance) ;
		if (path == null) return null ;
		var p /*Array*/ = path.split(".") ;
		var l = p.length ;
		p.pop() ;
		return (l>1) ? p.join(".") : (p[0] || null) ;
	}


	/**
	 * Returns the full path string representation of the specified instance passed in arguments (package + name).
	 * @param instance the reference of the object to apply reflexion.
	 */
	vegas.util.ConstructorUtil.getPath = function ( instance ) /*String*/ 
	{
		return instance.getConstructorPath() || null ;
	}

	/**
	 * Returns {@code true} if the constructor function is an implementation of the specified interface.
	 * @param c the function constructor reference.
	 * @param i the interface reference.
	 * @return {@code true} if the constructor function is an implementation of the specified interface.
	 */
	vegas.util.ConstructorUtil.isImplementationOf = function (c /*Function*/, i/*Function*/) /*Boolean*/ 
	{
		if (vegas.util.ConstructorUtil.isSubConstructorOf(c, i)) 
		{
			return true ;
		}
		return vegas.util.ConstructorUtil.createBasicInstance(c) instanceof i ;
	}

	/**
	 * Returns {@code true} if the constructor function is the sub constructor of the specified function constructor.
	 * @param c the function constructor reference.
	 * @param sc the specified sub constructor reference.
	 * @return {@code true} if the constructor function is the sub constructor of the specified function constructor.
	 */
	vegas.util.ConstructorUtil.isSubConstructorOf = function ( c/*Function*/, sc/*Function*/) /*Boolean*/ 
	{
		if (c instanceof Function ) 
		{
			var p = c.prototype ;
			while(p) 
			{
				p = p.__proto__;
				if(p === sc.prototype) return true ;
			}
			return false;
		} 
		else 
		{
			trace ("c is not a constructor Function")
		}
	}
	
}