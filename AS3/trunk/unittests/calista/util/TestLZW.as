package calista.util 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import calista.util.LZW;    

    /**
     * This class test the LZW class.
     * @author eKameleon
     * @author NiKoS
     */
    public class TestLZW extends TestCase 
    {
        public function TestLZW(name : String = "")
        {
           super( name );
        }

        public function testCompress():void
        {
            var compress:String = LZW.compress( "hello world with LZW algorithm" ) ;
            assertEquals( compress ,  "hello worldąith LZW algćČhm" , "The compress method failed." ) ;        	
        }
        
        public function testDecompress():void
        {
            var decompress:String = LZW.decompress( "hello worldąith LZW algćČhm" ) ;
            assertEquals( decompress ,  "hello world with LZW algorithm" , "The decompress method failed." ) ;     
        }
    }
}
