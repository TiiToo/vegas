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

    public class ECMAObjectFactory13Example extends Sprite 
    {
        public function ECMAObjectFactory13Example()
        {
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
            
            // use trace() and not the internal getLogger() method in the factory to log the warning messages.
            
            factory.config.useLogger = false ; 
            
            factory.config.config = 
            {
                info :
                {
                    code    : 10 ,
                    message : "hello world" 
                }
            } ;
            
            factory.create( context ) ; 
            
            trace( "code    : " + factory.getObject( "my_code"    ) ) ; // code    : 10
            trace( "message : " + factory.getObject( "my_message" ) ) ; // message : hello world
        }
        
        public var context:Array =
        [
            { 
                id        : "my_code" ,
                type      : "uint" ,
                arguments : 
                [
                    { config : "info.code" } 
                ]
            }
            ,
            { 
                id        : "my_message" ,
                type      : "String" ,
                arguments : 
                [
                    { config : "info.message" } 
                ]
            }
        ] ;
    }
}
