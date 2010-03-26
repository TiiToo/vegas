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
package lunas.groups 
{
    import lunas.Button;
    import lunas.Groupable;
    import lunas.events.ButtonEvent;
    
    /**
     * This singleton class defined all groups for the different RadioButton in the application.
     */
    public class RadioButtonGroup extends CoreGroup
    {
        /**
         * Creates a new RadioButtonGroup.
         */
        public function RadioButtonGroup () 
        {
            super() ;
        }
        
        /**
         * Returns a singleton reference of the RadioButtonGroup class.
         * @return a singleton reference of the RadioButtonGroup class.
         */
        public static function getInstance():RadioButtonGroup 
        {
            if ( _instance == null )  
            {
                _instance = new RadioButtonGroup() ;
            }
            return _instance ;
        }
        
        /**
         * Selects the passed-in IGroupable item.
         */    
        public function select( item:Groupable ):void
        {
            var button:Button = item as Button ;
            if ( button != null && ( button.toggle == false ) ) 
            {
                return ;
            }
            var name:String = button.groupName ;
            if ( groups.containsKey( name ) )
            {
                var bt:Button = groups.get(name) as Button ;
                if ( bt != button )
                {
                    bt.setSelected ( false , ButtonEvent.DESELECT )  ;
                }
            }
            groups.put( name, button ) ;
        }
        
        /**
         * Unselect the specified item in argument. 
         * This item can be a Groupable object or the String representation of the name's group to unselect.
         */
        public function unSelect( item:* ):void 
        {
            var name:String ;
            if ( item is String)
            {
                name = item ;
            }
            else if ( item is Groupable )
            {
                name = (item as Groupable).groupName ;
            }
            else
            {
                name = null ;
            }
            if ( groups.containsKey( name ) )
            {
                var cur:Button = groups.get(name) as Button ;
                if ( cur != null )
                {
                    cur.setSelected (false, true)  ;
                    groups.remove( name ) ;
                }
            }
        }
        
        /**
         * @private
         */
        private static var _instance:RadioButtonGroup ;
    }
}
