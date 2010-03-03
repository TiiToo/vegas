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
package lunas
{
    import system.data.Data;
    
    import flash.text.TextField;
    
    /**
     * This interface defines all methods to implement in a text input display components.
     */
    public interface TextInput extends Data, Focusable 
    {
        /**
         * Specifies whether extra white space (spaces, line breaks, and so on) should be removed in a TextInput control with HTML text.
         */
        function get condenseWhite():Boolean ;
        
        /**
         * @private
         */
        function set condenseWhite(b:Boolean):void ;
        
        /**
         * Indicates whether this control is used for entering passwords.
         */
        function get displayAsPassword():Boolean ;
        
        /**
         * @private
         */
        function set displayAsPassword(b:Boolean):void ;
        
        /**
         * Indicates whether the user is allowed to edit the text in this control.
         */
        function get editable():Boolean ;
        
        /**
         * @private
         */
        function set editable( b:Boolean ):void ;
        
        /**
         * Specifies the text displayed by the TextInput component, including HTML markup that expresses the styles of that text.
         */
        function get htmlText():String ;
        
        /**
         * @private
         */
        function set htmlText( str:String ):void ;
        
        /**
         * Maximum number of characters that users can enter in the text field.
         */
        function get maxChars():int ;
        
        /**
         * @private
         */
        function set maxChars( i:int ):void ; 
        
        /**
         * Indicates the set of characters that a user can enter into the control.
         */
        function get restrict():String ; 
        
        /**
         * @private
         */
        function set restrict( expression:String ):void ; 
        
        /**
         * Plain text that appears in the component.
         */
        function get text():String ;
        
        /**
         * @private
         */
        function set text( str:String ):void ;
        
        /**
         * The internal TextField that renders the text of this TextInput.
         */
        function get textField():TextField ;
        
        /**
         * @private
         */
        function set textField( field:TextField ):void ;
    }
}
