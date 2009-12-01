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
    import vegas.vo.NetServerInfoVO;
    
    import flash.display.Sprite;
    
    public class ECMAObjectFactory04Example extends Sprite 
    {
        public function ECMAObjectFactory04Example()
        {
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
            
            factory.create( objects ) ;
            
            var id:String = "vo_01" ;
                
            // NetServerInfoVO implements the vegas.core.Identifiable interface
            
            var info:NetServerInfoVO = factory.getObject( id ) ;
                
            // The id of the vo is auto populated if the identify property 
            // of the ObjectDefinition of this object is true.
            
            trace( "info id : " + info.id ) ; // with the identify 
        }
        
        ////////////
        
        public var objects:Array =
        [
            {   
                id          : "vo_01"  ,
                type        : "vegas.vo.NetServerInfoVO" ,
                singleton   : true ,
                identify    : true ,
                arguments   : 
                [ 
                    { 
                        value :
                        { 
                            application : "local" ,
                            level       : "error" ,
                            code        : "application_error" ,
                            description : "An error is invoqued in the application" ,
                            line        : 3 ,
                            methodName  : "noMethod" ,
                            serviceName : "noService" 
                        } 
                    }
                ]
            }
        ] ;
    }
}
