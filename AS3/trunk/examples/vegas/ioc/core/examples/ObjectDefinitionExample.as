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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package examples 
{
    import vegas.ioc.ObjectDefinition;
    
    import flash.display.Sprite;
    import flash.text.TextFormat;
    
    public class ObjectDefinitionExample extends Sprite 
    {
        public function ObjectDefinitionExample()
        {
            var init:Object =
            {
                id         : "my_field" ,
                type       : "flash.text.TextField" ,
                singleton  : true ,
                properties : 
                [
                    { name:"defaultTextFormat" , value:new TextFormat("Verdana", 11) } ,
                    { name:"selectable"        , value:false                         } ,
                    { name:"text"              , value:"hello world"                 } 
                ]
                ,
                dependsOn : ["dep1", "dep2"] ,
                generates : ["gen1", "gen2"] 
            };
            
            var definition:ObjectDefinition = ObjectDefinition.create( init ) ;
            
            trace( "definition.id              : " + definition.id ) ;
            trace( "definition.getType()       : " + definition.getType() ) ;
            trace( "definition.getScope()      : " + definition.getScope() ) ;
            trace( "definition.isSingleton()   : " + definition.isSingleton() ) ;
            trace( "definition.isLazyInit()    : " + definition.isLazyInit() ) ;
            trace( "definition.getProperties() : " + definition.getProperties() ) ;
            trace( "definition.getDependsOn()  : " + definition.getDependsOn() ) ;
            trace( "definition.getGenerates()  : " + definition.getGenerates() ) ;
        }
    }
}
