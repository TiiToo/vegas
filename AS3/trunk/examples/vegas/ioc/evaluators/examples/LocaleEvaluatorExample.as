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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package examples 
{
    import vegas.ioc.evaluators.LocaleEvaluator;
    import vegas.ioc.factory.ObjectConfig;

    import flash.display.Sprite;

    public class LocaleEvaluatorExample extends Sprite 
    {
        public function LocaleEvaluatorExample()
        {
            var locale:Object =
            {
                 message : "hello world" ,
                 title   : "my title"    ,
                 menu    :
                 {
                     title : "my menu title" ,
                     label : "my label"
                 }
            };
            
            var configurator:ObjectConfig = new ObjectConfig() ;
            configurator.locale           = locale ;
            
            var evaluator:LocaleEvaluator = new LocaleEvaluator( configurator ) ;
            
            trace( evaluator.eval( "message"    ) ) ; // hello world
            trace( evaluator.eval( "title"      ) ) ; // my title
            trace( evaluator.eval( "menu.title" ) ) ; // my menu title
            trace( evaluator.eval( "menu.label" ) ) ; // my label
            
            trace( evaluator.eval( "unknow"       ) ) ; // null
            trace( evaluator.eval( "menu.unknow"  ) ) ; // null
        }
    }
}
