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
    import vegas.display.SWFInfo;
    
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.ByteArray;
    
    /**
     * Example with the vegas.display.SWFInfo class.
     */
    public class SWFInfoExample extends Sprite 
    {
        public function SWFInfoExample()
        {
            if ( stage )
            {
                stage.align      = StageAlign.TOP_LEFT ;
                stage.scaleMode  = StageScaleMode.NO_SCALE ;
            }
            
            var request:URLRequest = new URLRequest( "CoreBitmap.swf" ) ;
            var context:LoaderContext = new LoaderContext( false, ApplicationDomain.currentDomain ) ;
            
            loader = new Loader() ;
            loader.contentLoaderInfo.addEventListener( Event.COMPLETE , complete ) ;
            
            addChild( loader ) ;
            
            loader.load( request , context ) ;
        }
        
        public var loader:Loader ;
        
        public function complete( e:Event ):void
        {
            trace("-------") ;
            
            var swf:ByteArray = loader.loaderInfo.bytes ;
            
            trace( "SWF complete : " +  swf  ) ;
            
            var info:SWFInfo  = new SWFInfo( swf ) ;
            
            trace( "SWF compressed         : " + info.compressed  ) ;   
            trace( "SWF fileLength         : " + info.fileLength  ) ;   
            trace( "SWF frameCount         : " + info.frameCount ) ;
            trace( "SWF frameRate          : " + info.frameRate  ) ;
            trace( "SWF version            : " + info.version  ) ;  
            trace( "SWF symbol class names : " + info.symbolClassNames ) ;
            
            trace("-------") ;  
        }
    }
}
