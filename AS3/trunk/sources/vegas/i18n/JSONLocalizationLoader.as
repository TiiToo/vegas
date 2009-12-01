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

package vegas.i18n
{
    import vegas.net.JSONLoader;
    
    /**
     * The JSONLocalizationLoader class based on the JSON notation.
     */
    public class JSONLocalizationLoader extends CoreLocalizationLoader
    {
        /**
         * Creates a new JSONLocalizationLoader instance.
         * @param localization The owner Localization reference of this loader.
         */
        public function JSONLocalizationLoader( localization:Localization=null )
        {
            super( localization , new JSONLoader() ) ;
            default_file_suffix = ".json" ;
        }
   }
}