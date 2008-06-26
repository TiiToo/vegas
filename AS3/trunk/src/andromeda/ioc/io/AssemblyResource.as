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
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    
    import andromeda.ioc.core.ObjectDefinition;
    import andromeda.ioc.io.ObjectResource;
    import andromeda.process.ActionLoader;
    import andromeda.process.CoreActionLoader;    

    /**
     * This value object contains all information about a dll to load in the application. 
     * @author eKameleon
     */
    public class AssemblyResource extends ObjectResource 
    {
		
		/**
		 * Creates a new AssemblyResource instance.
		 */
        public function AssemblyResource(init:Object = null)
        {
            super(init);
        }
        
        /**
         * The ObjectDefinition of this entry.
         */
        public var definition:ObjectDefinition ;        
        
        /**
         * Creates a new ActionURLLoader object with the resource.
         */
        public override function create():CoreActionLoader
        {
            var action:ActionLoader = new ActionLoader( new Loader() ) ;
			action.request          = new URLRequest( resource ) ;
			action.context          = new LoaderContext( false , ApplicationDomain.currentDomain ) ;
            return action ;
        }        
        
    }
}
