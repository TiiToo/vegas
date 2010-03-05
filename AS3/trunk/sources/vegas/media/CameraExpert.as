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
package vegas.media 
{
    import flash.events.ActivityEvent;
    import flash.events.StatusEvent;
    import flash.media.Camera;
    
    /**
     * This expert manage all Camera reference in the application.
     */
    public class CameraExpert extends MediaExpert 
    {
        /**
         * Creates a new CameraExpert instance.
         * @param setting The CameraVO reference to set the current Camera object.
         * @param name Specifies which camera to get, as determined from the array returned by the names property. For most applications, get the default camera by omitting this parameter.
         * @param id the id of the model.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function CameraExpert( setting:CameraVO = null , name:*=null , id:* = null , global:Boolean = false, channel:String = null )
        {
            super( id , global, channel );
            this.setting = setting || DEFAULT_SETTING ;
            setCamera(name) ;
        }
        
        /**
         * The default settings of the Camera objects.
         */
        public static var DEFAULT_SETTING:CameraVO = new CameraVO
        ({
            bandwidth     : 16384 , 
            favorarea     : true , 
            fps           : 24 , 
            height        : 120,
            motionLevel   : 50 , 
            motionTimeout : 2000 ,
            quality       : 0 , 
            width         : 160
        }) ;
         
        /**
         * Returns the Camera client reference.
         * @return the Camera client reference.
         */
        public function get camera():Camera
        {
            return _camera ;
        }
        
        /**
         * Determinates the settings of the current Camera object with a CameraVO object.
         * <p>By default the expert use the DEFAULT_SETTING
         */
        public function get setting():*
        {
            return getCurrentVO() as CameraVO ;
        }
        
        /**
         * @private
         */
        public function set setting( value:* ):void
        {
            setCurrentVO( ( value as CameraVO ) || DEFAULT_SETTING ) ;
            update() ;
        }
        
        /**
         * Sets the camera reference of the expert.
         * @param name The name of the camera to use (default null to use the default system Camera object).
         */
        public function setCamera( name:* = null ):void
        {
            if ( _camera != null )
            {
                _camera.removeEventListener( ActivityEvent.ACTIVITY , onActivity ) ;
                _camera.removeEventListener( StatusEvent.STATUS     , onStatus ) ;
            }
            _camera = Camera.getCamera( name != null ? String(name) : null ) ;
            if ( _camera != null )
            {
                _camera.addEventListener( ActivityEvent.ACTIVITY , onActivity ) ;
                _camera.addEventListener( StatusEvent.STATUS     , onStatus ) ;
                update() ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the <code class="prettyprint">IValidator</code> object validate the value. Overrides this method in your concrete IModelObject class.
         * @param value the object to test.
         * @return <code class="prettyprint">true</code> is this specific value is valid.
         */
        public override function supports( value:* ):Boolean 
        {
            return value is CameraVO ;
        }        
        
        /**
         * Updates the Camera settings.
         */
        public override function update():void
        {
            if ( camera != null && (setting as CameraVO) != null )
            {   
                (setting as CameraVO).apply( camera ) ;
            }
        }
        
        /**
         * @private
         */
        private var _camera:Camera ;
    }
}
