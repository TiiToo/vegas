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
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/
package examples 
{
    import system.logging.LoggerLevel;
    import system.logging.targets.TraceTarget;

    import vegas.ioc.factory.ECMAObjectFactory;

    import flash.display.Sprite;

    public class ECMAObjectFactory15Example extends Sprite 
    {
        public function ECMAObjectFactory15Example()
        {
            var traceTarget:TraceTarget = new TraceTarget() ;
            
            traceTarget.includeLines = true ;
            traceTarget.includeTime  = true ;
            
            traceTarget.filters      = ["*"] ;
            traceTarget.level        = LoggerLevel.ALL ; // LoggerLevel.DEBUG (only the debug logs).
            
            ///////////////
            
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
            
            factory.create( context ) ; 
            
            trace("------- test a valid id in the factory") ;
            
            trace( factory.getObject("test") ) ;
            
            trace("-------  use trace when a warning log message is invoked in the factory") ;
            
            factory.config.useLogger = false ; 
            
            trace( factory.getObject("test1") ) ;
            
            trace("------- use the Logger object defines by default in the factory") ;
            
            factory.config.useLogger = true ; // default value
            
            trace( factory.getObject("test2") ) ;
            
            trace("------- Disabled all evaluation errors with the throwError flag") ;
            
            factory.config.throwError = true ; // enabled all errors
            trace( factory.getObject("test3") ) ;
            
            factory.config.throwError = false ; // disabled all errors
            trace( factory.getObject("test3") ) ;
        }
        
        public var context:Array =
        [
            { 
                id        : "test" ,
                type      : "String" ,
                arguments : 
                [
                    { value : "hello world" } 
                ]
            }
            ,
            { 
                id        : "o" ,
                type      : "Object" ,
                arguments : 
                [
                    { value : { label:"hi world" } } 
                ]
            }       
            ,
            { 
                id               : "test3" ,
                type             : "String" ,
                factoryReference : "o.labels" 
            }
        ] ;
    }
}
