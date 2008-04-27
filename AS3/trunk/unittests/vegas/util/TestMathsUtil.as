/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package vegas.util 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import vegas.errors.IllegalArgumentError;    

    /**
     * @author eKameleon
     */
    public class TestMathsUtil extends TestCase 
    {
        
        public function TestMathsUtil(name:String = "")
        {
            super( name );
        }
        
        public function testCeil():void
        {
            var result:* ;
            
            result = MathsUtil.ceil(4.572525153, 2) ;
            assertEquals( result , 4.58 , "MathsUtil.ceil(4.572525153, 2) failed" ) ;
            
            result = MathsUtil.ceil(4.572525153, 0) ;
            assertEquals( result , 5 , "MathsUtil.ceil(4.572525153, 0) failed" ) ;            
            
            result = MathsUtil.ceil(4.572525153, -1) ;
            assertEquals( result , 5 , "MathsUtil.ceil(4.572525153, -1) failed" ) ;
            
            result = MathsUtil.ceil(NaN, 0) ;
            assertEquals( result , NaN , "MathsUtil.ceil(NaN, 0) failed" ) ;
            
            result = MathsUtil.ceil(4.572525153, NaN) ;
            assertEquals( result , 5 , "MathsUtil.ceil(4.572525153, NaN) failed" ) ;
            
        }
        
        public function testClamp():void
        {
            var result:* ;
            
            result = MathsUtil.clamp(4, 5, 10) ;
            assertEquals( result , 5 , "MathsUtil.clamp(4, 5, 10) failed" ) ;
            
            result = MathsUtil.clamp(12, 5, 10) ;
            assertEquals( result , 10 , "MathsUtil.clamp(12, 5, 10) failed" ) ;
            
            result = MathsUtil.clamp(6, 5, 10) ;
            assertEquals( result , 6 , "MathsUtil.clamp(6, 5, 10) failed" ) ;
            
            result = MathsUtil.clamp(NaN, 5, 10) ;
            assertEquals( result , NaN , "MathsUtil.clamp(NaN, 5, 10) failed" ) ;    
            
        }
        
        public function testFloor():void
        {
            var result:* ;
            
            result = MathsUtil.floor(4.572525153, 2) ;
            assertEquals( result , 4.57 , "MathsUtil.floor(4.572525153, 2) failed" ) ;
            
            result = MathsUtil.floor(4.572525153, 0) ;
            assertEquals( result , 4 , "MathsUtil.floor(4.572525153, 0) failed" ) ;            
            
            result = MathsUtil.floor(4.572525153, -1) ;
            assertEquals( result , 4 , "MathsUtil.floor(4.572525153, -1) failed" ) ;
            
            result = MathsUtil.floor(NaN, 0) ;
            assertEquals( result , NaN , "MathsUtil.floor(NaN, 0) failed" ) ;
            
            result = MathsUtil.floor(4.572525153, NaN) ;
            assertEquals( result , 4 , "MathsUtil.floor(4.572525153, NaN) failed" ) ;
            
        }
        
        public function testGetPercent():void
        {
            var result:* ;
            
            result = MathsUtil.getPercent( 10, 100 ) ;
            assertEquals( result , 10 , "MathsUtil.getPercent( 10, 100 ) failed" ) ;
            
            result = MathsUtil.getPercent( 50, 100 ) ;
            assertEquals( result , 50 , "MathsUtil.getPercent( 50, 100 ) failed" ) ;            
            
            result = MathsUtil.getPercent( 68, 425 ) ;
            assertEquals( result , 16 , "MathsUtil.getPercent( 68, 425 ) failed" ) ;
            
            result = MathsUtil.getPercent( NaN, NaN ) ;
            assertEquals( result , NaN , "MathsUtil.getPercent( NaN, NaN ) failed" ) ;            

            result = MathsUtil.getPercent( NaN, 100 ) ;
            assertEquals( result , NaN , "MathsUtil.getPercent( NaN, 100 ) failed" ) ;   
            
            result = MathsUtil.getPercent( 25, NaN ) ;
            assertEquals( result , NaN , "MathsUtil.getPercent( 25, NaN ) failed" ) ;             
            
        }
        
        public function testInterpolate():void
        {
            var result:* ;
            
            result = MathsUtil.interpolate( 0.5, 0 , 100 ) ;
            assertEquals( result , 50 , "MathsUtil.interpolate( 0.5, 0 , 100 ) failed" ) ;         
                        
        }
        
        public function testMap():void
        {
            
            var result:* ;
         
            result = MathsUtil.map( 10, 0 , 100, 20, 80 ) ;
            assertEquals( result , 26 , "MathsUtil.map( 10, 0 , 100, 20, 80 ) failed" ) ; 
            
            result = MathsUtil.map( 26, 20 , 80, 0, 100 ) ;
            assertEquals( result , 10 , "MathsUtil.map( 26, 20 , 80, 0, 100 ) failed" ) ;             
            
        }          
        
        public function testNormalize():void
        {
            var result:* ;
         
            result = MathsUtil.normalize( 10, 0 , 100 ) ;
            assertEquals( result , 0.1 , "MathsUtil.normalize( 10, 0 , 100 ) failed" ) ;         
            
            result = MathsUtil.normalize( 50 , 0 , 500 ) ;
            assertEquals( result , 0.1 , "MathsUtil.normalize( 50, 0 , 500  ) failed" ) ;            

            result = MathsUtil.normalize( 100 , 0 , 500 ) ;
            assertEquals( result , 0.2 , "MathsUtil.normalize( 100 , 0 , 500  ) failed" ) ;   
            
            result = MathsUtil.normalize( 10, 25 , 100 ) ;
            assertEquals( result , -0.2 , "MathsUtil.normalize( 10, 25 , 100 ) failed" ) ;
            
            result = MathsUtil.normalize( 10, 25 , 500 ) ;
            assertEquals( result , -0.031578947368421054 , "MathsUtil.normalize( 10, 25 , 500 ) failed" ) ;
        }        
        
        public function testRound():void
        {
            var result:* ;
            
            result = MathsUtil.round(4.572525153, 2) ;
            assertEquals( result , 4.57 , "MathsUtil.round(4.572525153, 2) failed" ) ;
            
            result = MathsUtil.round(4.572525153, 0) ;
            assertEquals( result , 5 , "MathsUtil.round(4.572525153, 0) failed" ) ;            
            
            result = MathsUtil.round(4.572525153, -1) ;
            assertEquals( result , 5 , "MathsUtil.round(4.572525153, -1) failed" ) ;
            
            result = MathsUtil.round(NaN, 0) ;
            assertEquals( result , NaN , "MathsUtil.round(NaN, 0) failed" ) ;
            
            result = MathsUtil.round(4.572525153, NaN) ;
            assertEquals( result , 5 , "MathsUtil.round(4.572525153, NaN) failed" ) ;
            
        }
        
        public function testSign():void
        {
            var result:* ;
            
            result = MathsUtil.sign( 10 ) ;
            assertEquals( result , 1 , "MathsUtil.sign(10) failed" ) ;

            result = MathsUtil.sign( -10 ) ;
            assertEquals( result , -1 , "MathsUtil.sign(-10) failed" ) ;
            
            result = MathsUtil.sign( 0 ) ;
            assertEquals( result , 1 , "MathsUtil.sign(0) failed" ) ;            
            
            try
            {
                result = MathsUtil.sign( NaN ) ;
                fail( "MathsUtil.sign(NaN) failed 01." ) ;  
            }
            catch( e1:IllegalArgumentError )
            {
                //
            }
            catch( e2:Error )
            {
            	fail( "MathsUtil.sign(NaN) failed 02." ) ;  
            }
            
        }        
    }
}
