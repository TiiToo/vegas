
package  
{
    
    import vegas.core.CoreObject;
    
    /**
     * @author eKameleon
     */
    public class Test 
    {
    	
    	public function Test()
    	{
    		trace( CoreObject ) ;
    	}

		
		public function get test():String {
			return _test;
		}

		public function set test(o:String):void {
			_test = o;
		}

		protected var _test:String;

    	
    	public namespace test1 = "test1";
        
        public namespace test2 = "test2";
        
        public static function getNamespace():Namespace 
        {
        	return _nsp ;
        }
        
        public static function setNamespace( n:Namespace ):void
        {
        	_nsp = n ;
        }
        
        private static var _nsp:Namespace = test1 ; //default
    	
    	
    }
}
