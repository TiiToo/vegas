﻿/*
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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package examples 
{
    import vegas.ioc.evaluators.ReferenceEvaluator;
    import vegas.ioc.factory.ECMAObjectFactory;
    import vegas.vo.FilterVO;
    
    import flash.display.Sprite;
    
    public class ReferenceEvaluatorExample extends Sprite 
    {
        public function ReferenceEvaluatorExample()
        {
            ///////// linkage enforcer
            
            FilterVO ;
             
            /////////
            
            var objects:Array =
            [
                 { 
                    id         : "VIDEO" ,
                    type       : "vegas.vo.FilterVO" ,
                    properties : [ { name:"filter" , value:1 } ]
                }
                ,
                { 
                    id         : "MP3" ,
                    type       : "vegas.vo.FilterVO" ,
                    properties : [ { name:"filter" , value:2 } ]
                }
                ,
                { 
                    id         : "my_filter" ,
                    type       : "vegas.vo.FilterVO" ,
                    properties : 
                    [ 
                        { name:"toggleFilter" , arguments:[ { ref : "VIDEO.filter" } , { value : true } ] } ,
                        { name:"toggleFilter" , arguments:[ { ref : "MP3.filter"   } , { value : true } ] } 
                    ]
                }    
            ];
            
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
            
            factory.create( objects ) ;
            
            var evaluator:ReferenceEvaluator = new ReferenceEvaluator( factory ) ;
            
            // test evaluator
            
            trace( evaluator.eval( "DISK" ) ) ; // null 
            trace( evaluator.eval( "VIDEO" ) ) ; // [FilterVO:1]
            trace( evaluator.eval( "VIDEO.filter" ) ) ; // 1
            
            // test in the factory
            
            trace( factory.getObject( "my_filter" ) ) ; // [FilterVO:3]
        }
    }
}
