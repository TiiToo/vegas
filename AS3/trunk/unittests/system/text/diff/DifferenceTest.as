/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/
package system.text.diff 
{
	import buRRRn.ASTUce.framework.TestCase;
	
	import system.text.diff.Difference;			

	/**
	 * Read the http://neil.fraser.name/writing/diff/ page to understand the algo.
	 * @author eKameleon
	 */
	public class DifferenceTest extends TestCase 
	{

		public function DifferenceTest(name:String = "")
		{
			super( name );
		}
		 
        public function setUp():void
        {
            Array.prototype.toString = function():String
            {
                 return "[" + this.join(",") + "]" ;    
            };
        }
        
        public function tearDown():void
        {
            Array.prototype.toString = undefined ;
        }
		 
		// constants
		
		public function testDELETE():void
		{
		  	assertEquals( Difference.DELETE , -1  , "DELETE constant value failed." ) ;
		}
		
        public function testEQUAL():void
        {
            assertEquals( Difference.EQUAL , 0  , "EQUAL constant value failed." ) ;
        }
        
        public function testINSERT():void
        {
            assertEquals( Difference.INSERT , 1  , "INSERT constant value failed." ) ;
        }
        
        // static properties
        
        public function testDualThreshold():void
        {
            assertEquals( Difference.dualThreshold , 32  , "dualThreshold value failed." ) ;
        }
        
        public function testEditCost():void
        {
            assertEquals( Difference.editCost , 4  , "editCost value failed." ) ;
        }
		
        public function testTimeout():void
        {
            assertEquals( Difference.timeout , 1  , "timeout value failed." ) ;
        }
		
		// static methods

        public function testAddIndex():void
        {
        	// TODO fail("Test this method.") ;
        }
		
		public function testCleanupEfficiency():void
		{
            // TODO fail("Test this method.") ;
		}

        public function testCharsToLines():void
        {
            // TODO fail("Test this method.") ;
        }
        
        public function testCleanupMerge():void
        {
            // TODO fail("Test this method.") ;
        }
        
        public function testCleanupSemantic():void
        {
        	// TODO fail("Test this method.") ;
        }
        
        public function testCleanupSemanticLossless():void
        {
            // TODO fail("Test this method.") ;
        }        

        public function testCleanupSemanticScore():void
        {
            // TODO fail("Test this method.") ;
        }
        
        public function testCommonPrefix():void
        {
        	var result:* ;

            result = Difference.commonPrefix( "world" , "system" ) ; // 0 common prefix of two strings
            assertEquals( result , 0 , "commonPrefix failed with the two strings 'world' and 'system' : " + result ) ; 

            result = Difference.commonPrefix( "World" , "world" ) ; // 0 common prefix of two strings
            assertEquals( result , 0 , "commonPrefix failed with the two strings 'World' and 'world' : " + result ) ; 

            result = Difference.commonPrefix( "wOrld" , "world" ) ; // 1 common prefix of two strings
            assertEquals( result , 1 , "commonPrefix failed with the two strings 'wOrld' and 'world' : " + result ) ; 

            result = Difference.commonPrefix( "hello world" , "hello system" ) ; // 6 commons prefix of two strings
            assertEquals( result , 6 , "commonPrefix failed with the two strings 'hello world' and 'hello system' : " + result ) ; 
        }
        
        
        public function testCommonSuffix():void
        {
            var result:* ;

            result = Difference.commonSuffix( "hello" , "hi" ) ; 
            assertEquals( result , 0 , "commonSuffix failed with the two strings 'hello' and 'hi' : " + result ) ;

            result = Difference.commonSuffix( "hello worlds" , "hi worlds" ) ; 
            assertEquals( result , 7 , "commonSuffix failed with the two strings 'hello worlds' and 'hi worlds' : " + result ) ; 
        }
        
        public function testCompute():void
        {
            var diffs:* ;
            
            // easy example 
            
            diffs = Difference.compute( "hello world" , "hello system" ) ;
            assertEquals( diffs.toString() , '[[-1,w],[1,system],[-1,orld]]' , "Difference.compute('hello world', 'hello system') failed, diffs.toString() value failed." ) ;
            
            // complex 
            
            var txt1:String ;
            var txt2:String ;
            
            // fast
            
            
            
            txt1 = "I am the very model of a modern Major-General, I've information vegetable, animal, and mineral, I know the kings of England, and I quote the fights historical, From Marathon to Waterloo, in order categorical." ;
            txt2 = "I am the very model of a cartoon individual, My animation's comical, unusual, and whimsical, I'm quite adept at funny gags, comedic theory I have read, From wicked puns and stupid jokes to anvils that drop on your head." ;

            diffs = Difference.compute( txt1 , txt2 ) ;
            assertEquals
            ( 
                diffs.toString() , 
                "[[1,cart],[-1,m],[0,o],[1,o],[-1,der],[0,n ],[1,i],[-1,Major-Ge],[0,n],[1,dividu],[-1,er],[0,al, ],[1,My],[-1,I've],[0, ],[1,an],[0,i],[-1,nfor],[0,mation],[1,'s],[0, ],[1,comic],[-1,veget],[0,a],[-1,b],[0,l],[-1,e],[0,, ],[1,u],[-1,a],[0,n],[1,usu],[-1,im],[0,al, and ],[1,whi],[0,m],[1,s],[0,i],[1,c],[-1,ner],[0,al, I],[1,'m],[0, ],[1,qui],[-1,know ],[0,t],[-1,h],[0,e ],[1,adept],[-1,kings],[0, ],[1,at ],[-1,o],[0,f],[1,unny],[0, ],[-1,En],[0,g],[-1,l],[0,a],[1,gs],[-1,nd],[0,,],[-1, and I],[0, ],[-1,qu],[1,c],[0,o],[-1,t],[1,m],[0,e],[1,dic],[0, the],[1,ory I],[0, ],[-1,fig],[0,h],[-1,ts],[1,ave],[0, ],[-1,histo],[0,r],[-1,ic],[1,e],[0,a],[-1,l],[1,d],[0,, From],[1, wicked puns],[0, ],[-1,Mar],[0,a],[1,nd s],[0,t],[-1,h],[1,upid j],[0,o],[-1,n],[1,kes],[0, to],[1, anvils],[0, ],[-1,W],[1,th],[0,at],[-1,e],[1, d],[0,r],[-1,lo],[0,o],[-1,,],[1,p],[0, ],[-1,i],[1,o],[0,n ],[1,y],[0,o],[-1,rde],[1,u],[0,r ],[-1,cat],[1,h],[0,e],[-1,goric],[0,a],[-1,l],[1,d]]" , 
                "Difference.compute(txt1,txt2) failed, diffs.toString() value failed." 
            ) ;
            
        }        
        
        public function testFromDelta():void
        {
            // TODO fail("Test this method.") ;
        }
        
		public function testHalfMatch():void
		{
			var text1:String ;
			var text2:String ;
			var result:Array ;
			
            text1  = "cat in the hat" ;
            text2  = "ox in the box" ;
            result = Difference.halfMatch(text1, text2) ; // ["cat","hat","ox","box"," in the "]
            
            assertEquals( result[0] , "cat"       , "halfMatch 01 method result failed." ) ;
            assertEquals( result[1] , "hat"       , "halfMatch 02 method result failed." ) ;
            assertEquals( result[2] , "ox"        , "halfMatch 03 method result failed." ) ;
            assertEquals( result[3] , "box"       , "halfMatch 03 method result failed." ) ;
            assertEquals( result[4] , " in the "  , "halfMatch 03 method result failed." ) ;
		}
		
        public function testLinesToChars():void
        {
            var text1:String ;
            var text2:String ;
            var result:Array ;
            
            text1  = "text1" ;
            text2  = "text2" ;
            result = Difference.linesToChars(text1, text2) ;
            
            assertEquals( result[0] , "" , "linesToChars 01 method result failed." ) ;
            assertEquals( result[1] , "" , "linesToChars 02 method result failed." ) ;
            
            function isValide(element:*, index:int, arr:Array):Boolean 
            {
            	switch( index )
            	{
            		case 0 :
            		{
            			return element == '' ;
                        break ;	
            		}
                    case 1 :
                    {
                    	return element == 'text1' ;
                        break ; 
                    }
                    case 2 :
                    {
                    	return element == 'text2' ;
                        break ; 
                    }
            	}
            	return false ;
            } ;
           // assertTrue( ( result[2] as Array ).every(isValide) , "linesToChars 03 method result failed with the third element in the Array result of the function." ) ;
            
        }
        
        public function testMain():void
        {        
            var diffs:* ;

            // test - equals
            
            diffs = Difference.main("Hello world", "Hello world") ; // [[0,Hello world]]
            
            assertEquals( diffs.toString() , '[[0,Hello world]]' , "Difference.main('Hello world', 'Hello world') failed, diffs.toString() value failed." ) ;            
            
            assertEquals( diffs[0][0] , Difference.EQUAL , "Difference.main('Hello world', 'Hello world') failed, diffs[0][0] value failed." ) ;
            assertEquals( diffs[0][1] , "Hello world"    , "Difference.main('Hello world', 'Hello world') failed, diffs[0][1] failed." ) ;
            
            // test - only prefix is different
            
            diffs = Difference.main("Good dog", "Bad dog") ; // [[-1,Goo],[1,Ba],[0,d dog]]
            
            assertEquals( diffs.toString() , '[[-1,Goo],[1,Ba],[0,d dog]]' , "Difference.main('Good dog', 'Bad dog') failed, diffs.toString() value failed." ) ;
            
            assertEquals( diffs[0][0] , Difference.DELETE , "Difference.main('Good dog', 'Bad dog') failed, diffs[0][0] value failed." ) ;
            assertEquals( diffs[0][1] , "Goo"             , "Difference.main('Good dog', 'Bad dog') failed, diffs[0][1] failed." ) ;
            
            assertEquals( diffs[1][0] , Difference.INSERT , "Difference.main('Good dog', 'Bad dog') failed, diffs[1][0] value failed." ) ;
            assertEquals( diffs[1][1] , "Ba"              , "Difference.main('Good dog', 'Bad dog') failed, diffs[1][1] value failed." ) ;
            
            assertEquals( diffs[2][0] , Difference.EQUAL  , "Difference.main('Good dog', 'Bad dog') failed, diffs[2][0] value failed." ) ;
            assertEquals( diffs[2][1] , "d dog"           , "Difference.main('Good dog', 'Bad dog') failed, diffs[2][1] value failed." ) ;
           
            // test - only suffix is different
            
            diffs = Difference.main("hello world", "hello system") ; // [[0,hello ],[-1,world],[1,system]]
            
            assertEquals( diffs.toString() , '[[0,hello ],[-1,world],[1,system]]' , "Difference.main('hello world', 'hello system') failed, diffs.toString() value failed." ) ;            
            
            assertEquals( diffs[0][0] , Difference.EQUAL  , "Difference.main('hello world', 'hello system') failed, diffs[0][0] value failed." ) ;
            assertEquals( diffs[0][1] , "hello "          , "Difference.main('hello world', 'hello system') failed, diffs[0][1] failed." ) ;
            
            assertEquals( diffs[1][0] , Difference.DELETE , "Difference.main('hello world', 'hello system') failed, diffs[1][0] value failed." ) ;
            assertEquals( diffs[1][1] , "world"           , "Difference.main('hello world', 'hello system') failed, diffs[1][1] value failed." ) ;
            
            assertEquals( diffs[2][0] , Difference.INSERT , "Difference.main('hello world', 'hello system') failed, diffs[2][0] value failed." ) ;
            assertEquals( diffs[2][1] , "system"          , "Difference.main('hello world', 'hello system') failed, diffs[2][1] value failed." ) ;
           
            // test - only middle is different
            
            diffs = Difference.main("abc", "adc") ; // [[0,a],[-1,b],[1,d],[0,c]]
            
            assertEquals( diffs.toString() , '[[0,a],[-1,b],[1,d],[0,c]]' , "Difference.main('abc', 'adc') failed, diffs.toString() value failed." ) ;
            
            assertEquals( diffs[0][0] ,  Difference.EQUAL , "Difference.main('abc', 'adc') failed, diffs[0][0] value failed." ) ;
            assertEquals( diffs[0][1] ,               "a" , "Difference.main('abc', 'adc') failed, diffs[0][1] failed." ) ;
            
            assertEquals( diffs[1][0] , Difference.DELETE , "Difference.main('abc', 'adc') failed, diffs[1][0] value failed." ) ;
            assertEquals( diffs[1][1] ,               "b" , "Difference.main('abc', 'adc') failed, diffs[1][1] value failed." ) ;
            
            assertEquals( diffs[2][0] , Difference.INSERT , "Difference.main('abc', 'adc') failed, diffs[2][0] value failed." ) ;
            assertEquals( diffs[2][1] ,               "d" , "Difference.main('abc', 'adc') failed, diffs[2][1] value failed." ) ;

            assertEquals( diffs[3][0] ,  Difference.EQUAL , "Difference.main('abc', 'adc') failed, diffs[3][0] value failed." ) ;
            assertEquals( diffs[3][1] ,               "c" , "Difference.main('abc', 'adc') failed, diffs[3][1] value failed." ) ;           
           
            // test - multiple difference in a line
            
            diffs = Difference.main("Apples are a fruit.", "Bananas are also fruit.") ; // [[-1,Apple],[1,Banana],[0,s are a],[1,lso],[0, fruit.]]    

            assertEquals( diffs.toString() , '[[-1,Apple],[1,Banana],[0,s are a],[1,lso],[0, fruit.]]' , "Difference.main('Apples are a fruit.', 'Bananas are also fruit.') failed, diffs.toString() value failed." ) ;

            assertEquals( diffs[0][0] , Difference.DELETE , "Difference.main('Apples are a fruit.', 'Bananas are also fruit.') failed, diffs[0][0] value failed." ) ;
            assertEquals( diffs[0][1] ,           "Apple" , "Difference.main('Apples are a fruit.', 'Bananas are also fruit.') failed, diffs[0][1] failed." ) ;
            
            assertEquals( diffs[1][0] , Difference.INSERT , "Difference.main('Apples are a fruit.', 'Bananas are also fruit.') failed, diffs[1][0] value failed." ) ;
            assertEquals( diffs[1][1] ,          "Banana" , "Difference.main('Apples are a fruit.', 'Bananas are also fruit.') failed, diffs[1][1] value failed." ) ;
            
            assertEquals( diffs[2][0] ,  Difference.EQUAL , "Difference.main('Apples are a fruit.', 'Bananas are also fruit.') failed, diffs[2][0] value failed." ) ;
            assertEquals( diffs[2][1] ,         "s are a" , "Difference.main('Apples are a fruit.', 'Bananas are also fruit.') failed, diffs[2][1] value failed." ) ;

            assertEquals( diffs[3][0] , Difference.INSERT , "Difference.main('Apples are a fruit.', 'Bananas are also fruit.') failed, diffs[1][0] value failed." ) ;
            assertEquals( diffs[3][1] ,             "lso" , "Difference.main('Apples are a fruit.', 'Bananas are also fruit.') failed, diffs[1][1] value failed." ) ;

            assertEquals( diffs[4][0] ,  Difference.EQUAL , "Difference.main('Apples are a fruit.', 'Bananas are also fruit.') failed, diffs[3][0] value failed." ) ;
            assertEquals( diffs[4][1] ,         " fruit." , "Difference.main('Apples are a fruit.', 'Bananas are also fruit.') failed, diffs[3][1] value failed." ) ;

        }
        
        public function testMap():void
        {        
            // TODO fail("Test this method.") ;
        }
        
        public function testPrettyHtml():void
        {
        	// TODO fail("Test this method.") ;
        }   
        
        public function testText1():void
        {
            // TODO fail("Test this method.") ;
        }
        
        public function testText2():void
        {
            // TODO fail("Test this method.") ;
        }         
        
        public function testToDelta():void
        {
            // TODO fail("Test this method.") ;
        }   
        
        public function testXIndex():void
        {
            // TODO fail("Test this method.") ;
        }           
        
	}
}
