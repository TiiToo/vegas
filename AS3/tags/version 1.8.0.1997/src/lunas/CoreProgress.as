/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Framework.
  
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
    import core.maths.clamp;
    import core.maths.map;

    /**
     * This class provides a skeletal implementation of all the <code class="prettyprint">IProgress</code> display components, to minimize the effort required to implement this interface.
     */
    public class CoreProgress extends CoreComponent implements Progress 
    {
        /**
         * Creates a new CoreProgress instance.
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function CoreProgress( id:* = null, isFull:Boolean=false, name:String = null )
        {
            super( id, isFull , name ) ;
        }
        
        /**
         * This flag indicates of the position is auto reset.
         */
        public var autoResetPosition:Boolean ;
        
        /**
         * The maximum value of this scrollbar.
         */
        public function get maximum():Number
        {
            return _max ;
        }
        
        /**
         * @private
         */
        public function set maximum( value:Number ):void
        {
            var tmp:Number = _max ;
            _max = value ;
            setPosition( map(position, _min, tmp, _min, _max ) ) ;
        }
        
        /**
         * The minimum value of this scrollbar.
         */
        public function get minimum():Number
        {
            return _min;
        }
        
        /**
         * @private
         */
        public function set minimum( value:Number ):void
        {
            var tmp:Number = _min ;
            _min = value ;
            setPosition( map(position, tmp, _max, _min, _max ) ) ;
        }
        
        /**
         * Indicates the position of the progress bar.
         */
        public function get position():Number 
        {
            return isNaN(_position) ? 0 : _position ;
        }
        
        /**
         * @private
         */
        public function set position( value:Number ):void
        {
            setPosition( value ) ;
        }
        
        /**
         * Sets the position of the progress bar.
         * @param value the position value of the progress bar.
         * @param noEvent (optional) this flag disabled the events of this method if this argument is <code class="prettyprint">true</code>
         * @param flag (optional) An optional boolean flag use in the method.
         */
        public function setPosition(value:Number, noEvent:Boolean=false, flag:Boolean=false ):void
        {
            var old:Number = _position ;
            _position      = clamp( isNaN(value) ? 0 : value, _min , _max ) ;
            viewPositionChanged( flag ) ;
            if (old != _position && noEvent != true ) 
            {
                notifyChanged() ;
            }
        }
        
        /**
         * Invoked when the view of the display is changed.
         */
        public override function viewChanged():void 
        {
            setPosition( ( autoResetPosition ? 0 : position ) , true, true) ;
        }
        
        /**
         * Invoked when the position of the bar is changed.
         * @param flag (optional) An optional boolean. By default this flag is passed-in the setPosition method.
         */
        public function viewPositionChanged( flag:Boolean = false ):void 
        {
            // overrides.
        }
        
        /**
         * The max value of the progress.
         */
        protected var _max:Number = 100 ;
        
        /**
         * The min value of the progress.
         */
        protected var _min:Number = 0 ;
        
        /**
         * The position value of the bar.
         */
        protected var _position:Number = 0 ;
    }
}
