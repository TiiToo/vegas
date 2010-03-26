/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
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
package lunas 
{
    /**
     * Values for the horizontalScrollPolicy and verticalScrollPolicy properties of the Container and ScrollControlBase classes.
     */
    public class ScrollPolicy 
    {
        /**
         * Show the scrollbar if the children exceed the owner's dimension.
         * The size of the owner is not adjusted to account for the scrollbars when they appear, 
         * so this may cause the scrollbar to obscure the contents of the control or container.
         */
        public static const AUTO:String = "auto";
        
        /**
         * Never show the scrollbar.
         */
        public static const OFF:String = "off";
        
        /**
         * Always show the scrollbar.
         * The size of the scrollbar is automatically added to the size of the owner's contents 
         * to determine the size of the owner if explicit sizes are not specified.
         */
        public static const ON:String = "on";
    }
}
