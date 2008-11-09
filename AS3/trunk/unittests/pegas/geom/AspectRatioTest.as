/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package pegas.geom 
{
    import buRRRn.ASTUce.framework.TestCase;    

    public class AspectRatioTest extends TestCase 
	{

		public function AspectRatioTest( name:String = "" )
		{
			super( name );
		}
		
        public var ar:AspectRatio;
    
        public function setUp():void
        {
            ar = new AspectRatio(320,240) ;
        }
        
        public function tearDown():void
        {
            ar = undefined ;
        }
        
        public function testConstructor():void
        {
            
            assertNotNull( ar, "DIM_00_01 - constructor is null") ;
            assertTrue( ar is Dimension, "DIM_00_02 - constructor is an instance of Dimension.") ;
            
            var ar1:AspectRatio = new AspectRatio() ;
            ar1.verbose = true ;
            assertEquals( ar1.width  , 0 , "DIM_00_03_01 - constructor failed with 0 argument : " + ar1) ;
            assertEquals( ar1.height , 0 , "DIM_00_03_02 - constructor failed with 0 argument : " + ar1) ;
            
            assertEquals( ar.width  , 320, "DIM_00_03_03 - constructor failed with a Dimension argument : " + ar) ;
            assertEquals( ar.height , 240, "DIM_00_03_04 - constructor failed with a Dimension argument : " + ar) ;
            
            
        }
        


    		
    }

}
        