/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.process.display 
{
    import system.process.Task;
    
    import flash.display.DisplayObject;
    
    /**
     * This process apply filters over a DisplayObject.
     */
    public class FiltersDisplay extends Task 
    {
        /**
         * Creates a new FiltersDisplay instance.
         * @param display The DisplayObject reference.
         */
        public function FiltersDisplay( display:DisplayObject = null , filters:Array = null )
        {
            this.display = display ;
            this.filters = filters ;
        }
        
        /**
         * The DisplayObject reference.
         */
        public var display:DisplayObject ;
        
        /**
         * The filters Array representation to apply.
         */
        public var filters:Array ;
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            notifyStarted() ;
            display.filters = filters ;
            notifyFinished() ;
        }
    }
}
