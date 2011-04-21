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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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
    import system.events.ActionEvent;
    
    import vegas.ioc.io.ShaderResource;
    import vegas.net.ApplicationLoader;
    
    import flash.display.Sprite;
    import flash.events.Event;
    
    [SWF(width="200", height="200", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Test the ShaderResource class. 
     * Note : The ShaderResource isn't register in the ObjectResourceBuilder.
     * Run  : Use this example only with the FP10 compilation with the compiler parameters :
     * -default-size 200 200 -default-frame-rate 31 -default-background-color 0x666666 -target-player=10.0
     */
    public class ApplicationLoader09Example extends Sprite 
    {
        public function ApplicationLoader09Example()
        {
            // register the resource in the ObjectResourceBuilder singleton.
            
            ShaderResource.register() ; 
            
            // load the external IoC context and initialize the application.
            
            var loader:ApplicationLoader = new ApplicationLoader( "context/application_shader_resource.eden" ) ;
            
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