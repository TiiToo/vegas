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

package vegas.display 
{
    import system.data.maps.HashMap;
    
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    /**
     * This container register DisplayObjects to creates a layers parallaxe effect.
     */
    public class Parallaxe
    {
        /**
         * Creates a new Parallaxe instance.
         * @param area The area Rectangle reference of the parallaxe effect.
         */
        public function Parallaxe( area:Rectangle )
        {
            _area   = area ;
            _layers = new HashMap() ;
        }
        
        /**
         * The area Rectangle to defines the limits of the parallaxe effect.
         */
        public function get area():Rectangle
        {
            return _area ;
        }
        
        /**
         * @private
         */
        public function set area( r:Rectangle ):void
        {
            _area = r ;
        }
        
        /**
         * The optional Rectange to defines the bounds of the parallaxe effect.
         */
        public var bounds:Rectangle ;
        
        /**
         * Indicates the focus position of the parallaxe.
         */
        public function get focus():Point
        {
            return _focus ;
        }
        
        /**
         * @private
         */
        public function set focus( p:Point ):void
        {
            _focus.x = p ? p.x : 0 ;
            _focus.y = p ? p.y : 0 ;
        }
        
        /**
         * Indicates the main DisplayObject of the parallaxe, this DisplayObject must be registered in the model.
         */
        public function get main():DisplayObject
        {
            return _layer != null ? _layer.target : null ;
        }
        
        /**
         * @private
         */
        public function set main( target:DisplayObject ):void
        {
            _layer = _layers.get( target ) ;
        }
        
        /**
         * The scale value of the parallaxe area (default 1).
         */
        public function get scale():Number
        {
            return _scale ;
        }
        
        /**
         * @private
         */
        public function set scale( value:Number ):void
        {
            _scale = isNaN(value) ? 1 : value ;
        }
        
        /**
         * The smoothing value of the parallaxe.
         */
        public var smoothing:Number = 10 ;
        
        /**
         * @param target The DisplayObject reference of the layer.
         * @param main Indicates if the target is the main layer of the parallaxe container.
         * @param dimension An optional Rectangle to defines a custom area size of the layer. By default the target parameter is used to defines this property.
         * @param offset The optional offset position of the layer (default [0,0]).
         * @param scaling Indicates if the layer can be scalled.
         * @return <code>true</code> if the target is a new DisplayObject, if the target is already registered this layer change only and the method return <code>false</code>. 
         */
        public function addLayer( target:DisplayObject , main:Boolean = false, dimension:Rectangle = null , offset:Point = null , scaling:Boolean = false ):Boolean
        {
            if ( target == null )
            {
                throw new ArgumentError( this + " addLayer() failed, the target argument not must be null.");
            }
            var layer:ParallaxeLayer = new ParallaxeLayer( target , dimension , offset , scaling ) ;
            var b:Boolean = _layers.put( target , layer ) == null ;
            if ( main )
            {
                _layer = layer ;
            }
            return b ;
        }
        
        /**
         * Removes all layers in the parallaxe tool.
         */
        public function clear():void
        {
            _layers.clear() ;
        }
        
        /**
         * Interpolates the parallaxe effect and update all layers (equals update(false)).
         */
        public function interpolate():void
        {
            update(false) ;
        }
        
        /**
         * Returns true if this parallaxe model is empty.
         * @return true if this parallaxe model is empty.
         */
        public function isEmpty():Boolean
        {
            return _layers.isEmpty() ;
        }
        
        /**
         * Removes the specified DisplayObject registered in the parallaxe tool (remove this layer).
         * @return <code>true</code> if the layer is removed with the specified target.
         */
        public function removeLayer( target:DisplayObject ):Boolean
        {
            return _layers.remove( target ) != null ;
        }
        
        /**
         * Indicates the numbers of layers registered in the parallaxe tool.
         */
        public function size():uint
        {
            return _layers.size() ;
        }
        
        /**
         * Updates all the layers.
         * @param now Indicates if the update is instant or if use interpolation with the smoothing value.
         */
        public function update( now:Boolean = true ):void
        {
            var s:int = size() ;
            if ( _layer == null || s == 0 )
            {
                return ; // do nothing
            }
            var i:int ;
            var layers:Array  = _layers.getValues() ;
            
            var lay:ParallaxeLayer ;
            var dis:DisplayObject ;
            var dim:Rectangle ;
            
            // updates scaling
            
            for( i = 0 ; i < s ; i++ )
            {
                lay = layers[i] as ParallaxeLayer ;
                dis = lay.target ; 
                if ( lay.scaling )
                {
                    dis.scaleX = scale ;
                    dis.scaleY = scale ;
                }
            }
            
            // initialize the layer controller
            
            _layer.tx = area.width  / 2 - _focus.x ;
            _layer.ty = area.height / 2 - _focus.y ;
            
            // initialize the screen with the bounds
            
            dim = _layer.dimension ;
            
            if ( bounds )
            {
                if( _layer.tx + bounds.left > area.left ) 
                {
                    _layer.tx = -bounds.left + area.left ;
                }
                if( _layer.tx + bounds.right < area.right ) 
                {
                    _layer.tx = -bounds.right + area.right ;
                }
                if( _layer.ty + bounds.top > area.top ) 
                {
                    _layer.ty = -bounds.top + area.top ;
                }
                if( _layer.ty + bounds.bottom < area.bottom )
                {
                    _layer.ty = -bounds.bottom + area.bottom ;
                }
            }
            else
            {
                if ( _layer.tx + dim.left > area.left) 
                {
                    _layer.tx = -dim.left + area.left;
                }
                if ( _layer.tx + dim.right < area.right) 
                {
                    _layer.tx = -dim.right + area.right;
                }
                if ( _layer.ty + dim.top > area.top) 
                {
                    _layer.ty = -dim.top + area.top;
                }
                if ( _layer.ty + dim.bottom < area.bottom) 
                {
                    _layer.ty = -dim.bottom + area.bottom;
                }
            }
            
            var dx:Number = Math.abs( ( _layer.tx - area.left ) / ( dim.width  - area.width  ) ) ;
            var dy:Number = Math.abs( ( _layer.ty - area.top  ) / ( dim.height - area.height ) ) ;
            
            var smooth:Number = now ? 1 : smoothing ;
            
            // updates layers
            
            for( i = 0 ; i < s ; i++ )
            {
                lay = layers[i] as ParallaxeLayer ;
                dim = lay.dimension ;
                dis = lay.target ;
                if ( lay != _layer )
                {
                    lay.tx = (-dx * ( dim.width  - area.width  ) + area.left) - dim.left ;
                    lay.ty = (-dy * ( dim.height - area.height ) + area.left) - dim.top  ;
                }
                dis.x += ( lay.tx - dis.x  ) / smooth ;
                dis.y += ( lay.ty - dis.y  ) / smooth ;
            }
        }
        
        /**
         * @private
         */
        private var _area:Rectangle ;
        
        /**
         * @private
         */
        private var _layer:ParallaxeLayer ;
        
        /**
         * @private
         */
        private var _focus:Point = new Point() ;
        
        /**
         * @private
         */
        private var _layers:HashMap ;
        
        /**
         * @private
         */
        public var _scale:Number = 1 ;
    }
}

