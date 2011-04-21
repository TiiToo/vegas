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
package lunas 
{
    import lunas.events.StyleEvent;
    
    import system.Reflection;
    
    import vegas.config.ConfigurableObject;
    
    import flash.text.StyleSheet;
    
    /**
     * This class provides a skeletal implementation of the <code class="prettyprint">Style</code> interface, to minimize the effort required to implement this interface.
     */
    public class CoreStyle extends ConfigurableObject implements Style
    {
        /**
         * Creates a new AbstractStyle instance.
         * @param init An object that contains properties with which to populate the newly Style object. If init is not an object, it is ignored.
         * @param id The id of the object.
         */
        public function CoreStyle( init:*=null , id:*=null )
        {
            super( id ) ;
            initialize() ;
            if ( init )
            {        
                for (var prop:String in init) 
                {
                    this[prop] = init[prop] ;
                }
            }
            update() ;
        }
        
        /**
         * Indicates the style sheet reference of this object.
         */
        public function get styleSheet():StyleSheet
        {
            return _ss ;
        }
        
        /**
         * @private
         */
        public function set styleSheet( ss:StyleSheet ):void
        {
            _ss = ss ;
            styleSheetChanged() ;
            dispatchEvent( new StyleEvent( StyleEvent.STYLE_SHEET_CHANGE , this ) ) ;
        }
        
        /**
         * Returns the value of the specified property if it's exist in the object, else returns null.
         * @return the value of the specified property if it's exist in the object or <code class="prettyprint">null</code>.
         */
        public function getStyle(prop:String):*
        {
            if ( prop in this )
            {
                return this[prop] ;
            }
            else
            {
                return null ;
            }
        }
        
        /**
         * Invoked in the constructor of the <code class="prettyprint">IStyle</code> instance.
         */
        public function initialize():void
        {
            // overrides this method.
        }
        
        /**
         * Invoked when the style is changed.
         */
        public function notifyStyleChanged():void
        {
            styleChanged() ;
            dispatchEvent( new StyleEvent( StyleEvent.STYLE_CHANGE , this ) ) ;
        }
        
        /**
         * This method is invoked to change a style attribute in this IStyle object with a generic object or a key(String)/value pair of arguments.
         */
        public function setStyle( ...args:Array ):void
        {
            if ( args.length == 0 ) 
            {
                return ;
            } 
            if ( args[0] is String && args.length == 2 ) 
            {
                if ( args[0] in this ) 
                {
                    this[ args[0] ] = args[1] ;
                    notifyStyleChanged() ;
                }
            }
            else if ( args[0] is Object ) 
            {
                var prop:* = args[0] ;
                for (var i:String in prop) 
                {
                    this[i] = prop[i] ;
                }
                notifyStyleChanged() ;
            }
        }
        
        /**
         * Invoked when this object when the ConfigCollector is run.
         */
        public override function setup():void
        {
            super.setup() ;
            notifyStyleChanged() ;
        }
        
        /**
         * Invoked when a style property of this <code class="prettyprint">IStyle</code> change.
         * By default this method is empty, you can override this method.
         */
        public function styleChanged():void 
        {
            // override
        }
        
        /**
         * Invoked when the styleSheet value of this <code class="prettyprint">IStyle</code> change.
         * By default this method is empty, you can override this method.
         */
        public function styleSheetChanged():void 
        {
            // override
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public function toString():String
        {
            var str:String = "[" + Reflection.getClassName(this) ;
            if ( id != null )
            {
                str += " " + id ;
            } 
            str += "]" ;
            return str ;
        }
        
        /**
         * @private
         */
        private var _ss:StyleSheet ;
        
        /**
         * Sets the id of the object and register it in the StyleCollector if it's possible.
         * @see StyleCollector.
         */
        protected override function _setID( id:* ):void 
        {
            if ( StyleCollector.contains( this.id ) )
            {
                StyleCollector.remove( this.id ) ;
            }
            super._setID( id ) ;
            if ( this.id != null )
            {
                StyleCollector.insert ( this.id, this ) ;
            }
        }
    }
}
