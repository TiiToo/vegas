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
package lunas.display.text 
{
    import lunas.core.AbstractStyle;
    
    import pegas.draw.FillStyle;
    import pegas.draw.IFillStyle;
    import pegas.draw.ILineStyle;
    import pegas.draw.LineStyle;
    
    /**
     * The IStyle class of the SimpleTextInput component.
     */
    public class SimpleTextInputStyle extends AbstractStyle 
    {
        /**
         * Creates a new SimpleTextInputStyle instance.
         * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored.
         * @param id The id of the object.
         */
        public function SimpleTextInputStyle( init:* = null, id:* = null )
        {
            super( init , id );
        }
        
        /**
         * The default background IFillStyle of the component.
         */
        public var backgroundFill:IFillStyle = new FillStyle(0xFFFFFF,1) ;
        
        /**
         * The default background ILineStyle of the component.
         */
        public var backgroundLine:ILineStyle = new LineStyle(1,0xCCCCCC, 1) ;
        
        /**
         * Color of text in the component.
         */
        public var color:uint = 0x0B333C ;
        
        /**
         * Color of text in the component if it is disabled. The default value is 0xAAB3B3.
         */
        public var disabledColor:uint = 0xAAB3B3 ;
    }
}