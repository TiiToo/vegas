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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
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
