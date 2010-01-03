/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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

package vegas.process.display 
{    import graphics.FillGradientStyle;
    import graphics.colors.RGB;
    import graphics.transitions.TweenArray;
    import graphics.transitions.TweenUnit;
    
    import system.events.ActionEvent;
    import system.numeric.Mathematics;
    import system.process.BatchProcess;
    import system.process.Task;
    
    import vegas.display.Background;
    
    /**
     * This process switch the fill gradient color of the specified background.     */    public class SwitchBackgroundGradientColor extends Task 
    {        /**
         * Creates a new SwitchBackgroundGradientColor instance.
         * @param background The background reference to switch.
         * @param colors The array of all colors to change in the gradient fill.
         * @param alphas The array of all alphas to change in the gradient fill.
         * @param ratios The array of all ratios to change in the gradient fill.
         * @param easing The easing equation reference.
         * @param duration A number indicating the length of time or number of frames for the tween motion.
         * @param useSeconds Indicates if the duration is in seconds.
         */
        public function SwitchBackgroundGradientColor( background:Background = null , colors:Array = null , alphas:Array = null , ratios:Array = null , easing:* = null , duration:Number = 1 , useSeconds:Boolean = true )
        {
            super() ;
                        _tweenAlphas = new TweenArray( null , null, null, 1 , true ) ;
            _tweenAlphas.addEventListener(ActionEvent.CHANGE, _change) ;
            
            _tweenColors = new TweenUnit( null , 1, true) ;
            _tweenColors.addEventListener(ActionEvent.CHANGE, _change) ;
            
            _tweenRatios = new TweenArray( null , null, null, 1 , true ) ;
            _tweenRatios.addEventListener(ActionEvent.CHANGE, _change) ;
            
            this.background = background ;
            this.alphas     = alphas     ;
            this.colors     = colors     ;
            this.ratios     = ratios     ;
            this.easing     = easing     ;
            this.duration   = duration   ;
            this.useSeconds = useSeconds ;
            
            _batch = new BatchProcess() ;
            _batch.addEventListener(ActionEvent.FINISH, _finish) ;
        }
        
        /**
         * The array of all alphas to change in the gradient fill.
         */
        public function get alphas():Array
        {
            return _tweenAlphas.finish ;
        }
        
        /**
         * @private
         */
        public function set alphas( ar:Array ):void
        {
            _tweenAlphas.finish = ar ;
        }
        
        /**
         * The background reference.
         */
        public function get background():Background
        {
            return _background ;
        }
        
        /**
         * @private
         */
        public function set background( bg:Background ):void
        {
            _background = bg ;
        }
        
        /**
         * The array of all colors to change in the gradient fill.
         */
        public var colors:Array ;
        
        /**
         * Sets the duration of the tweened animation in frames or seconds.
         */
        public function get duration():Number
        {
            return _tweenAlphas.duration ;
        }
        
        /**
         * @private
         */
        public function set duration( value:Number ):void 
        {
            _tweenAlphas.duration = value ;
            _tweenColors.duration = value ;
        }
        
        /**
         * Defines the easing method reference of this process.
         */
        public function get easing():*
        {
            return _tweenAlphas.easing ;
        }
        
        /**
         * @private
         */
        public function set easing( f:* ):void 
        {
            _tweenAlphas.easing = f ;
            _tweenColors.easing = f ;
        }
        
        /**
         * The array of all ratios to change in the gradient fill.
         */
        public function get ratios():Array
        {
            return _tweenRatios.finish ;
        }
        
        /**
         * @private
         */
        public function set ratios( ar:Array ):void
        {
            _tweenRatios.finish = ar ;
        }
        
        /**
         * Defines if the Motion used seconds or not.
         */
        public function get useSeconds():Boolean
        {
            return _tweenAlphas.useSeconds ;
        }
        
        /**
         * @private
         */
        public function set useSeconds( b:Boolean ):void 
        {
            _tweenAlphas.useSeconds = b ;
            _tweenColors.useSeconds = b ;
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            notifyStarted() ;
            
            if ( arguments.length > 0 )
            {
                if ( arguments[0] is Array )
                {
                    colors = arguments[0] as Array ;
                }
                if ( arguments[1] )
                {
                    alphas = arguments[1] as Array ;
                }
            }
            
            if ( _batch.running )
            {
                _batch.stop() ;
            }
            
            _batch.clear() ;
            
            if ( background != null )
            {
                var gradient:FillGradientStyle = background.fill as FillGradientStyle ;
                if ( gradient )
                {
                    if ( colors )
                    {
                        _originalColors = gradient.colors ;
                        _batch.addAction(_tweenColors) ;
                    }
                    if ( alphas )
                    {
                        _tweenAlphas.begin = gradient.alphas ;
                        _batch.addAction(_tweenAlphas) ;
                    }
                    if ( ratios )
                    {
                        _tweenRatios.begin = gradient.ratios ;
                        _batch.addAction(_tweenRatios) ;
                    }
                    if ( _batch.size() > 0)
                    {
                        _batch.run() ;
                        return ;
                    }
                }
            }
            notifyFinished() ;
        }
        
        /**
         * @private
         */
        private var _background:Background ;
        
        /**
         * @private
         */
        private var _batch:BatchProcess ;
        
        /**
         * @private
         */
        private var _originalColors:Array ;
        
        /**
         * @private
         */
        private var _rgb:RGB = new RGB() ;
        
        /**
         * @private
         */
        private var _tweenAlphas:TweenArray ;
        
        /**
         * @private
         */
        private var _tweenColors:TweenUnit ;
        
        /**
         * @private
         */
        private var _tweenRatios:TweenArray ;
        
        /**
         * @private
         */
        private function _change( e:ActionEvent ):void
        {
            if ( background != null )
            {
                var gradient:FillGradientStyle = background.fill as FillGradientStyle ;
                if ( alphas )
                {
                    gradient.alphas = _tweenAlphas.change ;
                }
                if ( ratios )
                {
                    gradient.ratios = _tweenRatios.change ;
                }
                if ( colors )
                {
                    var level:Number = _tweenColors.position ;
                    var l:int = _originalColors.length ;
                    for( var i:int = 0 ; i<l ; i++ )
                    {
                        gradient.colors[i] = interpolate( _originalColors[i] , colors[i] , level ) ;
                    }
                }
                background.update() ;
            }
        }
        
        /**
         * Interpolate the color and returns a new RGB object.
         * @param to The RGB reference used to interpolate the current RGB object.
         * @param level The level of the interpolation as a decimal, ﻿where <code>0</code> is the start and <code>1</code> is the end.
         * @return The interpolate RGB reference of the current color.
         */
        public function interpolate( color1:Number , color2:Number , level:Number = 1 ):Number
        {
            _rgb.fromNumber( color1 ) ;
            
            var r1:Number = _rgb.r ;
            var g1:Number = _rgb.g ;
            var b1:Number = _rgb.b ;
            
            _rgb.fromNumber( color2 ) ;
            
            var r2:Number = _rgb.r ;
            var g2:Number = _rgb.g ;
            var b2:Number = _rgb.b ;
            
            var p:Number = Mathematics.clamp( isNaN(level) ? 1 : level , 0 , 1) ;
            var q:Number = 1 - p ;
            
            _rgb.r = r1 * q + r2 * p ;
            _rgb.g = g1 * q + g2 * p ;
            _rgb.b = b1 * q + b2 * p ;  
            
            return _rgb.valueOf() ;
        }
        
        /**
         * @private
         */
        private function _finish( e:ActionEvent ):void
        {
            notifyFinished() ;
        }
    }}
