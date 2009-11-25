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
package observer.controller
{
    import observer.display.DisplayList;
    import observer.events.PictureModelEvent;
    
    import vegas.display.Background;
    import vegas.display.DisplayObjectCollector;
    
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.net.URLRequest;
    
    /**
     * This observer of the picture display.
     */
    public class PictureController
    {
        /**
         * Creates a new PictureObserver instance.
         */
        public function PictureController()
        {
            //
        }
        
        /**
         * Invoked when the picture model notify a change.
         */
        public function change( event:PictureModelEvent ):void
        {
            if ( event == null )
            {
                trace(this + ' failed, the event not must be null.' ) ;
                return ;
            }
            var loader:Loader      = DisplayObjectCollector.get( DisplayList.LOADER  ) as Loader  ;
            switch (event.type)
            {
                case PictureModelEvent.ADD :
                {
                    trace( this + " change : " + event.type + " url:" + event.url ) ;
                    break ;
                }
                case PictureModelEvent.CLEAR :
                {
                    trace( this + " change : " + event.type ) ;
                    if ( loader )
                    {
                        loader.unload() ;
                    }
                    break ;
                }
                case PictureModelEvent.LOAD :
                {
                    trace( this + " change : " + event.type + " url:" + event.url ) ;
                    if ( loader )
                    {
                        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete) ;
                        loader.unload() ;
                        loader.load( new URLRequest( event.url ) ) ;
                    }
                    break ;
                }
                case PictureModelEvent.VISIBLE :
                {
                    trace( this + " change : " + event.type + " value:" + event.visible  ) ;
                    if ( loader )
                    {
                       loader.visible = event.visible ;
                    }
                    break ;
                }
            }
        }
        
        /**
         * @private
         */
        protected function complete(e:Event):void
        {
            var info:LoaderInfo    = e.target as LoaderInfo ;
            var loader:Loader      = info.loader ;
            var picture:Background = DisplayObjectCollector.get( DisplayList.PICTURE ) as Background  ;
            if ( loader )
            {
                loader.removeEventListener( Event.COMPLETE , complete ) ;
                if ( picture )
                {
                    loader.x = ( picture.w - loader.width  ) / 2 ;
                    loader.y = ( picture.h - loader.height ) / 2 ;
                } 
            }
        }
        
    }
}