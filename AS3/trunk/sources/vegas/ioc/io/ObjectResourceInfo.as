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
            if ( loader != null )
            {
                _loader = loader ; 
                _loader.addEventListener( Event.COMPLETE                    , fireEvent , false, 9999, true ) ;
                _loader.addEventListener( HTTPStatusEvent.HTTP_STATUS       , fireEvent , false, 9999, true ) ;
                _loader.addEventListener( IOErrorEvent.IO_ERROR             , fireEvent , false, 9999, true ) ;
                _loader.addEventListener( Event.OPEN                        , fireEvent , false, 9999, true ) ;
                _loader.addEventListener( ProgressEvent.PROGRESS            , notifyProgress , false, 9999, true ) ;
                _loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR , fireEvent , false, 9999, true ) ;
            }
        }
        
        /**
         * Unregisters the internal loader object.
         * @private
         */
        hack function unregisterLoader():void
        {
            if ( _loader != null )
            { 
                _loader.removeEventListener( Event.COMPLETE                    , fireEvent , false ) ;
                _loader.removeEventListener( HTTPStatusEvent.HTTP_STATUS       , fireEvent , false) ;
                _loader.removeEventListener( IOErrorEvent.IO_ERROR             , fireEvent , false) ;
                _loader.removeEventListener( Event.OPEN                        , fireEvent , false) ;
                _loader.removeEventListener( ProgressEvent.PROGRESS            , fireEvent , false) ;
                _loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , fireEvent , false) ;
                _loader = null ;
            }
        }
    }
}
