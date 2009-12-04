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
    import vegas.ioc.ObjectDefinition;
    import vegas.ioc.ObjectProperty;
    
    import flash.display.Sprite;
    import flash.text.TextField;
    
    public class ObjectPropertyExample extends Sprite 
    {
        public function ObjectPropertyExample()
        {
        	TextField ;
            var init:Object =
            {
                id         : "my_field" ,
                type       : "flash.text.TextField" ,
                properties : 
                [
                    { name:"unknow"                                                          } ,
                    { name:"defaultTextFormat" , ref       : "my_format"                     } ,
                    { name:"multiline"         , value     : true                            } ,
                    { name:"selectable"        , config    : "my_field.selectable"           } ,
                    { name:"text"              , locale    : "my_field.text"                 } ,
                    { name:"text"              , locale    : "my_field.text"                 } ,
                    { name:"appendText"        , arguments : [ { value : "my_field.text" } ] } 
                ]
            };
            
            var definition:ObjectDefinition = ObjectDefinition.create( init ) ;
            var properties:Array            = definition.getProperties() ;
            
            for each( var property:ObjectProperty in properties )
            {
                trace( property.name , property.policy , property.value ) ;
            }
        }
    }
}
