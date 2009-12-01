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
    import examples.core.User;
    
    import system.events.ActionEvent;
    
    import vegas.ioc.ObjectAttribute;
    import vegas.ioc.factory.ECMAObjectFactory;
    import vegas.ioc.factory.ObjectConfig;
    import vegas.strings.JSON;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
    public class ECMAObjectFactory02Example extends Sprite 
    {
        public function ECMAObjectFactory02Example()
        {
            stage.align     = StageAlign.TOP_LEFT ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            factory = ECMAObjectFactory.getInstance() ;
            
            factory.addEventListener( IOErrorEvent.IO_ERROR   , debug ) ;
            factory.addEventListener( ProgressEvent.PROGRESS  , debug ) ;
            factory.addEventListener( Event.COMPLETE          , debug ) ;
            factory.addEventListener( ActionEvent.START       , debug ) ;
            factory.addEventListener( ActionEvent.FINISH      , main  ) ;
            
            var request:URLRequest = new URLRequest( "context/application.json" ) ;
            
            var loader:URLLoader   = new URLLoader() ;
            loader.addEventListener( Event.COMPLETE , complete ) ;
            
            loader.load( request ) ;
        }
        
        public var factory:ECMAObjectFactory ;
        
        public function complete( event:Event ):void
        {
            var loader:URLLoader = event.target as URLLoader ;
            var source:String    = loader.data ;
            var context:Object   = JSON.deserialize(source) ;
            
            factory.config = new ObjectConfig( context[ ObjectAttribute.CONFIGURATION ] ) ;
            factory.create( context[ ObjectAttribute.OBJECTS ] ) ;     
        }
        
        public function debug( e:Event ):void
        {
            trace( e ) ;
        }
        
        public function main( e:ActionEvent ):void
        {
            trace( e ) ;
            
            var user:User = factory.getObject( "user" ) ;
            
            trace( "User pseudo         : " + user.pseudo ) ; // ekameleon
            trace( "User firstName      : " + user.firstName ) ; // Marc
            trace( "User name           : " + user.name ) ; // ALCARAZ
            trace( "User age            : " + user.age ) ; // 32
            trace( "User mail           : " + user.mail ) ; // ekameleon@gmail.com
            trace( "User url            : " + user.url  ) ; // http://www.ekameleon.net/blog
            trace( "User job            : " + user.job ) ; // [Job AS Developper]
            trace( "User address        : " + user.address ) ; // [Address]
            trace( "User address city   : " + user.address.city ) ; // Marseille
            trace( "User address street : " + user.address.street ) ; // xx xxx xxxxxxxxxxx
            trace( "User address zip    : " + user.address.zip ) ; // 13004
            
            trace( "User isSingleton    : " + factory.isSingleton( "user" ) ) ;
            trace( "User isLazyInit     : " + factory.isLazyInit( "user" ) ) ;
            
            var sprite:Sprite = factory.getObject("square") as Sprite ; // use external dll
            addChild(sprite) ;
        }
    }
}
