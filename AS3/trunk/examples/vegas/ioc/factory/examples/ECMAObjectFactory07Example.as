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
    import examples.core.Appointment;
    import examples.factory.AppointmentFactory;

    import system.evaluators.*;

    import vegas.ioc.factory.ECMAObjectFactory;

    import flash.display.Sprite;

    public class ECMAObjectFactory07Example extends Sprite 
    {
        public function ECMAObjectFactory07Example()
        {
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;

            
            factory.create( objects ) ;
            
            trace( "---- test evaluators in the constructor arguments" ) ;
                
            trace( "my date : " + factory.getObject("my_date") ) ; 
            //output: my_date : 05.12.2007 10:22:33
                
            var app:Appointment ;
                
            trace( "---- test evaluators in properties" ) ;
                
            app = factory.getObject("appointment_01") as Appointment ;
                
            trace( "> start  : " +  app.scheduledStart ) ; 
            //output: > start  : 30.06.2008 10:30:00
            
            trace( "> finish : " +  app.scheduledEnd   ) ; 
            //output: > finish : 30.06.2008 12:40:00
            
            trace( "---- test evaluators in methods" ) ;
                
            app = factory.getObject("appointment_02") as Appointment ;
            
            trace( "> start  : " +  app.scheduledStart ) ; 
            //output: > start  : 30.06.2008 14:00:00
            
            trace( "> finish : " +  app.scheduledEnd   ) ; 
            //output: > finish : 30.06.2008 16:30:00
            
            trace( "---- test evaluators in factory method strategy" ) ;
            
            app = factory.getObject("appointment_03") as Appointment ;
            
            trace( "> start  : " +  app.scheduledStart ) ; 
            //output: > start  : 30.07.2008 14:00:00
            
            trace( "> finish : " +  app.scheduledEnd   ) ; 
            //output: > finish : 30.07.2008 16:30:00
                    
            trace( "---- test evaluators in static factory method strategy" ) ;
            
            app = factory.getObject("appointment_04") as Appointment ;
            
            trace( "> start  : " +  app.scheduledStart ) ; 
            //output: > start  : 30.08.2008 16:00:00
            
            trace( "> finish : " +  app.scheduledEnd   ) ; 
            //output: > finish : 30.08.2008 17:00:00
        }
        
        ////// linkage enforcer
        
        AppointmentFactory ;
        
        /////
        
        public var objects:Array =
        [
            // evaluators
            
            {
                id        : "eden" ,
                type      : "system.evaluators.EdenEvaluator" ,
                singleton : true ,
                arguments : [ { value:false } ]
            }
            ,
            {
                id        : "date" ,
                type      : "system.evaluators.DateEvaluator" ,
                singleton : true 
            }
            ,
            
            // test in the constructor
            
            {   
                id         : "my_date"  ,
                type       : "String" ,
                arguments  : 
                [ 
                    { 
                        value      : "new Date(2007,11,5,10,22,33)" , 
                        evaluators : 
                        [ 
                            new system.evaluators.EdenEvaluator(false) , 
                            new system.evaluators.DateEvaluator()
                        ]
                    }
                ]
            }
            , // test in the attributes ("properties")
            {   
                id         : "appointment_01"   ,
                type       : "examples.core.Appointment" ,
                properties : 
                [ 
                    { 
                        name       : "scheduledStart" ,
                        value      : "new Date(2008,5,30,10,30,00)" , 
                        evaluators : [ "eden" , "date" ] 
                    }
                    ,
                    { 
                        name       : "scheduledEnd" ,
                        value      : "new Date(2008,5,30,12,40,00)" , 
                        evaluators : 
                        [ 
                            "eden" , 
                            new system.evaluators.DateEvaluator()
                        ]
                    }
                ] 
            }
            , // test in methods ("properties")
            {   
                id         : "appointment_02"   ,
                type       : "examples.core.Appointment" ,
                properties : 
                [ 
                    { 
                        name       : "setShedule" ,
                        arguments  :
                        [
                            {
                                value      : "new Date(2008,5,30,14,00,00)" , 
                                evaluators : 
                                [ 
                                    new system.evaluators.EdenEvaluator(false) , 
                                    "date"
                                ]
                            }
                            ,
                            { 
                                value      : "new Date(2008,5,30,16,30,00)" , 
                                evaluators : [ "eden" , "date" ] 
                            }
                        ]
                    }
                ] 
            }
            
            , // factory method
            
            {
                id   : "appointment_factory"   ,
                type : "examples.factory.AppointmentFactory"
            }
            ,
            {   
                id            : "appointment_03"   ,
                type          : "examples.core.Appointment" ,
                factoryMethod : 
                { 
                    factory    : "appointment_factory" ,
                    name       : "build" ,
                    arguments  :
                    [
                        {
                            value      : "new Date(2008,6,30,14,00,00)" , 
                            evaluators : [ "eden" , "date" ] 
                        }
                        ,
                        { 
                            value      : "new Date(2008,6,30,16,30,00)" , 
                            evaluators : [ "eden" , "date" ] 
                        }
                    ]
                } 
            }
            
            , // static factory method
            
            {   
                id                  : "appointment_04"   ,
                type                : "examples.core.Appointment" ,
                staticFactoryMethod : 
                { 
                    type       : "examples.factory.AppointmentFactory" ,
                    name       : "create" ,
                    arguments  :
                    [
                        {
                            value      : "new Date(2008,7,30,16,00,00);" , 
                            evaluators : [ "eden" , "date" ] 
                        }
                        ,
                        { 
                            value      : "new Date(2008,7,30,17,00,00);" , 
                            evaluators : [ "eden" , "date" ] 
                        }
                    ]
                } 
            }
        ] ;
    }
}
