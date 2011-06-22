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

package vegas.ioc.io 
{
    import system.data.WeakReference;
    import system.events.CoreEventDispatcher;
    import system.hack;
    import system.process.CoreActionLoader;
    
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    
    /**
     * The ObjectResource info object.
     */
    public class ObjectResourceInfo extends CoreEventDispatcher 
    {
        use namespace hack ;
        
        /**
         * Creates a new ObjectResourceInfo instance.
         */
        public function ObjectResourceInfo( resource:ObjectResource = null )
        {
            this.resource = resource ;
        }
        
        /**
         * The number of bytes that are loaded for the resource.
         */
        public function get bytesLoaded():uint
        {
            return _loader != null ? _loader.bytesLoaded : 0 ;
        }
        
        /**
         * The number of compressed bytes in the entire resource file.
         */
        public function get bytesTotal():uint
        {
            return _loader != null ? _loader.bytesTotal : 0 ;
        }
        
        /**
         * The current CoreActionLoader reference.
         */
        public function get loader():CoreActionLoader
        {
            return _loader ;
        }
        
        /**
         * The current ObjectResource reference.
         */
        public function get resource():ObjectResource
        {
            return (_resource == null) ? null : (_resource.value as ObjectResource) ;
        }
        
        /**
         * @private
         */
        public function set resource( resource:ObjectResource ):void
        {
            _resource = (resource == null) ? null : new WeakReference( resource ) ;
        }
        
        /**
         * Reset the informations.
         */
        public function reset():void
        {
            _bytesLoaded = 0    ;
            _bytesTotal  = 0    ;
            _resource    = null ;
        }
        
        /**
         * @private
         */
        hack var _bytesLoaded:uint ;
        
        /**
         * @private
         */
        hack var _bytesTotal:uint ;
        
        /**
         * @private
         */
        hack var _loader:CoreActionLoader ;
        
        /**
         * @private
         */
        hack var _resource:WeakReference ;
        
        /**
         * @private
         */
        hack function fireEvent( e:Event ):void
        {
            dispatchEvent( e ) ;
        }
        
        /**
         * @private
         */
        hack function notifyProgress( e:ProgressEvent ):void
        {
            dispatchEvent( new ProgressEvent( e.type , false, false, e.bytesLoaded , e.bytesTotal ) ) ;
        }
        
        /**
         * Registers the internal loader object.
         * @private
         */
        hack function registerLoader( loader:CoreActionLoader ):void
        {
            unregisterLoader() ;
            if ( loader )
            {
                _loader = loader ; 
                _loader.loader.addEventListener( Event.COMPLETE                    , fireEvent , false, 9999, true ) ;
                _loader.loader.addEventListener( HTTPStatusEvent.HTTP_STATUS       , fireEvent , false, 9999, true ) ;
                _loader.loader.addEventListener( IOErrorEvent.IO_ERROR             , fireEvent , false, 9999, true ) ;
                _loader.loader.addEventListener( Event.OPEN                        , fireEvent , false, 9999, true ) ;
                _loader.loader.addEventListener( ProgressEvent.PROGRESS            , notifyProgress , false, 9999, true ) ;
                _loader.loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR , fireEvent , false, 9999, true ) ;
            }
        }
        
        /**
         * Unregisters the internal loader object.
         * @private
         */
        hack function unregisterLoader():void
        {
            if ( _loader )
            {
                _loader.loader.removeEventListener( Event.COMPLETE                    , fireEvent , false ) ;
                _loader.loader.removeEventListener( HTTPStatusEvent.HTTP_STATUS       , fireEvent , false) ;
                _loader.loader.removeEventListener( IOErrorEvent.IO_ERROR             , fireEvent , false) ;
                _loader.loader.removeEventListener( Event.OPEN                        , fireEvent , false) ;
                _loader.loader.removeEventListener( ProgressEvent.PROGRESS            , fireEvent , false) ;
                _loader.loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , fireEvent , false) ;
                _loader = null ;
            }
        }
    }
}
