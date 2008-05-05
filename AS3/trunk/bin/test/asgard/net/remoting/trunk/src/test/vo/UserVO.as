
package test.vo 
{
	import flash.net.registerClassAlias;
	
	import andromeda.vo.SimpleValueObject;	

	/**
      * The user value object.
      * @author eKameleon
      */
    public class UserVO extends SimpleValueObject 
    {
		
		/**
		 * Creates a new UserVO instance.
		 * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
		 */  	
        public function UserVO( init:Object = null  )
        {
            super(init) ;
        }   
 		
 		/**
 		 * The age value of the user.
 		 */
        public var age:Number ;
        
		/**
 		 * The name value of the user.
 		 */
        public var name:String ;
        
 		/**
 		 * The url value of the user.
 		 */
        public var url:String ;
    	
        /**
         * Preserves the class (type) of an object when the object is encoded in Action Message Format (AMF). 
         */
        public static function register():void
        {
             registerClassAlias("UserVO" , UserVO) ;  
        }   
 		
 		/**
 		 * Returns the String representation of the object.
 		 * @return the String representation of the object.
 		 */
        public override function toString():String
        {
            return "[UserVO:" + name + ", age:" + this.age + ", url:" + this.url + "]"  ; 
        }
    	
    }
}

