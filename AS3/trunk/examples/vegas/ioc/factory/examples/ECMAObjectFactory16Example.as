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
    import vegas.ioc.factory.ECMAObjectFactory;

    import flash.display.Sprite;
    import flash.events.Event;

    public class ECMAObjectFactory16Example extends Sprite 
    {
        public function ECMAObjectFactory16Example()
        {
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
            
            factory.config.root = this ;
            
            factory.create(context) ;
        }
        
        public var context:Array =
        [
            { 
                id         : "my_button" ,
                type       : "MyButton"  ,
                singleton  : true        ,
                dependsOn  : [ "root_before" ] ,
                generates  : [ "root_after"  ] ,
                properties :
                [
                    { name : "buttonMode" , value : true } ,
                    { name : "x"          , value : 50   } ,
                    { name : "y"          , value : 50   } 
                ]
            }
            ,
            { 
                id               : "root_before" ,
                type             : "flash.display.Sprite" ,
                factoryReference : "#root" ,
                listeners        :
                [
                    { dispatcher:"my_button" , type:"click" , method:"click" } 
                ]
            }
            ,
            { 
                id               : "root_after" ,
                type             : "flash.display.Sprite" ,
                factoryReference : "#root" ,
                properties       :
                [
                    { name:"addChild" , arguments:[ { ref:"my_button" } ] } 
                ]
            }
        ] ;
        
        public function click( e:Event ):void
        {
            trace("click") ;
        }
    }
}
