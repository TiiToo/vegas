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
  exa
  Contributor(s) :
  
*/
package examples 
{
    import vegas.ioc.factory.ECMAObjectFactory;
    import vegas.vo.FilterVO;

    import flash.display.Sprite;

    public class ECMAObjectFactory08Example extends Sprite 
    {
        public function ECMAObjectFactory08Example()
        {
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
             
            factory.create( context ) ; 
            
            trace( factory.getObject( "my_filter" ) as FilterVO ) ; // [FilterVO:3]
        }
        
        /////
        
        public var context:Array =
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
        ] ;
    }
}
