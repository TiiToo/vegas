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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.io 
{
    import flash.net.URLRequest;
    
    import andromeda.process.ActionURLLoader;
    
    import asgard.net.EdenLoader;
    import asgard.net.ParserLoader;    

    /**
     * This resource object contains all information about a context file to load in the application.
     */
    public class ContextResource extends ObjectResource 
    {
    	
        /**
         * Creates a new ContextResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function ContextResource( init:Object=null )
        {
            super(init) ;
            type = ObjectResourceType.CONTEXT ;
        }
        
        /**
         * The root path of all context resources.
         */
        public static var PATH:String = "" ;
    	
    	/**
    	 * The loader to use to parse this object context.
    	 */
    	public var loader:ParserLoader ;
		
		/**
		 * The root path of the context.
		 */
		public var path:String ;
		
        /**
         * Creates a new ActionURLLoader object with the resource.
         */
        public override function create():ActionURLLoader
        {
            var action:ActionURLLoader = new ActionURLLoader( ( loader != null ) ? new (loader as Class)() : new EdenLoader() ) ;
			action.request             = new URLRequest( ( PATH || "" ) + resource ) ;
            return action ;
        }

    }

}
