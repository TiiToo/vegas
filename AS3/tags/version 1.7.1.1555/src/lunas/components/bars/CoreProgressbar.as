/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Framework.
  
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
package lunas.components.bars
{
    import lunas.CoreProgress;
    import lunas.Progressbar;
    
    /**
     * This class provides a skeletal implementation of all the <code class="prettyprint">IProgressbar</code> display components, to minimize the effort required to implement this interface.
     */
    public class CoreProgressbar extends CoreProgress implements Progressbar 
    {
        /**
         * Creates a new CoreProgressbar instance.
         * @param direction The direction value of the bar ("horizontal" or "vertical", see <code class="prettyprint">graphics.Direction</code>).
         * @param w The prefered width of the button (default 120 pixels).
         * @param h The prefered height of the button (default 20 pixels).
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function CoreProgressbar( direction:String = "horizontal", w:Number = 150 , h:Number = 6, id:* = null, isFull:Boolean=false, name:String = null )
        {
            super( id, isFull , name ) ;
            lock() ;
            this.direction = direction ;
            unlock() ;
            setSize( w , h ) ;
        }
    }
}
