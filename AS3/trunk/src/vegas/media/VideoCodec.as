/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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

package vegas.media 
{
    /**
     * The Video codec ID number enumeration class.
     * <p>More informations in the <a href='http://www.buraks.com/flvmdi/'>flvmdi page</a> write by Burak.</p>
     * @see FLVMetaData
     */
    public class VideoCodec 
    {
        /**
         * The first value of the On2 VP6 video codec. (SWF version 8 and later only)
         */
        public static const ON2_VP6_1:Number = 4 ; 
        
        /**
         * The second value of the On2 VP6 video codec. VP6 video with alpha channel (SWF version 8 and later only)
         */
        public static const ON2_VP6_2:Number = 5 ; 
        
        /**
         * Screen video (SWF version 7 and later only)
         */
        public static const SCREEN_VIDEO:Number = 3 ;
        
        /**
         * The 'Screen Video' V2 video id value.
         */
        public static const SCREEN_VIDEO_V2:Number = 6 ;
        
        /**
         * The 'Sorenson H.263' video id value.
         */
        public static const SORENSON:Number = 2 ;
            
        /**
         * Returns <code class="prettyprint">true</code> if the specified id in argument is a valid video codec.
         * @return <code class="prettyprint">true</code> if the specified id in argument is a valid video codec.
         */
        public function validate( id:Number ):Boolean
        {
            var ar:Array = [ ON2_VP6_1, ON2_VP6_2, SCREEN_VIDEO, SCREEN_VIDEO_V2 , SORENSON] ;
            return ar.indexOf( id ) > - 1 ;
        }
    }
}
