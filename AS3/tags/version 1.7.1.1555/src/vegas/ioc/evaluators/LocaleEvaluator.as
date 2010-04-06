﻿/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

package vegas.ioc.evaluators 
{
    import vegas.ioc.factory.ObjectConfig;
    
    import system.evaluators.PropertyEvaluator;
    
    /**
     * Evaluates a type string expression and return the value who corresponding in the locale reference in the configuration of the factory.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.ioc.evaluators.LocaleEvaluator ;
     * import vegas.ioc.factory.ObjectConfig ;
     * 
     * var locale:Object =
     * {
     *     message : "hello world" ,
     *     title   : "my title"    ,
     *     menu    :
     *     {
     *         title : "my menu title" ,
     *         label : "my label"
     *     }
     * }
     * 
     * var configurator:ObjectConfig = new ObjectConfig() ;
     * configurator.locale           = locale ;
     * 
     * var evaluator:LocaleEvaluator = new LocaleEvaluator( configurator ) ;
     * 
     * trace( evaluator.eval( "test"       ) ) ; // null
     * trace( evaluator.eval( "message"    ) ) ; // hello world
     * trace( evaluator.eval( "title"      ) ) ; // my title
     * trace( evaluator.eval( "menu.title" ) ) ; // my menu title
     * trace( evaluator.eval( "menu.label" ) ) ; // my label
     * </pre>
     */
    public class LocaleEvaluator extends PropertyEvaluator
    {
        /**
         * Creates a new LocaleEvaluator instance.
         * @param config The optional ObjectConfig object to filter the type expression to evaluate.
         */
        public function LocaleEvaluator( config:ObjectConfig=null )
        {
            this.config = config ;
        }
        
        /**
         * The ObjectConfig reference of this evaluator.
         */
        public var config:ObjectConfig ;
        
        /**
         * The ObjectConfig reference of this evaluator.
         */
        public override function get target():*
        {
            return config != null ? config.locale : null ;
        }
    }
}