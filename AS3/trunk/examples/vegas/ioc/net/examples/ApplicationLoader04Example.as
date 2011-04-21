﻿/*

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
    import system.ioc.ObjectFactory;

    import vegas.net.ApplicationLoader;

    import flash.display.MovieClip;
    import flash.events.Event;
    
    [SWF(width="740", height="400", frameRate="24", backgroundColor="#660000")]
    
    /**
     * The "xml" resource example.
     */
    public class ApplicationLoader04Example extends MovieClip 
    {
        public function ApplicationLoader04Example()
        {
            loader = new ApplicationLoader( "application_xml_resource.eden" , "context/" ) ;
            
            loader.root = this ;
            
            loader.addEventListener( ActionEvent.FINISH , finish ) ;
            loader.addEventListener( ActionEvent.START  , start  ) ;
            
            loader.run() ;
        }
        
        public var loader:ApplicationLoader ;
        
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
