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
package andromeda.ioc.evaluators 
{
    import flash.utils.getDefinitionByName;
    
    import andromeda.ioc.core.TypeAliases;
    import andromeda.ioc.core.TypePolicy;
    import andromeda.ioc.factory.ObjectConfig;
    
    import system.evaluators.IEvaluator;
    
    import vegas.core.CoreObject;    

    /**
     * Evaluates a type string expression and return the type Class who corresponding in the application.
     * @author eKameleon
     */
    public class TypeEvaluator extends CoreObject implements IEvaluator 
    {
        
        /**
         * Creates a new TypeEvaluator instance.
         * @param config The optional ObjectConfig object to filter the type expression to evaluate.
         */
        public function TypeEvaluator( config:ObjectConfig=null )
        {
            this.config = config ;
        }
        
        /**
         * The ObjectConfig reference of this evaluator.
         */
        public var config:ObjectConfig ;
        
        /**
         * Evaluates the specified object.
         */
        public function eval( o:* ):*
        {
            if ( o is Class )
            {
                return o as Class ;
            }
            else if ( o is String )
            {
                
                var type:String = o as String ;
                
                if ( config != null )
                {
                    var policy:String = config.typePolicy ;
                    
                    if ( policy == TypePolicy.ALL || policy == TypePolicy.ALIAS )
                    {
                        var aliases:TypeAliases = (config.typeAliases as TypeAliases) ;
                        if ( aliases != null && aliases.containsAlias(type) )
                        {
                            type = aliases.getValue(type) ;
                        }
                    }
                                        
                }
                
                try
                {
                    return getDefinitionByName( type ) as Class ;
                }
                catch( e:ReferenceError )
                {
                    return null ;
                }
            
            }
            
            return null ;
        }
    }
}
