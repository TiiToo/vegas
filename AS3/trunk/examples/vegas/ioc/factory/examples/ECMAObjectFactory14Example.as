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

    public class ECMAObjectFactory14Example extends Sprite 
    {
        public function ECMAObjectFactory14Example()
        {
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
            
            // use trace() and not the internal getLogger() method in the factory to log the warning messages.
            
            factory.config.useLogger = false ; 
            
            factory.config.locale = 
            {
                errors :
                {
                    authentification_login    : "The login is invalid" ,
                    authentification_password : "The password login is invalid" 
                }
            };
            
            factory.create( context ) ; 
            
            trace( "error1 : " + factory.getObject( "error1" ) ) ; // error1 : The login is invalid
            trace( "error2 : " + factory.getObject( "error2" ) ) ; // error2 : The password login is invalid
        }
        
        public var context:Array =
        [
            { 
                id        : "error1" ,
                type      : "String" ,
                arguments : 
                [
                    { locale : "errors.authentification_login" } 
                ]
            }
            ,
            { 
                id        : "error2" ,
                type      : "String" ,
                arguments : 
                [
                    { locale : "errors.authentification_password" } 
                ]
            }
        ] ;
    }
}
