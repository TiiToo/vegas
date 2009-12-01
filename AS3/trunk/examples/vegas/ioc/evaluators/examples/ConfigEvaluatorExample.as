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
    import vegas.ioc.evaluators.ConfigEvaluator;
    import vegas.ioc.factory.ObjectConfig;
    
    import flash.display.Sprite;
    
    public class ConfigEvaluatorExample extends Sprite 
    {
        public function ConfigEvaluatorExample()
        {
            var init:Object = 
            {
                message : "hello world" ,
                menu    :
                {
                    title : "my title" ,
                    count : 10 ,
                    data  : [ "item1" , "item2", "item3" ]
                }
            };
            
            var configurator:ObjectConfig = new ObjectConfig() ;
            configurator.config           = init ;
            
            var evaluator:ConfigEvaluator = new ConfigEvaluator( configurator ) ;
            
            trace( evaluator.eval( "message"     ) ) ; // hello world
            trace( evaluator.eval( "menu"        ) ) ; // [object Object]
            trace( evaluator.eval( "menu.title"  ) ) ; // my title
            trace( evaluator.eval( "menu.count"  ) ) ; // 10
            trace( evaluator.eval( "menu.data"   ) ) ; // item1,item2,item3
            
            trace( evaluator.eval( "unknow"      ) ) ; // null
            trace( evaluator.eval( "menu.unknow" ) ) ; // null
        }
    }
}
