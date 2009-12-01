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
    import vegas.config.Config;
    
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Example of the Config class.
     */
    public class ConfigExample extends Sprite
    {
        public function ConfigExample()
        {
            var init:Object = 
            {
                header :
                {
                    name    : "CONFIG TEST" , 
                    version : "1.0.0.0"
                }
                ,
                views :
                {
                    field :
                    {
                        autoSize          : "left" ,
                        defaultTextFormat : new TextFormat("Arial", 14) ,
                        text              : "hello world" ,
                        textColor         : 0xE2E2E2 ,
                        x                 : 10 ,
                        y                 : 10
                    }
                }
            } ;
            
            var conf:Config = new Config() ;
            
            // Initialize the dynamic configuration with a dynamic object.
            
            conf.map( init ) ;
            
            // target values with the dot notation or the get() method.
            
            trace( "conf.header.name           : " + conf.header.name ) ;
            trace( "conf.get('header.version') : " + conf.get('header.version') ) ;
            
            // initialize an object in the application with the init() method
            
            var field:TextField = new TextField() ;
            
            addChild( field ) ;
            
            conf.init( field , "views.field" ) ;
        }
    }
}
