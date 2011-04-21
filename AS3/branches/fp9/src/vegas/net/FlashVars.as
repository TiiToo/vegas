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

package vegas.net 
{
    import system.ioc.Parameters;
    
    import flash.display.DisplayObjectContainer;
    
    /**
     * This manager register the reference of the <code class="prettyprint">parameters</code> object of the root of your application.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package
     * { 
     *      import vegas.net.FlashVars ;
     *      
     *      import flash.display.Sprite ;
     *      
     *      // Main class of your application.
     *      public class Main extends Sprite
     *      {
     *          
     *          // constructor
     *          public function Main()
     *          {
     *              flashVars = new FlashVars( this ) ; // register the FlashVars of the application
     *              
     *              trace( flashVars.contains( "test" ) ) ; // true if the flash vars exist
     *              
     *              trace( flashVars.getValue("test") ) ; // The value of the FlashVars or null if not exist.
     *          }
     *          
     *          // The static reference of all FlashVars in the application.
     *          public static var flashVars:FlashVars ;
     *      }
     * }
     * </pre>
     */
    public class FlashVars extends Parameters
    {
        /**
         * Creates a new FlashVars instance.
         * @param root The root of the application to resolve the FlashVars generic object (in the loaderInfo.parameters in AS3 main class).
         */
        public function FlashVars( root:DisplayObjectContainer = null ):void
        {
            super ( root ? root.loaderInfo.parameters : null ) ;
        }
    }
}
