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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.core 
{
	import lunas.core.AbstractComponent;
	
	import pegas.maths.Range;    

	/**
     * This class provides a skeletal implementation of all the <code>IProgress</code> display components, to minimize the effort required to implement this interface.
     * @author eKameleon
     */
    public class AbstractProgress extends AbstractComponent implements IProgress 
    {

        /**
         * Creates a new AbstractProgressbar instance.
         * @param id Indicates the id of the object.
         * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
         * @param name Indicates the instance name of the object.
         */
        public function AbstractProgress(id:* = null, isConfigurable:Boolean = false, name:String = null)
        {
            super( id, isConfigurable, name ) ;
        }
        
        /**
         * This flag indicates of the position is auto reset. 
         */
        public var autoResetPosition:Boolean = false ;
        
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
         * @param pos the position value of the progress bar.
         * @param noEvent (optional) this flag disabled the events of this method if this argument is <code>true</code>
         * @param flag (optional) An optional boolean flag use in the method.
         */
        public function setPosition(value:Number, noEvent:Boolean=false, flag:Boolean=false ):void
        {
            var old:Number = _position ;
            _position      = _rPercent.clamp( Range.filterNaNValue(value) ) ;
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
         * The position value of the bar.
         */
        protected var _position:Number = 0 ;
        
        /**
         * @private
         */
        private var _rPercent:Range = Range.PERCENT_RANGE ;
        
    }
}
