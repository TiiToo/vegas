/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.display 
{
    import asgard.events.FrameLabelEvent;
    
    import system.events.CoreEventDispatcher;
    import system.events.Delegate;
    
    import flash.display.FrameLabel;
    import flash.display.MovieClip;    

    /**
     * Dispatched when the inspector is in progress.
     * @eventType asgard.events.FrameLabelEvent.FRAME_LABEL
     */
    [Event(name="frameLabel", type="asgard.events.FrameLabelEvent")]

    /**
     * The TimelineProcess class use composition to dispatch action events during the MovieClip playing.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import asgard.display.TimelineInspector;
     *     import asgard.events.FrameLabelEvent;
     *     
     *     import flash.display.FrameLabel;
     *     import flash.display.MovieClip;
     *     import flash.display.Sprite;
     *     import flash.display.StageAlign;
     *     import flash.display.StageScaleMode;
     *     import flash.events.MouseEvent;
     *     import flash.utils.setTimeout;
     *     
     *     public dynamic class TestTimelineInspector extends Sprite
     *     {
     *     
     *          public function TestTimelineInspector()
     *          {
     *              // stage
     *              
     *              stage.align      = StageAlign.TOP_LEFT ;
     *              stage.scaleMode  = StageScaleMode.NO_SCALE ;
     *              
     *              // target
     *              
     *              mc               = getChildByName("mc") as MovieClip ; // MovieClip in the stage of the application
     *              mc.useHandCursor = true ;
     *              mc.buttonMode    = true ;
     *              
     *              mc.addEventListener( MouseEvent.CLICK , click ) ;
     *              
     *              trace("Click the movieclip to start the example.") ;
     *              
     *              // timeline inspector
     *              
     *              var inspector:TimelineInspector = new TimelineInspector( mc , true ) ;
     *              inspector.addEventListener( FrameLabelEvent.FRAME_LABEL , frameLabel ) ;
     *              
     *          }
     *          
     *          public var mc:MovieClip ;
     *          
     *          public function click( e:MouseEvent ):void
     *          {
     *              mc.play() ;
     *          }
     *          
     *         public function frameLabel( e:FrameLabelEvent ):void
     *         {
     *             var frame:FrameLabel = e.frameLabel ;
     *             trace( "progress :: " + frame.frame + " : " + frame.name ) ;
     *             switch( frame.name )
     *             {
     *                 case "finish" :
     *                 {
     *                     mc.stop() ;
     *                     break ;
     *                 }
     *                 case "middle" :
     *                 {
     *                     mc.stop() ;
     *                     setTimeout(mc.play, 5000) ; // pause 5 seconds
     *                     break ;
     *                 }
     *             }
     *         }
     *     }
     * }
     * </pre>
     */
    public class TimelineInspector extends CoreEventDispatcher
    {
        /**
         * Creates a new TimelineProcess instance.
         * @param target The MovieClip reference of this iterator.
         * @param autoStop This boolean flag indicates if the specified MovieClip target reference is stopped when the inspector target the MovieClip reference.
         * @throws ArgumentError If the passed-in MovieClip reference is null or undefined.
         */
        public function TimelineInspector( target:MovieClip , autoStop:Boolean = false )
        {
            if ( target == null )
            {
                throw new ArgumentError( this + " can't be instanciate with an empty MovieClip reference in argument of the constructor.") ;    
            }
            this._target = target ;
            if (autoStop)
            {
                this._target.stop() ;    
            }            
            initialize() ;
        }
        
        /**
         * Indicates the target reference of this iterator.
         */
        public function get target():MovieClip
        {
            return _target ;    
        }
        
        /**
         * Initialize all event cue point.
         */
        public function initialize():void
        {
        	var frame:int ;
        	var currentLabels:Array = _target.currentLabels ;
            for each( var element:FrameLabel in currentLabels )
            {
            	 frame = element.frame - 1 ;
                 frame = frame > 1 ? frame : 1 ;
                _target.addFrameScript( frame , Delegate.create(this, _dispatch, element ) ) ;
            }
        }
        
        /**
         * Unregisters a script function in the frame specified by the label or index value passed-in argument of the method.
         * @param index A String label name or a uint frame index value.
         */
        public function dispose():void
        {
            var currentLabels:Array = _target.currentLabels ;
            for each( var element:FrameLabel in currentLabels )
            {
                _target.addFrameScript( element.frame , null ) ;
            } 
        }
        
        /**
         * The MovieClip target of this iterator.
         */
        private var _target:MovieClip ;
        
        /**
         * Initialize all event cue point.
         */
        public function _dispatch( frame:FrameLabel ):void
        {
            dispatchEvent( new FrameLabelEvent( FrameLabelEvent.FRAME_LABEL , frame ) ) ;      
        }
    }
}
