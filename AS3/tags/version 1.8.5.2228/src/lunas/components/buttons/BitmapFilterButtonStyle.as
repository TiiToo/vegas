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
package lunas.components.buttons 
{
    import graphics.transitions.easings.Back;
    
    import lunas.CoreStyle;
    
    import flash.filters.BitmapFilter;
    
    /**
     * The style of the BitmapFilterButton component.
     */
    public class BitmapFilterButtonStyle extends CoreStyle 
    {
        /**
         * Creates a new BitmapFilterButtonStyle.
         * @param init An object that contains properties with which to populate the newly Style object. If init is not an object, it is ignored.
         * @param id The id of the object.
         */
        public function BitmapFilterButtonStyle( init:* = null , id:* = null )
        {
            super( init , id );
        }
        
        /**
         * The BitmapFilter reference.
         */
        public var filter:BitmapFilter ;
        
        /**
         * The duration of the easing.
         */
        public var filterDuration:Number = 12 ;
        
        /**
         * The easing equation used to tween the filter.
         */
        public var filterEasing:* = Back.easeOut ;
        
        /**
         * Defines the final values of the filter when the button is over.
         */
        public var filterFromOver:Object ;
        
        /**
         * Defines the final values of the filter when the button is over.
         */
        public var filterToOver:Object ;
        
        /**
         * Defines the final values of the filter when the button is selected.
         */
        public var filterFromSelected:Object ;
        
        /**
         * Defines the final values of the filter when the button is selected.
         */
        public var filterToSelected:Object ;
        
        /**
         * Indicates if the filter is tweened with an interval in seconds or fps.
         */
        public var filterUseSeconds:Boolean ;
        
        /**
         * Indicates if the button use the filter effect.
         */
        public var useFilter:Boolean = true ;
    }
}
