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
    
    import vegas.ioc.factory.ObjectFactory;
    import vegas.ioc.net.ECMAObjectLoader;
    
    import flash.display.MovieClip;
    import flash.events.Event;
    
    [SWF(width="740", height="400", frameRate="24", backgroundColor="#660000")]
    
    /**
     * The "xml" resource example.
     */
    public class ECMAObjectLoader04Example extends MovieClip 
    {
        public function ECMAObjectLoader04Example()
        {
            loader = new ECMAObjectLoader( "application_xml_resource.eden" , "context/" ) ;
            
            loader.root = this ;
            
            loader.addEventListener( ActionEvent.FINISH , finish ) ;
            loader.addEventListener( ActionEvent.START  , start  ) ;
            
            loader.run() ;
        }
        
        public var loader:ECMAObjectLoader ;
        
        public function finish( e:Event ):void
        {
            var factory:ObjectFactory = loader.factory ;
            
            trace( e ) ;
            
            var data:XML = factory.getObject( "data" ) as XML ;
                
            trace( "data  : " + data ) ;
            
            // target a node value in the external XML reference.
            
            trace( "data_title : " + factory.getObject( "data_title" ) ) ;
            
            // target an attribute in the external XML reference.
            
            trace( "data_type : " + factory.getObject( "data_type" ) ) ;
        }
        
        public function start( e:Event ):void
        {
            trace( e ) ;
        }
    }
}
