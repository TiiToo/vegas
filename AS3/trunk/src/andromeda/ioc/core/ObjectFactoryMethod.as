/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.core 
{

	/**
	 * This object create a delegate factory configured in the IObjectDefinition and replace the natural factory of the ObjectFactory.
	 * @author eKameleon
	 */
	public class ObjectFactoryMethod extends ObjectMethod 
	{
		
		/**
		 * Creates a new ObjectFactoryMethod instance.
		 * @param factory The factory string representation of the reference of this factory method object.
		 * @param name The name of the method to invoke to create the object.
		 * @param arguments The array of the arguments to passed-in the factory method.
		 */
		public function ObjectFactoryMethod( factory:String , name:String , arguments:Array =null )
		{
			super( name , arguments );
			this.factory = factory ;
		}
		
		/**
		 * Returns the ObjectFactoryMethod representation of the specified generic object or null.
		 * @return the ObjectFactoryMethod representation of the specified generic object or null.
		 */
		public static function create( factoryMethod:Object=null ):ObjectFactoryMethod
		{
			if ( factoryMethod == null ) 
			{
				return null ;
			}
			if ( ObjectAttribute.FACTORY in factoryMethod && ObjectAttribute.NAME in factoryMethod )
			{
				return new ObjectFactoryMethod
				( 
					factoryMethod[ ObjectAttribute.FACTORY   ] , 
					factoryMethod[ ObjectAttribute.NAME      ] , 
					factoryMethod[ ObjectAttribute.ARGUMENTS ]  
				) ;
			}
			else
			{
				return null ;
			}		
		}
		
		/**
		 * The factory string representation of the reference of this factory method object.
		 */
		public var factory:String ;
		
	}
}
