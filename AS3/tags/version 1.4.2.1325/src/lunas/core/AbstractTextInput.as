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
package lunas.core 
{
    import asgard.managers.TabManager;

    import lunas.core.AbstractComponent;
    import lunas.events.ComponentEvent;

    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.events.KeyboardEvent;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.ui.Keyboard;

    /**
     * This class provides a skeletal implementation of the <code class="prettyprint">ITextInput</code> interface, to minimize the effort required to implement this interface.
     */
    public class AbstractTextInput extends AbstractComponent implements ITextInput
    {
        /**
         * Creates a new AbstractTextInput instance.
         * @param id Indicates the id of the object.
         * @param name Indicates the instance name of the object.
         */ 
        public function AbstractTextInput(id:* = null, name:String = null)
        {
            super( id, name ) ;
            textField = new TextField() ;
        }
        
        /**
         * Specifies whether extra white space (spaces, line breaks, and so on) should be removed in a TextInput control with HTML text.
         */
        public function get condenseWhite():Boolean
        {
            return _textField.condenseWhite ;
        }
        
        /**
         * @private
         */
        public function set condenseWhite(b:Boolean):void
        {
            _textField.condenseWhite = b ;
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
         * Specifies the format applied to newly inserted text, such as text entered by a user or text inserted with the replaceSelectedText() method.
         */
        public function get defaultTextFormat():TextFormat
        {
            return _textField.defaultTextFormat ;
        }
        
        /**
         * @private
         */
        public function set defaultTextFormat( format:TextFormat ):void
        {
            _textField.defaultTextFormat = format ;
        }
        
        /**
         * Indicates whether this control is used for entering passwords.
         */
        public function get displayAsPassword():Boolean
        {
            return _textField.displayAsPassword ;
        }
        
        /**
         * @private
         */
        public function set displayAsPassword(b:Boolean):void
        {
            _textField.displayAsPassword = b ;
        }
        
        /**
         * Indicates whether the user is allowed to edit the text in this control.
         */
        public function get editable():Boolean
        {
            return _editable ;
        }
        
        /**
         * @private
         */
        public function set editable( b:Boolean ):void
        {
            _editable = b ;
            viewEditableChanged() ;
        }
        
        /**
         * Specifies whether to render by using embedded font outlines.
         */
        public function get embedFonts():Boolean
        {
            return _textField.embedFonts ;
        }
        
        /**
         * @private
         */
        public function set embedFonts( b:Boolean ):void
        {
            _textField.embedFonts = b ;
        }
        
        /**
         * Specifies the text displayed by the TextInput component, including HTML markup that expresses the styles of that text.
         */
        public function get htmlText():String
        {
            return textField.htmlText ;
        }
        
        /**
         * @private
         */
        public function set htmlText( str:String ):void
        {
            textField.htmlText = str ;
            viewHTMLTextChanged() ;
        }
        
        /**
         * Horizontal scroll position.
         */
        public function get horizontalScrollPosition():Number
        {
            return _textField.scrollH ;  
        }
        
        /**
         * @private
         */
        public function set horizontalScrollPosition( position:Number ):void
        {
            _textField.scrollH = position ;  
        }
        
        /**
         * Maximum number of characters that users can enter in the text field.
         */
        public function get maxChars():int 
        { 
            return _textField.maxChars ;
        }
        
        /**
         * @private
         */
        public function set maxChars( i:int ):void 
        { 
            _textField.maxChars = i ;
        }
        
        /**
         * Maximum value of horizontalScrollPosition.
         */
        public function maxHorizontalScrollPosition ():Number
        {
            return _textField.maxScrollH ;
        }
        
        /**
         * Indicates the set of characters that a user can enter into the control.
         * <p>If the value of the restrict property is null, you can enter any character.</p>
         * <p>If the value of the restrict property is an empty string, you cannot enter any character.</p>
         * <p>This property only restricts user interaction; a script can put any text into the text field.</p>
         * <p>If the value of the restrict property is a string of characters, you may enter only characters in that string into the text field.</p>
         * <p>The default value is null.</p>
         * @see flash.text.TextField#restrict property
         */
        public function get restrict():String 
        { 
            return _textField.restrict ;
        }
        
        /**
         * @private
         */
        public function set restrict( expression:String ):void 
        { 
            _textField.restrict = expression ;
        }
        
        /**
         * Indicates whether the text field is a multiline text field. If the value is true, the text field is multiline; if the value is false, the text field is a single-line text field.
         */
        public function get multiline():Boolean 
        { 
            return _multiline ;
        }
        
        /**
         * @private
         */
        public function set multiline( b:Boolean ):void 
        { 
            _multiline = b ;
            if ( _textField )
            {
                _textField.multiline = b ;
            }
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
         * Specifies the tab ordering of objects in a SWF file.
         */
        public override function get tabIndex() : int
        {
            return _textField != null ? _textField.tabIndex : super.tabIndex ;
        }
        
        /**
         * @private
         */
        public override function set tabIndex(index : int) : void
        {
            if ( _textField != null )
            {
                _textField.tabIndex = index ;
            }
            else
            {
                super.tabIndex = index ;
            }    
        }
        
        /**
         * The tab manager of this component.
         */
        public var tabManager:TabManager = TabManager.getInstance() ;
        
        /**
         * Plain text that appears in the component.
         */        
        public function get text():String
        {
            return _textField.text ;
        }
        
        /**
         * @private
         */        
        public function set text( str:String ):void
        {
            _textField.text = str ;
            viewTextChanged() ;
        }
        
        /**
         * The internal TextField that renders the text of this TextInput.
         * Warning, if you use the setter of this virtual attribute the component is cleaned.
         */        
        public function get textField():TextField
        {
            return _textField ;
        }
        
        /**
         * @private
         */
        public function set textField( field:TextField ):void
        {
            if ( _textField != null )
            {
               _textField.removeEventListener( FocusEvent.FOCUS_IN  , focusIn  , false ) ;
               _textField.removeEventListener( FocusEvent.FOCUS_OUT , focusOut , false ) ;
               removeChild( _textField ) ;
            }
            _textField = field || new TextField() ;
            if ( _textField != null )
            {
               addChild(_textField) ;
               _textField.addEventListener( FocusEvent.FOCUS_IN  , focusIn  , false , 9999 ) ;
               _textField.addEventListener( FocusEvent.FOCUS_OUT , focusOut , false , 9999 ) ;
                viewEditableChanged() ;
            }
            update() ;
        }
        
        /**
         * A Boolean value that indicates whether the text field has word wrap. If the value of wordWrap is true, the text field has word wrap; if the value is false, the text field does not have word wrap. The default value is false.
         */
        public function get wordWrap():Boolean 
        { 
            return _wordWrap ;
        }
        
        /**
         * @private
         */
        public function set wordWrap( b:Boolean ):void 
        { 
            _wordWrap = b ;
            if ( _textField != null )
            {
                _textField.wordWrap = b ;
            }
        }
       
        /**
         * Invoked when the group property or the groupName property changed.
         * Overrides this method in concrete class.
         */
        public override function groupPolicyChanged():void 
        {
            if ( _textField == null )
            {
               return ; 
            }
            
            if ( _oldGroupName != null &&  _oldGroupName != groupName )
            {
                tabManager.remove( _oldGroupName, _textField ) ;
            }
            
            if ( groupName != null )
            {
                tabManager.insert( groupName , _textField ) ;
            }
            
        }
        
        /**
         * Invoked when the focus is in in the component textfield.
         */
        protected function focusIn( e:FocusEvent ):void
        {
            if ( stage != null )
            {
                stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown , false, 99999 ) ;
            }
        }
        
        /**
         * Invoked when the focus is out in the component textfield.
         */
        protected function focusOut( e:FocusEvent ):void
        {
            if ( stage != null )
            {
                stage.removeEventListener( KeyboardEvent.KEY_DOWN , keyDown , false ) ;
            }
        }
        
        /**
         * Invoked when the component is focused and when a key is down.
         */
        protected function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            if ( code == Keyboard.ENTER )
            {
               dispatchEvent( new ComponentEvent( ComponentEvent.ENTER ) ) ;
            }
        }
        
        /**
         * Invoked when the display is removed from the stage.
         */
        protected override function removedFromStage( e:Event = null ):void
        {
            if ( stage != null )
            {
                if ( stage.hasEventListener(KeyboardEvent.KEY_DOWN) )
                {
                    stage.removeEventListener( KeyboardEvent.KEY_DOWN , keyDown , false ) ;
                }
            }
        }
        
        /**
         * Called when the editable attributes are invoked.
         */
        protected function viewEditableChanged():void
        {
            if ( _textField != null )
            {
                _textField.selectable = enabled && editable ;
                _textField.type       = (enabled && editable) ? TextFieldType.INPUT : TextFieldType.DYNAMIC ;
            }
        }
        
        /**
         * Called when the htmlText attributes are invoked.
         */
        protected function viewHTMLTextChanged():void
        {
            // 
        }
        
        /**
         * Called when the text attributes are invoked.
         */
        protected function viewTextChanged():void
        {
            //
        }
        
        /**
         * @private
         */
        private var _data:* ;
        
        /**
         * @private
         */
        private var _editable:Boolean = true ;
        
        /**
         * @private
         */
        private var _multiline:Boolean ;
        
        /**
         * @private
         */
        private var _selected:Boolean ;
        
        /**
         * @private
         */
        protected var _textField:TextField ;
        
        /**
         * @private
         */
        private var _wordWrap:Boolean ;
    }
}
