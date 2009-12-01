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
    import system.events.ActionEvent;
    
    import vegas.ioc.io.ShaderResource;
    import vegas.ioc.net.ECMAObjectLoader;
    
    import flash.display.Sprite;
    import flash.events.Event;
    
    [SWF(width="200", height="200", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Test the ShaderResource class. 
     * Note : The ShaderResource isn't register in the ObjectResourceBuilder.
     * Run  : Use this example only with the FP10 compilation with the compiler parameters :
     * -default-size 550 400 -default-frame-rate 31 -default-background-color 0x666666 -target-player=10.0.0
     */
    public class ECMAObjectLoader09Example extends Sprite 
    {
        public function ECMAObjectLoader09Example()
        {
            // register the resource in the ObjectResourceBuilder singleton.
            
            ShaderResource.register() ; 
            
            // load the external IoC context and initialize the application.
            
            var loader:ECMAObjectLoader = new ECMAObjectLoader( "context/application_shader_resource.eden" ) ;
            
            loader.addEventListener( ActionEvent.FINISH , finish ) ;
            loader.addEventListener( ActionEvent.START  , start ) ;
            
            loader.root = this ;
            loader.run() ;
        }
        
        public function finish( e:Event ):void
        {
            trace("finish") ;
        }
        
        public function start( e:Event ):void
        {
            trace("start") ;
        }
    }
}