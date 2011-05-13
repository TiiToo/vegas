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
     * The Audio codec ID number enumeration class.
     * <p>More informations in the <a href='http://www.buraks.com/flvmdi/'>flvmdi page</a> write by Burak.</p>
     * @see FLVMetaData
     */
    public class AudioCodec 
    {
        /**
         * The AAC audio codec value.
         */
        public static const AAC:Number = 10 ;
        
        /**
         * The ADPCM audio codec value.
         */
        public static const ADPCM:Number = 1 ;
        
        /**
         * The MP3 audio codec value.
         */
        public static const MP3:Number = 2 ;
        
        /**
         * The NellyMoser audio codec value.
         */
        public static const NELLY_MOSER:Number = 6 ;
        
        /**
         * The Nellymoser, 8kHz mono audio codec value.
         */
        public static const NELLY_MOSER_8:Number = 5 ;
                
        /**
         * The Nellymoser @ 16 kHz mono audio codec value.
         */
        public static const NELLY_MOSER_16:Number = 4 ;
        
        /**
         * The Speex audio codec value.
         */
        public static const SPEEX:Number = 11 ;
        
        /**
         * The Uncompressed audio codec value.
         */
        public static const UNCOMPRESSED:Number = 0 ;
        
        /**
         * Returns <code class="prettyprint">true</code> if the specified id in argument is a valid audio codec.
         * @return <code class="prettyprint">true</code> if the specified id in argument is a valid audio codec.
         */
        public static function validate( id:Number ):Boolean
        {
            var ar:Array = 
            [ 
                AAC            ,
                ADPCM          , 
                MP3            ,
                NELLY_MOSER    , 
                NELLY_MOSER_8  , 
                NELLY_MOSER_16 ,
                SPEEX          ,
                UNCOMPRESSED 
            ] ;
            return ar.indexOf( id ) > -1 ;
        }
    }
}
