/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.display.coverflow 
{
    import asgard.display.Background;

    import pegas.display.ReflectionBitmapData;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.IBitmapDrawable;
    import flash.geom.ColorTransform;

    /**
     * A cover thumb display.
     */
    public class Cover extends Background 
    {
        /**
         * Creates a new Cover instance.
         * @param bitmap The IBitmapDrawable (BitmapData or DisplayObject) reference to create BitmapData view of the cover.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function Cover( bitmap:IBitmapDrawable = null , init:Object = null )
        {
            lock() ;
            super() ;
            _cover  = new Bitmap() ;
            addChild( _cover ) ;
            if ( init )
            {
                for (var prop:String in init)
                {
                    this[prop] = init[prop] ;
                }
            }
            unlock() ;
            this.bitmap = bitmap ;
        }
        
        /**
         * The bitmapdata of the cover.
         */
        public function get bitmap():IBitmapDrawable
        {
            return _bitmapData ;
        }
        
        /**
         * @private
         */
        public function set bitmap( bmpd:IBitmapDrawable ):void
        {
            if ( _bitmapData != null )
            {
                _bitmapData.dispose() ;
                _cover.bitmapData = null ;
                _bitmapData       = null ;
            }
            if ( bmpd == null )
            {
                return ;
            }
            _bitmapData = new ReflectionBitmapData( bmpd , _reflectionAlpha , _reflectionRatio , _reflectionSize , _reflectionSpace ) ;
            if ( _bitmapData != null )
            {
                _cover.bitmapData = _bitmapData ;
            }
            update() ;
        }
        
        /**
         * Indicates the internal cover Bitmap reference. 
         */
        public function get cover():Bitmap
        {
            return _cover ;
        }
        
        /**
         * The level of darkness of the cover in the coverflow.
         */
        public function get darkness():Number
        {
            return _darkness ;
        }
        
        /**
         * @private
         */
        public function set darkness( value: Number ): void
        {
            _darkness                       = value ;
            _colorTransform.redMultiplier   = value ;
            _colorTransform.greenMultiplier = value ;
            _colorTransform.blueMultiplier  = value ;
            transform.colorTransform        = _colorTransform ;
        }
        
        /**
         * The CoverEntry position of the cover (use to creates a easing).
         */
        public function get position():CoverEntry
        {
            return _target;
        }
        
        /**
         * Defines the alpha value of the reflection gradient of this cover.
         */
        public function get reflectionAlpha():Number
        {
            return _reflectionAlpha ;
        }
        
        /**
         * @private
         */
        public function set reflectionAlpha( value:Number ):void
        {
            _reflectionAlpha = value ;
            if ( _bitmapData != null && !isLocked() )
            {
                bitmap = _bitmapData ;
            }
        }
        
        /**
         * Defines the ratio of the reflection gradient of this cover.
         */
        public function get reflectionRatio():Number
        {
            return _reflectionRatio ;
        }
        
        /**
         * @private
         */
        public function set reflectionRatio( value:Number ):void
        {
            _reflectionRatio = value ;
            if ( _bitmapData != null && !isLocked() )
            {
                bitmap = _bitmapData ;
            }
        }
        
        /**
         * Defines the size of the reflection of this cover.
         */
        public function get reflectionSize():Number
        {
            return _reflectionSize ;
        }
        
        /**
         * @private
         */
        public function set reflectionSize( value:Number ):void
        {
            _reflectionSize = value ;
            if ( _bitmapData != null && !isLocked() )
            {
                bitmap = _bitmapData ;
            }
        }
        
        /**
         * Defines the space between the cover and this reflect.
         */
        public function get reflectionSpace():Number
        {
            return _reflectionSpace ;
        }
        
        /**
         * @private
         */
        public function set reflectionSpace( value:Number ):void
        {
            _reflectionSpace = value ;
            if ( _bitmapData != null && !isLocked() )
            {
                bitmap = _bitmapData ;
            }
        }
        
        /**
         * Set the new easing state of this cover in the coverflow.
         * @return true if the cover easing state is changing.
         */
        public function easeSet(): Boolean
        {
            var change:Number;
            var epsilon:Number   =  .25 ;
            var complete:Boolean = true ;
            
            if( Math.abs( change = _target.x - _current.x ) > epsilon )
            {
                complete = false;
            }
            
            _current.x += change * EASE_MULT_X ;
            
            if( Math.abs( change = _target.z - _current.z ) > epsilon )
            {
                complete = false;
            }
            
            _current.z += change * EASE_MULT_Z ;
            
            if( Math.abs( change = _target.alpha - _current.alpha ) > epsilon )
            {
                complete = false;
            }
            
            _current.alpha += change * EASE_MULT_A ;
            
            x         = _current.x ;
            z         = _current.z ;
            rotationY = _current.alpha ;
            
            return complete;
        }
        
        /**
         * Transform the cover with the current position in the coverflow.
         */
        public function hardSet(): void
        {
            x         = _current.x     = _target.x     ;
            z         = _current.z     = _target.z     ;
            rotationY = _current.alpha = _target.alpha ;
        }
        
        /**
         * @private
         */
        private var _bitmapData:BitmapData ;
        
        /**
         * @private
         */
        private var _cover:Bitmap ;
        
        /**
         * @private
         */
        private const _current:CoverEntry = new CoverEntry();
        
        /**
         * @private
         */
        private var _darkness:Number;
        
        /**
         * @private
         */
        private const _target:CoverEntry = new CoverEntry();
        
        /**
         * @private
         */
        private const _colorTransform:ColorTransform = new ColorTransform() ;
        
        /**
         * @private
         */
        private var _reflectionAlpha:Number = 0.5 ;
        
        /**
         * @private
         */
        private var _reflectionRatio:Number = 0xFF ;
        
        /**
         * @private
         */
        private var _reflectionSize:Number ;
        
        /**
         * @private
         */
        private var _reflectionSpace:Number = 0 ;
        
        /**
         * @private
         */
        private static const EASE_MULT_A: Number = .14;
        
        /**
         * @private
         */
        private static const EASE_MULT_X: Number = .10;
        
        /**
         * @private
         */
        private static const EASE_MULT_Z: Number = .14;
    }
}
