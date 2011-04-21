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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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
    import vegas.media.subtitles.Caption;
    import vegas.media.subtitles.SRTParser;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="30", backgroundColor="0x333333")]
    
    public class SRTParserExample extends Sprite 
    {
        public function SRTParserExample()
        {
            var source:String = "" ;
            
            source += "1\n" ;
            
            source += "00:00:20,000 --> 00:00:24,400" ;
            source += "\r" ;
            source += "You can use a SRTParser instance \r" ;
            source += "to eval your external subtitles files.\r" ;
            source += "\n" ; 
            source += "2\r" ; 
            source += "00:00:24,600 --> 00:00:27,800\r" ; 
            source += "You must use the Array of Caption objects.\r" ;
            source += "\n" ; 
            source += "3\r" ; 
            source += "00:00:30,600 --> 00:00:35,200\r" ; 
            source += "You can creates your custom subtitle engine now." ;
             
            var parser:SRTParser = new SRTParser( source ) ;
             
            var captions:Vector.<Caption> = parser.eval() ;
             
            trace( " captions:" + captions ) ;
        }
    }
}
