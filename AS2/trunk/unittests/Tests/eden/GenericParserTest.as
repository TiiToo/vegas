
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

import buRRRn.ASTUce.TestCase;

class Tests.eden.GenericParserTest extends TestCase
    {
    
    var alphaMin;
    var alphaMaj;
    var alpha;
    var digit;
    var hexAlphaMin;
    var hexAlphaMaj;
    var hexdigit;
    var octaldigit;
    var specialChars;
    var invisibleChars;
    var ASCII;
    
    function GenericParserTest( name )
        {
        super( name );
        }
    
    function setUp()
        {
        alphaMin       = "abcdefghijklmnopqrstuvwxyz";
        alphaMaj       = alphaMin.toUpperCase();
        alpha          = alphaMin + alphaMaj;
        digit          = "0123456789";
        hexAlphaMin    = "abcdef";
        hexAlphaMaj    = "ABCDEF";
        hexdigit       = digit + hexAlphaMin + hexAlphaMaj;
        octaldigit     = "01234567";
        specialChars   = " !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~";
        invisibleChars = "" ; //"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1A\x1B\x1C\x1D\x1E\x1F\x7F" ;
        ASCII          = alpha + digit + specialChars + invisibleChars;
        }
    
    function testGetCharAt()
        {
        var GP = new buRRRn.eden.GenericParser( "hello world" );
        
        assertEquals( GP.getCharAt( 0 ), "h", "GP_001" );
        }
    
    function testGetChar()
        {
        var GP = new buRRRn.eden.GenericParser( "hello world" );
    
        assertEquals( GP.getChar(), "h", "GP_002" );
        }
    
    function testNext()
        {
        var GP = new buRRRn.eden.GenericParser( "hello world" );
        
        assertEquals( GP.next(), "h", "GP_003a" );
        assertEquals( GP.next(), "e", "GP_003b" );
        assertEquals( GP.next(), "l", "GP_003c" );
        assertEquals( GP.next(), "l", "GP_003d" );
        assertEquals( GP.next(), "o", "GP_003e" );
        }
    
    function testHasMoreChar()
        {
        var GP = new buRRRn.eden.GenericParser( "hello world" );
        
        assertTrue( GP.hasMoreChar(), "GP_004a" );
        
        GP.pos = 11;
        
        assertFalse( GP.hasMoreChar(), "GP_004b" );
        }
    
    function testIsAlpha()
        {
        var GP = new buRRRn.eden.GenericParser( "" );
        var alpha = this.alpha.split();
        
        for( var i=0; i<alpha.length; i++ )
            {
            assertTrue( GP.isAlpha( alpha[i] ), "GP_005_"+alpha[i] );
            }
        }
    
    function testIsAlpha2()
        {
        var GP = new buRRRn.eden.GenericParser( "" );
        var notalpha = this.digit.split();
            notalpha = notalpha.concat( this.specialChars.split() );
            notalpha = notalpha.concat( this.invisibleChars.split() );
        
        for( var i=0; i<notalpha.length; i++ )
            {
            assertFalse( GP.isAlpha( notalpha[i] ), "GP_006_"+notalpha[i] );
            }
        }
    
    function testIsDigit()
        {
        var GP = new buRRRn.eden.GenericParser( "" );
        var digit = this.digit.split();
        
        for( var i=0; i<digit.length; i++ )
            {
            assertTrue( GP.isDigit( digit[i] ), "GP_007_"+digit[i] );
            }
        }
    
    function testIsDigit2()
        {
        var GP = new buRRRn.eden.GenericParser( "" );
        var notdigit = this.alpha.split();
            notdigit = notdigit.concat( this.specialChars.split() );
            notdigit = notdigit.concat( this.invisibleChars.split() );
        
        for( var i=0; i<notdigit.length; i++ )
            {
            assertFalse( GP.isDigit( notdigit[i] ), "GP_008_"+notdigit[i] );
            }
        }
    
    function testIsHexDigit()
        {
        var GP = new buRRRn.eden.GenericParser( "" );
        var hexdigit = this.hexdigit.split();
        
        for( var i=0; i<hexdigit.length; i++ )
            {
            assertTrue( GP.isHexDigit( hexdigit[i] ), "GP_009_"+hexdigit[i] );
            }
        }
    
    function testIsHexDigit2()
        {
        var GP = new buRRRn.eden.GenericParser( "" );
        var nothexdigit = this.alpha;
            nothexdigit = nothexdigit.replace( this.hexAlphaMin, "" );
            nothexdigit = nothexdigit.replace( this.hexAlphaMaj, "" );
            nothexdigit = nothexdigit.split();
            nothexdigit = nothexdigit.concat( this.specialChars.split() );
            nothexdigit = nothexdigit.concat( this.invisibleChars.split() );
        
        for( var i=0; i<nothexdigit.length; i++ )
            {
            assertFalse( GP.isHexDigit( nothexdigit[i] ), "GP_010_"+nothexdigit[i] );
            }
        }
    
    function testIsOctalDigit()
        {
        var GP = new buRRRn.eden.GenericParser( "" );
        var octaldigit = this.octaldigit.split();
        
        for( var i=0; i<octaldigit.length; i++ )
            {
            assertTrue( GP.isOctalDigit( octaldigit[i] ), "GP_011_"+octaldigit[i] );
            }
        }
    
    function testIsASCII()
        {
        var GP = new buRRRn.eden.GenericParser( "" );
        var ascii = this.ASCII.split();
        
        for( var i=0; i<ascii.length; i++ )
            {
            assertTrue( GP.isASCII( ascii[i] ), "GP_012_"+ascii[i] );
            }
        }
    
    function testIsUnicode()
        {
        var GP = new buRRRn.eden.GenericParser( "" );
        var unicode = [ "\u6060", "\u6061", "\u6062", "\u6063" ];
        
        for( var i=0; i<unicode.length; i++ )
            {
            assertTrue( GP.isUnicode( unicode[i] ), "GP_013_"+unicode[i] );
            }
        }
    
    }

