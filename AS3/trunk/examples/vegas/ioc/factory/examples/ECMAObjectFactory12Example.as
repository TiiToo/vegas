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
    import examples.core.Listener;

    import vegas.ioc.factory.ECMAObjectFactory;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.EventDispatcher;

    public dynamic class ECMAObjectFactory12Example extends Sprite 
    {
        public function ECMAObjectFactory12Example()
        {
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
            
            factory.create( context ) ; 
            
            // 1 - target the callback "handleEvent" method in the listener object (all objects with methods can be a listener)
            
            var dispatcher1:EventDispatcher = factory.getObject("dispatcher1") as EventDispatcher ;
            
            dispatcher1.dispatchEvent( new Event( "change" ) ) ;
            
            // 2 - target the listener object if implements the system.events.EventListener interface.
            
            var dispatcher2:EventDispatcher = factory.getObject("dispatcher2") as EventDispatcher ;
            
            dispatcher2.dispatchEvent( new Event( "change" ) ) ;
            
            // 3 - target the listener register before the properties initialization.
            
            var dispatcher3:EventDispatcher = factory.getObject("dispatcher3") as EventDispatcher ;
            
            dispatcher3.dispatchEvent( new Event( "change" ) ) ;
        }
        
        ////// linkage enforcer
        
        Listener ;
        
        /////
        
        public var context:Array =
        [
            { 
                id        : "dispatcher1" ,
                type      : "flash.events.EventDispatcher" ,
                singleton : true
            }
            ,
            { 
                id        : "dispatcher2" ,
                type      : "flash.events.EventDispatcher" ,
                singleton : true
            }
            ,
            { 
                id        : "dispatcher3" ,
                type      : "flash.events.EventDispatcher" ,
                singleton : true
            }
            ,
            { 
                id        : "listener"   ,
                type      : "examples.core.Listener" ,
                singleton : true ,
                listeners :
                [
                    { dispatcher:"dispatcher1" , type:"change" , method:"change" , useCapture:false, priority:0 , useWeakReference:true } , 
                    { dispatcher:"dispatcher2" , type:"change" } ,
                    { dispatcher:"dispatcher3" , type:"change" , order : "before" } ,
                ]
            }
        ] ;
    }
}
