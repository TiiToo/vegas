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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package examples 
{
    import vegas.strings.UnicodeChar;
    
    import flash.display.Sprite;
    import flash.text.TextField;
    
    /**
     * Test the UnicodeChar class.
     */
    public dynamic class UnicodeCharExample extends Sprite 
    {
        public function UnicodeCharExample()
        {
            trace( "## The White space chars array." ) ;
            
            // The length of the UnicodeChar.WHITE_SPACE_CHARS array : 5
            trace ("The length of the UnicodeChar.WHITE_SPACE_CHARS array : " + UnicodeChar.WHITE_SPACE_CHARS.length) ;
            
            trace("---------") ;
            
            trace( "## Use the UnicodeChar constants." ) ;
            
            // | UnicodeChar.TAB hello world : |    hello world
            trace ("| UnicodeChar.TAB hello world : " +  "|" + UnicodeChar.TAB + "hello world" + UnicodeChar.DOUBLE_QUOTE) ;
            
            trace("---------") ;
            
            trace( "## Test if a charactere is a whitespace." ) ;
            
            // UnicodeChar.TAB isWhiteSpace : true
            trace ("UnicodeChar.TAB isWhiteSpace : " + UnicodeChar.isWhiteSpace( UnicodeChar.TAB ) ) ;
            
            trace("---------") ;
            
            trace( "## Converts a String unicode number representation in this character representation." ) ;
            
            // UnicodeChar.toChar("0040" ) : @
            trace( 'UnicodeChar.toChar("0040" ) : ' + UnicodeChar.toChar( "0040" ) ) ;
            trace( 'UnicodeChar.toCharString("0040" ) : ' + UnicodeChar.toCharString( "0040" ) ) ;
            
            trace("---------") ;
            
            trace( "## Use a UnicodeChar instance and this proxy process." ) ;
            
            var u:UnicodeChar = new UnicodeChar() ;
            
            // u.u5c0f() + u.u98fc() + u.u5f3e() + u.u0040() ) : 小飼弾@
            trace( 'u.u5c0f() + u.u98fc() + u.u5f3e() + u.u0040()) : ' + u.u5c0f() + u.u98fc() + u.u5f3e() + u.u0040() ) ;
            
            var field:TextField = getChildByName("field") as TextField ;
            if ( field )
            {
                field.text = 'u.u5c0f() + u.u98fc() + u.u5f3e() + u.u0040()) : ' + u.u5c0f() + u.u98fc() + u.u5f3e() + u.u0040() ;
            }
        }
    }
}
