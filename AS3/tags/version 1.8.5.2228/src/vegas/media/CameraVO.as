﻿/*

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

package vegas.media 
{
    import core.dump;
    import core.reflect.getClassName;

    import vegas.vo.SimpleValueObject;

    import flash.media.Camera;
    import flash.net.registerClassAlias;

    /**
     * This value object contains all values to set a Camera object.
     */
    public class CameraVO extends SimpleValueObject 
    {
        /**
         * Creates a new CameraVO instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function CameraVO( init:Object=null )
        {
            super( init );
        }
        
        /**
         * An integer that specifies the maximum amount of bandwidth the current outgoing video feed can use, in bytes.
         */
        public var bandwidth:int ;
        
        /**
         * Specifies whether to manipulate the width, height, and frame rate if the camera does not have a native mode that meets the specified requirements. 
         * The default value is true, which means that maintaining capture size is favored; 
         * using this parameter selects the mode that most closely matches width and height values, even if doing so adversely affects performance by reducing the frame rate. 
         * To maximize frame rate at the expense of camera height and width, pass false for the favorArea parameter.
         */
        public var favorarea:Boolean = true ;
        
        /**
         * The maximum rate at which you want the camera to capture data, in frames per second.
         */
        public var fps:Number ;
        
        /**
         * The current capture height, in pixels.
         */
        public var height:int ;
        
        /**
         * An integer specifying the required level of picture quality, as determined by the amount of compression being applied to each video frame.
         */
        public var quality:int ;
        
        /**
         * A numeric value that specifies the amount of motion required to invoke the activity event.
         */
        public var motionLevel:int ; 
         
         /**
          * The number of milliseconds between the time the camera stops detecting motion and the time the activity event is invoked.
          */
        public var motionTimeout:int ;
        
        /**
         * The current capture width, in pixels.
         */
        public var width:int ;
         
         /**
          * Apply this value object in the specified Camera reference.
          */
         public function apply( camera:Camera ):void
         {
             if ( camera != null )
             {
                camera.setQuality( bandwidth , quality ) ;
                camera.setMode( width, height, fps, favorarea ) ;
                camera.setMotionLevel( motionLevel, motionTimeout ) ;
             }
         }
         
        /**
         * Preserves the class (type) of an object when the object is encoded in Action Message Format (AMF). 
         */
        public static function register( aliasName:String = "CameraVO" ):void
        {
            registerClassAlias( aliasName , CameraVO ) ;
        }
        
        /**
         * Returns the <code class="prettyprint">Object</code> representation of this object.
         * @return the <code class="prettyprint">Object</code> representation of this object.
         */
        public override function toObject():Object
        {
            var o:Object =
            {
                bandwidth     : bandwidth     ,
                favorarea     : favorarea     ,
                fps           : fps           ,
                height        : height        ,
                quality       : quality       ,
                motionLevel   : motionLevel   ,
                motionTimeout : motionTimeout ,
                width         : width
            };
            return o ;
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public override function toString():String
        {
            var str:String = "[" + getClassName(this) ;
            str += ":" + dump(toObject()) ;
            str += "]" ;
            return str ;
        }
    }
}