/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
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
    import flash.text.TextFormat;
    
    [SWF(width="340", height="120", frameRate="24", backgroundColor="#666666")]
    
    public class ECMAObjectFactory21Example extends Sprite 
    {
        public function ECMAObjectFactory21Example()
        {
            factory = new ECMAObjectFactory() ;
            factory.config.root = this ;
            factory.config.config =
            {
                field : 
                {
                    autoSize          : "left" ,
                    border            : false ,
                    defaultTextFormat : new TextFormat( "Verdana", 16  , 0xFFFF00) , 
                    selectable        : false ,
                    x                 : 25 ,
                    y                 : 25 
                }
            };
            factory.create( objects ) ;
        }
        
        public var factory:ECMAObjectFactory ;
        
        public var info:Function ;
        
        public function debug( message:String = "default debug message" ):void
        {
            trace( "debug : " + message ) ;
        }
        
        public function write( message:String = "default write message" ):void
        {
            trace( "write : " +  message ) ;
        }
        
        public var objects:Array =
        [
            {
                id         : "field" ,
                type       : "flash.text.TextField" ,
                singleton  : true ,
                lazyInit   : true ,
                properties :
                [
                    { name : "#init" , config : "field"       } , 
                    { name : "text"  , value  : "hello world" } 
                ]
            }
            ,
            {
                id               : "application" ,
                type             : "flash.display.Sprite" ,
                factoryReference : "#root" ,
                singleton        : true ,
                properties       :
                [
                    { name : "addChild"   , arguments  : [ { ref : "field" } ] } 
                ]
            }
        ] ;
    }
}
