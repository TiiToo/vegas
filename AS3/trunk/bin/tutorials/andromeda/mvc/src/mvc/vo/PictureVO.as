
package mvc.vo
{
	import andromeda.vo.SimpleValueObject;
	
	import system.Reflection;    

	/**
     * The value object a of picture element in the GalleryModel.
     * @author eKameleon
     */
    public class PictureVO extends SimpleValueObject
    {
        
        /**
         * Creates a new PictureVO instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function PictureVO( init:Object=null )
        {
            super( init ) ;
        }
        
        /**
         * The name of the picture.
         */
        public var name:String ;

        /**
         * The url of the picture.
         */
        public var url:String ;
    
        /**
          * Returns the {@code String} representation of this object.
          * @return the {@code String} representation of this object.
          */
        public override function toString():String
        {
            var str:String = "[" + Reflection.getClassName(this) ;
            if ( this.id != null )
            {
                str += " id:" + this.id ;    
            }
            if ( this.name != null )
            {
                str += " name:" + this.name ;    
            } 
            if ( this.url != null )
            {
                str += " url:" + this.url ;    
            } 
            str += "]" ;
            return str ;
        }    
    
        
    }
}