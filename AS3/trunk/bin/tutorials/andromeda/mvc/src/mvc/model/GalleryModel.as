
package mvc.model
{
    import andromeda.model.map.MapModel;
    
    import mvc.vo.PictureVO;
    
    import vegas.data.iterator.Iterator;    

    /**
     * The model of the picture gallery.
     * @author eKameleon
     */
    public final class GalleryModel extends MapModel
    {
        
        /**
         * Creates a new GalleryModel instance.
         * @param id the id of this model.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel (optional) the name of the global event flow if the {@code bGlobal} argument is {@code true}.
         */
        public function GalleryModel( id:* = null , bGlobal:Boolean = false , sChannel:String = null )
        {
            super( id, bGlobal , sChannel ) ;
        }
        
        /**
         * The id name of this gallery model.
         */
        public static var GALLERY_MODEL:String = "gallery_model" ;
        
        /**
         * Clear the model.
         */
        public override function clear():void
        {
            _it = null ;
            super.clear() ;
        }
    
        /**
         * Sets the next PictureVO in the model.
         */
        public function next():void
        {
            if ( ! _it.hasNext() )
            {
                _it.reset() ;
            }
            setCurrentVO( getVO(_it.next())) ;
            _currentKey = _it.key() ;
        }

        /**
         * Sets the previous PictureVO in the model.
         */
        public function prev():void
        {
            _currentKey -- ;
            if (_currentKey < 0)
            {
                _currentKey = size() - 1 ;
            }
            _it.seek(  _currentKey  ) ;
            setCurrentVO( getVO(_it.next())) ;
        }
    
        /**
         * Reset the iterator of the Gallery.
         */
        public function reset():void
        {
            if (size() > 0)
            {
                _it = getMap().keyIterator() ;
            }
            else
            {
                _it = null ;
            }    
        }
    
        /**
         * Run the model to launch the next picture in the Picture display.
         */
        public override function run( ...arguments:Array ):void
        {
            reset() ;
            next() ;        
        }

        /**
         * Returns {@code true} if the {@code IValidator} object validate the value. Overrides this method in your concrete IModelObject class.
         * @param value the object to test.
         * @return {@code true} is this specific value is valid.
         */
        public override function supports( value:* ):Boolean 
        {
            return value is PictureVO ;
        }

        /**
         * The current key of the iterator.
         */
        private var _currentKey:Number ;
    
        /**
         * The internal iterator to show the pictures.
         */
        private var _it:Iterator ;


    }
}