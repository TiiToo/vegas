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
    
    public class ECMAObjectFactory20Example extends Sprite 
    {
        public function ECMAObjectFactory20Example()
        {
            factory = new ECMAObjectFactory() ;
            factory.config.root = this ;
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
                id               : "application" ,
                type             : "examples.ECMAObjectFactory20Example" ,
                factoryReference : "#root" ,
                singleton        : true ,
                properties       :
                [
                    { name : "write"    , arguments  : [ { value : "hello world 1" } ] } ,
                     
                    { name : "info" , ref : "application.write"  } ,
                    { name : "info" } ,
                    { name : "info" , arguments  : [ { value : "hello world 2" } ] } ,
                    
                    { name : "info" , value : debug  } ,
                    { name : "info" } ,
                    { name : "info" , arguments  : [ { value : "hello world 3" } ] }
                ]
            }
        ] ;
    }
}
