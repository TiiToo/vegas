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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.core 
{
    import flash.text.TextField;
    
    import lunas.core.AbstractComponent;    

    /**
     * This class provides a skeletal implementation of the <code class="prettyprint">ITextInput</code> interface, to minimize the effort required to implement this interface.
     * @author eKameleon
     */
    public class AbstractTextInput extends AbstractComponent implements ITextInput
    {

        /**
         * Creates a new AbstractTextInput instance.
         * @param id Indicates the id of the object.
         * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
         * @param name Indicates the instance name of the object.
         */ 
        public function AbstractTextInput(id:* = null, isConfigurable:Boolean = false, name:String = null)
        {
            super( id, isConfigurable, name );
        }
        
        /**
         * Indicates the data value object of the component.
         */
        public function get data():*
        {
        	return _data ;
        }

        /**
         * @private
         */
        public function set data(value:*):void
        {
        	_data = value ;
        }        
        
        /**
         * Specifies the text displayed by the TextInput component, including HTML markup that expresses the styles of that text.
         */        
        public function get htmlText():String
        {
            return _htmlText ;
        }
        
        /**
         * @private
         */        
        public function set htmlText(str:String):void
        {
        	_htmlText = str ;
        	update() ;
        }        
        
        /**
         * A flag that indicates whether this control is selected.
         */        
        public function get selected():Boolean
        {
            return _selected ;
        }
        
        /**
         * A flag that indicates whether this control is selected.
         */        
        public function set selected(b:Boolean):void
        {
            _selected = b ;
        }           
        
        /**
         * Plain text that appears in the component.
         */        
        public function get text():String
        {
        	return _text ;
        }
        
        /**
         * @private
         */        
        public function set text(str:String):void
        {
            _text = str ;
        }        
        
        /**
         * The internal TextField that renders the text of this TextInput.
         */        
        public function get textField():TextField
        {
        	return _textField ;
        }
        
        /**
         * @private
         */        
        public function set textField(field:TextField):void
        {
        	_textField = field ;
        }
        
        /**
         * Invoked when the group property or the groupName property changed.
         */
        public override function groupPolicyChanged():void 
        {
            //
        }
        
        /**
         * Called when the text or htmlText attributes are invoked.
         */
        public function viewTextChanged():void
        {
            // overrides this method	
        }
                
        /**
         * @private
         */
        private var _data:* ;
        
        /**
         * @private
         */
        private var _htmlText:String ;
        
        /**
         * @private
         */
        private var _selected:Boolean ;
        
        /**
         * @private
         */
        private var _text:String ;

        /**
         * @private
         */
        protected var _textField:TextField ;

                 
    }
}
