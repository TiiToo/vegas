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
    import vegas.vo.NetServerInfoVO;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Example of the NetServerInfoVO class.
     */
    public class NetServerInfoVOExample extends Sprite 
    {
        public function NetServerInfoVOExample()
        {
            var info:NetServerInfoVO = new NetServerInfoVO() ;
            
            info.application = "local" ;
            info.level       = "error" ;
            info.code        = "application_error" ;
            info.description = "An error is invoqued in the application" ;
            info.line        = 3 ;
            info.methodName  = "noMethod" ;
            info.serviceName = "noService" ;
            
            trace("toString  : " + info) ;
            trace("toSource  : " + info.toSource()) ;
        }
    }
}
