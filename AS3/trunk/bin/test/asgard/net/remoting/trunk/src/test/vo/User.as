
package test.vo 
{
    import flash.net.registerClassAlias;        

    /**
      * The user value object.
      * @author eKameleon
      */
    public class User 
    {
    	
        public function User( init:Object = null  )
        {
            if ( init != null )
            {
                for (var prop:String in init)
                {
                    this[prop] = init[prop] ;	
                }	
            }

        }   
 
        public var age:Number ;
        
        public var name:String ;
        
        public var url:String ;
    
        public static function register():void
        {
             registerClassAlias("User" , User) ;  
        }   
 
        public function toString():String
        {
            return "[User:" + name + ", age:" + this.age + ", url:" + this.url + "]"  ; 
        }
    	
    }
}

