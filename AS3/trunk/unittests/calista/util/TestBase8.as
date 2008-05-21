/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
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
