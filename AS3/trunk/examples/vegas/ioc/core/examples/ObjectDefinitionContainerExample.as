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
    import vegas.ioc.IObjectFactory;
    import vegas.ioc.ObjectDefinition;
    import vegas.ioc.ObjectDefinitionContainer;
    import vegas.ioc.factory.ObjectFactory;
    
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    public class ObjectDefinitionContainerExample extends Sprite 
    {
        public function ObjectDefinitionContainerExample()
        {
            var container:ObjectDefinitionContainer = new ObjectFactory();
             
            var context:Object =
            {
                id         : "my_field" ,
                type       : "flash.text.TextField" ,
                properties : 
                [
                    { name:"defaultTextFormat" , value:new TextFormat("Verdana", 11) } ,
                    { name:"selectable"        , value:false                         } ,
                    { name:"text"              , value:"hello world"                 } ,
                    { name:"textColor"         , value:0xF7F744                      } ,
                    { name:"x"                 , value:100                           } ,
                    { name:"y"                 , value:100                           } 
                ]
            };
            
            var definition:ObjectDefinition = ObjectDefinition.create( context ) ;
            
            container.addObjectDefinition( definition );
            
            trace( container.containsObjectDefinition( "my_field" ) ) ; // true
            trace( container.getObjectDefinition("my_field") ) ; // [ObjectDefinition]
            trace( container.sizeObjectDefinition() ) ; // 1
            
            var field:TextField = (container as IObjectFactory).getObject("my_field") as TextField ;
            
            addChild( field ) ;
        }
    }
}
