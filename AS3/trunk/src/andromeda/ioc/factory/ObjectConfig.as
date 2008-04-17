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
package andromeda.ioc.factory 
{
	import system.Reflection;
	
	import vegas.core.CoreObject;	

	/**
	 * This object contains the configuration of the IOC object factory.
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import andromeda.ioc.factory.ECMAObjectFactory ;
	 * import andromeda.ioc.factory.ObjectConfig ;
	 * 
	 * var factory:ECMAObjectFactory = ECMAObjectFactory.getInstance() ;
	 * var config:ObjectConfig        = new ObjectConfig() ;
	 * 
	 * config.defaultInitMethod       = "init" ;
	 * config.defaultDestroyMethod    = "destroy" ;
	 * config.identify                = true ;
	 * 
	 * factory.config = config ;
	 * trace( config ) ; // [ObjectConfig defaultDestroyMethod:destroy defaultInitMethod:init identify:true]
	 * </pre>
	 * @author eKameleon
	 */
	public class ObjectConfig extends CoreObject 
	{

		/**
		 * Creates a new ObjectConfig instance.
		 * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
		 */
		public function ObjectConfig( init:Object=null )
		{
			initialize( init ) ;
		}
		
		/**
		 * The default name of destroy callback method to invoke with object definition in the ObjectFactory. 
		 */
		public var defaultDestroyMethod:String ;

		/**
		 * The default name of destroy callback method to invoke with object definition in the ObjectFactory. 
		 */
		public var defaultInitMethod:String ; 		
		
		/**
		 * Indicates if the singleton objects in the ObjectFactory are identifiy if the type of the object implements the Identifiable interface.
		 */
		public var identify:Boolean ;
		
		/**
		 * Initialize the config object.
		 * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
		 */
		public function initialize( init:Object ):void
		{
			if ( init == null )
			{
				return ;	
			}
			for (var prop:String in init)
			{
				if ( prop in this )
				{
					this[prop] = init[prop] ;	
				}	
			}
		}
		
		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance.
		 */
		public override function toString():String 
		{
			var s:String = "[" + Reflection.getClassName(this) ;
			if ( defaultDestroyMethod != null )
			{
				s += " defaultDestroyMethod:" + defaultDestroyMethod ;
			}
			if ( defaultInitMethod != null )
			{
				s += " defaultInitMethod:" + defaultInitMethod ;
			}
			if ( identify )
			{
				s += " identify:" + identify ;
			}
			s += "]" ;
			return s ;
		}
		
	}
}
