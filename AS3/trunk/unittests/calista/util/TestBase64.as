package calista.util 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import calista.util.Base64;	

    /**
     * This class test the Base64 class.
     * @author eKameleon
     * @author NiKoS
     */
    public class TestBase64 extends TestCase 
    {
        
        public function TestBase64( name : String="" )
        {
            super( name );
        }
        
        public function testDecode():void
        {
            var decode:String = Base64.decode( "aGVsbG8gd29ybGQgd2l0aCBhIGJhc2UgNjQgYWxnb3JpdGht" ) ;
            assertEquals( decode ,  "hello world with a base 64 algorithm" , "The decode method failed." ) ;
        }        
            
        public function testEncode():void
        {
	 	 	var encode:String = Base64.encode( "hello world with a base 64 algorithm" ) ;
	 	 	assertEquals( encode ,  "aGVsbG8gd29ybGQgd2l0aCBhIGJhc2UgNjQgYWxnb3JpdGht" , "The encode method failed." ) ;
		}
        

    }
}