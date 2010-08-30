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
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    /**
     * A sprite sheet is a bitmapdata containing multiple images. 
     * This is useful for simple forms of sprite animation where the program cycles between different images from the sprite sheet.
     */
    public class SpriteSheet 
    {
        // TODO fix the area Rectangle
        
        /**
         * Creates a new SpriteSheet instance.
         * @param bitmapData The BitmapData reference to create the sprite sheet.
         * @param tileWidth The width of the tiles in the sprite sheet.
         * @param tileHeight The height of the tiles in the sprite sheet.
         * @param area Optional Rectangle to defines in the bitmapdata the spritesheet area. If this argument is null all the bitmapdata is used. 
         */
        public function SpriteSheet( bitmapData:BitmapData , tileWidth:Number = 0 , tileHeight:Number = 0 , area:Rectangle = null )
        {
            if ( bitmapData == null )
            {
                throw new ArgumentError( this + " constructor failed, the bitmapData argument not must be null." ) ;
            }
            _area       = area ;
            _bitmapData = bitmapData ;
            _tileHeight = tileHeight ;
            _tileWidth  = tileWidth  ;
            
            _initialize();
        }
        
        /**
         * Optional Rectangle reference to defines in the bitmapdata the spritesheet area. If this argument is null all the bitmapdata is used. 
         */
        public function get area():Rectangle
        {
            return _area ;
        }
        
        /**
         * @private
         */
        public function set area( rec:Rectangle ):void
        {
            _area = rec ;
            _initialize();
        }
        
        /**
         * The internal BitmapData reference of this SpriteSheet.
         */
        public function get bitmapData():BitmapData
        {
            return _bitmapData ;
        }
        
        /**
         * Indicates the height in pixels of the tiles in the sprite sheet.
         */
        public function get tileHeight():uint
        {
            return _tileHeight ;
        }
        
        /**
         * Indicates the width in pixels of the tiles in the sprite sheet.
         */
        public function get tileWidth():uint
        {
            return _tileWidth ;
        }
        
        /**
         * Dispose the SpriteSheet before delete it.
         */
        public function dispose():void
        {
            _bitmapData.dispose() ;
            _bitmapData = null ;
        }
        
        /**
         * Returns the sprite representation (BitmapData) at the specified index in the sprite sheet.
         * @return the sprite representation (BitmapData) at the specified index in the sprite sheet.
         */
        public function getSpriteAt( index:int ):BitmapData
        {
            _tileArea.x = int( index % _rowLength ) * _tileWidth  ;
            _tileArea.y = int( index / _rowLength ) * _tileHeight ;
            
            var sprite:BitmapData = new BitmapData( _tileWidth , _tileHeight ) ;
            
            sprite.copyPixels( _bitmapData , _tileArea , _tilePosition ) ;
            
            return sprite ;
        }
        
        /**
         * @private
         */
        protected var _area:Rectangle ;
        
        /**
         * @private
         */
        protected var _bitmapData:BitmapData ;
        
        /**
         * @private
         */
        protected var _rowLength:int;
        
        /**
         * @private
         */
        protected var _tileArea:Rectangle;
        
        /**
         * @private
         */
        protected var _tileHeight:int;
        
        /**
         * @private
         */
        protected var _tilePosition:Point;
        
        /**
         * @private
         */
        protected var _tileWidth:int;
        
        /**
         * @private
         */
        protected function _initialize():void
        {
            _rowLength    = int( _bitmapData.width / _tileWidth ) ;
            _tileArea     = new Rectangle( 0 , 0 , _tileWidth , _tileHeight ) ;
            _tilePosition = new Point(0, 0);
        }
    }
}
