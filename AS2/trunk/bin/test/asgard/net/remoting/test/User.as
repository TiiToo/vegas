/**
 * @author ekameleon
 */

class test.User
{
	
	// ----o Constructor
	
	public function User(name:String, age:Number, url:String)
	{
		
		if ( name != null ) this.name = name ;
		if ( age > 0) this.age = age ;
		if ( url != null) this.url = url ;
		
	}	

	// -----o Public Properties
	
	public var age:Number ;
	public var name:String ;
	public var url:String ;
	
	// ----o Public Methods

	static public function register():Void
	{
	
		Object.registerClass("test.User", test.User) ;	
	
	}	

	public function toString():String
	{
		
		return "[User:" + name + ", age:" + this.age + ", url:" + this.url + "]"  ;	
		
	}
	
	// ----o Private Properties
	
	static private var __register = User.register() ;
	
}
	

