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
    import examples.vo.User;
    
    import system.eden;
    import system.events.ActionEvent;
    
    import vegas.display.CoreSprite;
    import vegas.ioc.factory.ECMAObjectFactory;
    import vegas.ioc.io.ObjectResourceInfo;
    import vegas.ioc.net.ECMAObjectLoader;
    
    import flash.display.Bitmap;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    
    [SWF(width="740", height="400", frameRate="24", backgroundColor="#660000")]
    
    /**
     * Example of the ECMAObjectLoader class with external resources.
     */
    public class ECMAObjectLoader02Example extends MovieClip 
    {
        public function ECMAObjectLoader02Example()
        {
            stage.scaleMode = "noScale" ;
            
            var loader:ECMAObjectLoader = new ECMAObjectLoader( "application.eden" , "context/" ) ;
            
            loader.addEventListener( ActionEvent.START  , start ) ;
            loader.addEventListener( ActionEvent.FINISH , finish ) ;
            
            loader.resourceInfo.addEventListener( Event.OPEN             , debug ) ;
            loader.resourceInfo.addEventListener( ProgressEvent.PROGRESS , debug ) ;
            loader.resourceInfo.addEventListener( Event.COMPLETE         , debug ) ;
            
            loader.run() ;
        }
        
        public function debug( e:Event ):void
        {
            var info:ObjectResourceInfo = e.target as ObjectResourceInfo ;
            trace( e.type + " : " + info.resource + " :: " + info.bytesLoaded + " / " + info.bytesTotal ) ;
        }
        
        public function start( e:Event ):void
        {
            trace( ">>>> " + e ) ;
        }
        
        public function finish( e:Event ):void
        {
            trace( ">>>> " + e ) ;
            
            var factory:ECMAObjectFactory = ECMAObjectFactory.getInstance() ;
            
            var container:CoreSprite = factory.getObject("my_container") as CoreSprite ;
            
            trace( container + " id:" + container.id ) ; // my_container
            
            addChild( container ) ;
            
            // from a basic assembly resource
            
            var logo:MovieClip = factory.getObject("my_logo") as MovieClip ;
            
            addChild( logo ) ;
            
            // from an assembly resource with object definition
            
            var picture:Bitmap = factory.getObject("my_picture") as Bitmap ;
            
            addChild( picture ) ;
        }
        
        //// eden white list
        
        eden.addAuthorized( "flash.filters.*" ) ;
        eden.addAuthorized( "flash.text.TextField" ) ;
        eden.addAuthorized( "flash.text.TextFormat" ) ; 
        
        //// Enforces the linked class in the application
        
        User ;
        
        ////
    }
}
