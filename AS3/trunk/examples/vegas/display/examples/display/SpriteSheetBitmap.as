package examples.display 
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    
    [Embed(source="SpriteSheetBitmap.png")]
    
    public class SpriteSheetBitmap extends Bitmap 
    {
        public function SpriteSheetBitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
        {
            super(bitmapData, pixelSnapping, smoothing);
        }
    }
}
