﻿/*

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
