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
