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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
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
package srt 
{
    import core.reflect.getClassName;

    import graphics.Align;
    import graphics.display.DisplayObjects;

    import system.logging.LoggerLevel;
    import system.logging.targets.SOSTarget;

    import vegas.media.subtitles.Caption;
    import vegas.media.subtitles.Captions;
    import vegas.media.subtitles.SRTParser;
    import vegas.net.NetStreamExpert;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.filters.DropShadowFilter;
    import flash.geom.Point;
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.utils.Timer;
    
    [SWF(width="740", height="480", frameRate="30", backgroundColor="0x333333")]
    
    public class SRTExample extends Sprite 
    {
        public function SRTExample()
        {
            // stage
            
            stage.align                  = StageAlign.TOP_LEFT ; 
            stage.scaleMode              = StageScaleMode.NO_SCALE ;
            stage.showDefaultContextMenu = false ;
            
            // logging
            
            var sos:SOSTarget = new SOSTarget( getClassName(this) , 0xA2A2A2 ) ;
            
            sos.filters       = ["*"] ;
            sos.level         = LoggerLevel.ALL ;
            sos.includeLines  = true  ;
            sos.includeTime   = true  ;
            
            /////
            
            timer = new Timer(150) ;
            
            timer.addEventListener( TimerEvent.TIMER , timerProgress ) ;
            
            /////
            
            connection = new NetConnection() ;
            
            connection.connect(null) ;
            
            stream = new NetStream( connection ) ;
            
            expert = new NetStreamExpert( stream ) ;
            
            expert.timer = timer ;
            
            /////
            
            video = new Video( 640 ,360 ) ;
            
            video.x = 25 ;
            video.y = 25 ;
            
            video.attachNetStream( stream ) ;
            
            addChild(video) ;
            
            ////// 
            
            var format:TextFormat = new TextFormat("Verdana",20) ;
            
            format.align = "center" ;
            
            field = new TextField() ;
            
            field.width     = 630 ;
            field.height    = 40 ;
            //field.border    = true ;
            
            field.autoSize  = TextFieldAutoSize.LEFT ;
            field.multiline = true ;
            field.wordWrap  = true ;
            
            field.defaultTextFormat = format ;
            field.textColor         = 0xFFFFFF ;
            
            field.x =  30 ;
            field.y = 390 ; 
            
            field.filters = [ new DropShadowFilter() ] ;
            
            addChild( field ) ;
            
            /////
            
            loader = new URLLoader() ;
            
            loader.addEventListener( Event.COMPLETE , complete ) ;
            
            loader.load( new URLRequest("video.srt") ) ;
        }
        
        public var captions:Captions ;
        
        public var connection:NetConnection ;
        
        public var expert:NetStreamExpert ;
        
        public var field:TextField ;
        
        public var loader:URLLoader ;
        
        public var parser:SRTParser ;
        
        public var stream:NetStream ;
        
        public var timer:Timer ;
        
        public var video:Video ;
        
        protected function complete( e:Event ):void
        {
            parser   = new SRTParser( loader.data ) ;
            captions = new Captions( parser.eval() ) ;
            
            //logger.info( "length : " + captions.length ) ;
            //logger.wtf( "captions : " + captions ) ;
            
            /////
            
            expert.play( "video.flv" ) ;
        }
        
        protected function timerProgress( e:Event ):void
        {
            var caption:Caption = captions.find( expert.time ) ;
            field.text = caption ? caption.text : ""  ;
            DisplayObjects.align(field, video.getBounds(this) , Align.BOTTOM, new Point(0, -4)) ;
        }
    }
}
