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
    import andromeda.process.SimpleAction;
    
    import asgard.logging.logger;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;    

    /**
     * This process add a DisplayObject in a specific DisplayObjectContainer.
     */
    public class AddChildAt extends SimpleAction 
    {

        /**
         * Creates a new AddChildAt instance.
         * @param display The DisplayObjectContainer reference.
         * @param child The child to remove in the target.
         * @param at The index position to insert the display.
         */
        public function AddChildAt( target:DisplayObjectContainer , child:DisplayObject , at:uint )
        {
            this.target = target ;
            this.child  = child  ;
            this.at     = at     ;
        }
        
        /**
         * The index position to insert the display in the container.
         */
        public var at:uint ;
        
        /**
         * The DisplayObject reference.
         */
        public var child:DisplayObject ;        
        
        /**
         * The DisplayObject reference.
         */
        public var target:DisplayObjectContainer ;
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
        	notifyStarted() ;
        	if ( target != null && child != null && !target.contains( child ) )
        	{
        		try
        		{
                    target.addChildAt( child , at ) ;
        		}
        		catch( e:Error )
        		{
        			logger.warn(this + " run failed, " + e.toString() ) ;
        		}
        	}
            notifyFinished() ;
        }        
        
    }
}
