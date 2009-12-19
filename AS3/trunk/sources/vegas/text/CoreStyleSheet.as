/*

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

package vegas.text 
{
    import system.Reflection;
    import system.data.Identifiable;
    
    import flash.text.StyleSheet;
    
    /**
     * The CoreStyleSheet class extends the flash.text.StyleSheet.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.text.CoreTextField ;
     * import vegas.text.CoreStyleSheet ;
     * 
     * var css:String = "p{font-family:arial;font-size:14px;color:#FFFFFF}" ;
     * 
     * var field:CoreTextField = new CoreTextField( "my_field" , 150 , 22 ) ;
     * 
     * field.x = 25 ;
     * field.y = 25 ;
     * 
     * field.styleSheet  = new CoreStyleSheet( css ) ;
     * </pre>
     */
    public class CoreStyleSheet extends StyleSheet implements Identifiable
    {
        /**
         * Creates a new CoreStyleSheet instance.
         * @param source The CSS String representation to parse.
         * @param id Indicates the id of the object.
         */
        public function CoreStyleSheet( source:String=null , id:* = null )
        {
            if ( id != null )
            {
                this.id = id ;
            }
            if ( source != null )
            {
                parseCSS(source) ;
            }
        }
        
        /**
         * Returns the id of this object.
         * @return the id of this object.
         */
        public function get id():*
        {
            return _id ;
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public function set id( id:* ):void
        {
            this._id = id ;
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public override function toString():String
        {
            var str:String = "[" + Reflection.getClassName(this) ;
            if ( this.id != null )
            {
                str += " " + this.id ;
            } 
            str += "]" ;
            return str ;
        }
        
        /**
         * The internal id of this object.
         * @private
         */
        private var _id:* ;
    }
}
