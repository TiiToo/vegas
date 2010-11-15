/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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

package observer.controllers
{
    import observer.display.loader;
    import observer.display.picture;
    import observer.models.PictureMessage;

    import system.signals.Receiver;

    import flash.events.Event;
    import flash.net.URLRequest;
    
    /**
     * This observer of the picture model.
     */
    public class PictureController implements Receiver
    {
        /**
         * Creates a new PictureController instance.
         */
        public function PictureController()
        {
            //
        }
        
        /**
         * Invoked when model notify a change.
         */
        public function receive( ...values:Array ):void
        {
            var message:PictureMessage = values[0] as PictureMessage ;
            if ( message == null )
            {
                trace(this + ' failed, the sending message not must be null.' ) ;
                return ;
            }
            switch ( message.type )
            {
                case PictureMessage.ADD :
                {
                    trace( this + " change : " + message.type + " url:" + message.url ) ;
                    break ;
                }
                case PictureMessage.CLEAR :
                {
                    trace( this + " change : " + message.type ) ;
                    if ( loader )
                    {
                        loader.unload() ;
                    }
                    break ;
                }
                case PictureMessage.LOAD :
                {
                    trace( this + " change : " + message.type + " url:" + message.url ) ;
                    if ( loader )
                    {
                        if( loader.hasEventListener(Event.COMPLETE) )
                        {
                            loader.removeEventListener( Event.COMPLETE , complete ) ;
                        }
                        loader.contentLoaderInfo.addEventListener( Event.COMPLETE , complete ) ;
                        loader.unload() ;
                        loader.load( new URLRequest( message.url ) ) ;
                    }
                    break ;
                }
                case PictureMessage.VISIBLE :
                {
                    trace( this + " change : " + message.type + " value:" + message.visible  ) ;
                    if ( loader )
                    {
                       loader.visible = message.visible ;
                    }
                    break ;
                }
            }
        }
        
        /**
         * @private
         */
        protected function complete( e:Event ):void
        {
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