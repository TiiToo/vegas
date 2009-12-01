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

package vegas.process.display 
{
    import system.process.Task;
    
    import flash.display.DisplayObject;
    
    /**
     * This process hide a DisplayObject.
     */
    public class HideDisplay extends Task 
    {
        /**
         * Creates a new HideDisplay instance.
         * @param display The DisplayObject reference.
         */
        public function HideDisplay( display:DisplayObject = null )
        {
            this.display = display ;
        }
        
        /**
         * The DisplayObject reference.
         */
        public var display:DisplayObject ;
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            notifyStarted() ;
            display.visible = false ;
            notifyFinished() ;
        }
    }
}
