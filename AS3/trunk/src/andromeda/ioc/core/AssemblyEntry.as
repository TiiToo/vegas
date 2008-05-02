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
    import vegas.core.CoreObject;
    
    /**
     * This entry contains an ObjectDefinition and this assemblyName value. 
     * @author eKameleon
     */
    public class AssemblyEntry extends CoreObject 
    {

        /**
         * Creates a new AssemblyEntry instance.
         * @param name The name of the assembly file to load.
         * @param definition The object definition attached with the assembly file.
         */
        public function AssemblyEntry( name:String , definition:ObjectDefinition )
        {
            this.name       = name ;
            this.definition = definition ;
        }
        
        /**
         * The ObjectDefinition of this entry.
         */
        public var definition:ObjectDefinition ;
            
        /**
         * The name of this entry.
         */
        public var name:String ;
        
    }
}
