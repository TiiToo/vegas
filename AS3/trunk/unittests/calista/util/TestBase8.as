package calista.util 
{
    import buRRRn.ASTUce.framework.TestCase ;
    
    import calista.util.Base8 ;
    
    /**
     * This class test the Base8 class.
     * @author eKameleon
     * @author NiKoS
     */
    public class TestBase8 extends TestCase 
    {
        public function TestBase8(name : String = "")
        {
            super( name );
        }

        public function testDecode():void
        {
            var decode:String = Base8.decode( "68656c6c6f20776f726c64207769746820612062617365203820616c676f726974686d" ) ;
            assertEquals( decode ,  "hello world with a base 8 algorithm" , "The decode method failed." ) ;
        }        
            
        public function testEncode():void
        {
            var encode:String = Base8.encode( "hello world with a base 8 algorithm" ) ;
            assertEquals( encode ,  "68656c6c6f20776f726c64207769746820612062617365203820616c676f726974686d" , "The encode method failed." ) ;
        }        
        
    }
}
