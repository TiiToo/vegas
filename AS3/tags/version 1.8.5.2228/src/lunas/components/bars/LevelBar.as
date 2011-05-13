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
package lunas.components.bars 
{
    import core.maths.clamp;
    import core.maths.interpolate;
    import core.maths.map;
    import core.maths.normalize;
    
    import lunas.CoreProgress;
    import lunas.Progressbar;
    import lunas.events.ComponentEvent;
    
    import flash.events.Event;
    
    /**
     * This level bar is used to load and control a media (video, sound, etc.)
     */
    public class LevelBar extends CoreProgress implements Progressbar
    {
        /**
         * Creates a new LevelBar instance.
         * @param w The prefered width of the button (default 200 pixels).
         * @param h The prefered height of the button (default 10 pixels).
         */
        public function LevelBar(  w:Number = 200 , h:Number = 10 )
        {
            setSize( w , h ) ;
        }
        
        /**
         * The maximum level of the media.
         */
        public function get maximumLevel():Number
        {
            return _maxLevel ;
        }
        
        /**
         * @private
         */
        public function set maximumLevel( value:Number ):void
        {
            var tmp:Number = _maxLevel ;
            _maxLevel = value ;
            setLevel( map( level, _minLevel, tmp, _minLevel, _maxLevel ) ) ;
        }
        
        /**
         * The minimum level of the media.
         */
        public function get minimumLevel():Number
        {
            return _minLevel ;
        }
        
        /**
         * @private
         */
        public function set minimumLevel( value:Number ):void
        {
            var tmp:Number = _minLevel ;
            _minLevel = value ;
            setLevel( map( level, tmp, _maxLevel, _minLevel, _maxLevel ) ) ;
        }
        
        /**
         * Indicates the Level value of media.
         */
        public function get level():Number 
        {
            return isNaN(_level) ? 0 : _level ;
        }
        
        /**
         * @private
         */
        public function set level( value:Number ):void
        {
            setLevel( value ) ;
        }
        
        /**
         * Returns the <code class="prettyprint">Builder</code> constructor use to initialize this component.
         * @return the <code class="prettyprint">Builder</code> constructor use to initialize this component.
         */
        public override function getBuilderRenderer():Class 
        {
            return LevelBarBuilder ;
        } 
        
        /**
         * Indicates the current level of the specified LevelBar.
         */
        public function getCurrentLevel():Number
        {
            var builder:LevelBarBuilder = builder as LevelBarBuilder ;
            var style:LevelBarStyle     = style as LevelBarStyle ;
            return builder.getCurrentLevel(this, style) ;
        }
        
        /**
         * Returns the <code class="prettyprint">Style</code> constructor use to initialize this component.
         * @return the <code class="prettyprint">Style</code> constructor use to initialize this component.
         */
        public override function getStyleRenderer():Class 
        {
            return LevelBarStyle ;
        }
        
        /**
         * Sets the level value of the media.
         */
        public function setLevel( value:Number ):void
        {
            _level = clamp( ( isNaN(value) ? 0 : value ) , _minLevel , _maxLevel ) ;
            viewPositionChanged() ;
            fireComponentEvent( ComponentEvent.PROGRESS ) ;
        }
        
        /**
         * Invoked when the position of the bar is changed.
         */
        public override function viewPositionChanged( flag:Boolean = false ):void 
        {
            var uPosition:Number = normalize( _position , _min , _max ) ;
            var uLevel:Number = normalize( _level , _minLevel , _maxLevel ) ;
            if ( uLevel > uPosition )
            {
                uLevel = uPosition ;
                _level = interpolate( uLevel , _minLevel , _maxLevel ) ;
            }
            if ( builder && builder as LevelBarBuilder )
            {
                (builder as LevelBarBuilder).viewChanged() ;
            }
        }
        
        /**
         * Invoked when the component Style changed.
         */
        public override function viewStyleChanged( e:Event = null ):void 
        {
            update() ;
        }
        
        /**
         * The max level value.
         */
        protected var _maxLevel:Number = 100 ;
        
        /**
         * The min level value.
         */
        protected var _minLevel:Number = 0 ;
        
        /**
         * The internal level value.
         */
        protected var _level:Number = 0 ;
    }
}
