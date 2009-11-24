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

package examples 
{
    import vegas.display.CoreBitmap;
    import vegas.display.DisplayObjectCollector;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    
    /**
     * Example with the asgard.display.CoreBitmap class.
     */
    public dynamic class CoreBitmapExample extends Sprite 
    {
        public function CoreBitmapExample()
        {
            if ( stage )
            {
                stage.align      = StageAlign.TOP_LEFT ;
                stage.scaleMode  = StageScaleMode.NO_SCALE ;
            }
            
            var bmp:CoreBitmap = new CoreBitmap( "my_bitmap" ) ;
            bmp.smoothing = true ;
            bmp.x = 25 ;
            bmp.y = 25 ;
            
            bmp.bitmapData = new Picture(240,240) ;
            
            addChild( bmp ) ;
            
            trace( "DisplayObject contains 'my_bitmap' : " + DisplayObjectCollector.contains( "my_bitmap" ) ) ;
            trace( DisplayObjectCollector.get( "my_bitmap" ) ) ;
        }
    }
}
