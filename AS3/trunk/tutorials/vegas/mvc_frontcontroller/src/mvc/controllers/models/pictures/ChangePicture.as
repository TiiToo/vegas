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
package mvc.controllers.models.pictures
{
    import mvc.display.loader;
    import mvc.display.picture;
    import mvc.vo.PictureVO;
    
    import vegas.controllers.AbstractController;
    import vegas.events.ModelObjectEvent;
    
    import flash.events.Event;
    import flash.net.URLRequest;
    
    public class ChangePicture extends AbstractController
    {
        /**
         * Creates a new ChangePicture instance.
         */
        public function ChangePicture()
        {
            super();
        }
        
        /**
         * Handles the event.
         */
        public override function handleEvent(e:Event):void
        {
            var vo:PictureVO = (e as ModelObjectEvent).getVO() as PictureVO ;
            trace( this + " handleEvent : " + vo ) ;
            if ( vo != null )
            {
                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete) ;
                loader.unload() ;
                loader.load( new URLRequest( vo.url ) ) ;
            }
        }
        
        /**
         * @private
         */
        protected function complete(e:Event):void
        {
            loader.contentLoaderInfo.removeEventListener( Event.COMPLETE , complete ) ;
            loader.x = ( picture.w - loader.width  ) / 2 ;
            loader.y = ( picture.h - loader.height ) / 2 ;
        }
    }
}