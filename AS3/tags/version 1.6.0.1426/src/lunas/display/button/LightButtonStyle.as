﻿/*

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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.display.button 
{
    import graphics.transitions.TweenLite;
    import graphics.transitions.easings.Bounce;
    import graphics.transitions.easings.Elastic;
    
    import lunas.core.AbstractStyle;
    
    /**
     * The IStyle class of the LightButton component.
     */
    public class LightButtonStyle extends AbstractStyle 
    {
        /**
         * Creates a new LightButtonStyle.
         * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored. 
         * @param id The id of the object.
         */
        public function LightButtonStyle( init:* = null , id:* = null )
        {
            super( init , id ) ;
        }
        
        /**
         * The tween invoked when the button is over.
         */        
        public var tweenOver:TweenLite = new TweenLite(null, "brightness", Bounce.easeOut, 70, 0, 1, true ) ;
        
        /**
         * The tween invoked when the button is selected.
         */        
        public var tweenSelected:TweenLite = new TweenLite(null, "brightness", Elastic.easeOut, 125, 0, 1, true ) ;
    }
}
