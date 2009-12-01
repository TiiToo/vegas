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
    import system.data.lists.LinkedList;
    import system.data.maps.HashMap;
    
    import vegas.ioc.TypePolicy;
    import vegas.ioc.evaluators.TypeEvaluator;
    import vegas.ioc.factory.ObjectConfig;
    
    import flash.display.Sprite;
    
    public class TypeEvaluatorExample extends Sprite 
    {
        public function TypeEvaluatorExample()
        {
            /////// linkage enforcer
            
            LinkedList ; HashMap ;
            
            //////
            
            var conf:ObjectConfig = new ObjectConfig() ;
            
            conf.typePolicy = TypePolicy.ALL ; // TypePolicy.NONE, TypePolicy.ALIAS, TypePolicy.EXPRESSION
            
            conf.typeAliases = 
            [ 
                { alias:"LinkedList" , type:"system.data.lists.LinkedList" } 
            ] ;
            
            conf.typeExpression = 
            [ 
                { name:"map"     , value:"system.data.maps" } ,
                { name:"HashMap" , value:"{map}.HashMap"  } 
            ] ;
            
            var evaluator:TypeEvaluator = new TypeEvaluator( conf ) ;
            
            trace( evaluator.eval( "system.data.lists.LinkedList"  ) ) ;
            trace( evaluator.eval( "LinkedList"  ) ) ; 
            trace( evaluator.eval( "{HashMap}"   ) ) ; 
            trace( evaluator.eval( "test"        ) ) ; 
            trace( evaluator.eval( "{map}.Test"  ) ) ; 
        }
    }
}
