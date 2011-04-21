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

package vegas.managers 
{
    import flash.events.Event;
    import vegas.display.Protector;
    
    import flash.display.DisplayObjectContainer;
    
    /**
     * This manager control a Protector display.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageAlign ;
     * import flash.display.StageScaleMode ;
     * 
     * import vegas.display.Protector ;
     * import vegas.managers.ProtectorManager ;
     * 
     * import graphics.FillStyle ;
     * 
     * stage.align     = StageAlign.TOP_LEFT ;
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * 
     * var protector:Protector      = new Protector() ;
     * 
     * protector.cursor = new Cursor() ;
     * protector.fill   = new FillStyle( 0xD97BD0 , 0.2 ) ;
     * 
     * var manager:ProtectorManager = new ProtectorManager( protector , this ) ;
     * 
     * manager.enabled = true ;
     * 
     * var onKeyDown:Function = function(e:KeyboardEvent):void
     * {
     *     manager.enabled = ! manager.enabled ;
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , onKeyDown ) ;
     * </pre>
     */
    public class ProtectorManager 
    {
        /**
         * Creates a new ProtectorManager instance.
         * @param protector The protector reference of this manager.
         * @param root The display list root reference to insert the protector when the protector manager is enabled.
         * @param cursorPolicy The policy of the cursor in the protector (visible or not).
         */
        public function ProtectorManager( protector:Protector = null , root:DisplayObjectContainer = null , cursorPolicy:Boolean = true )
        {
            this.protector    = protector ;
            this.root         = root      ;
        }
        
        /**
         * The optional depth to insert or remove the protector.
         */
        public var depth:Number ;
         
        /**
         * Determinates if the protector display is enabled or not.
         */
        public function get enabled():Boolean
        {
            return _enabled > 0 ;
        }
         
        /**
         * @private
         */
        public function set enabled( b:Boolean ):void
        {
            _enabled += b ? 1 : -1  ;
            if ( _enabled < 0 )
            {
                _enabled = 0 ;
            }
            if ( root && protector )
            {
                if ( enabled )
                {
                    if ( !isNaN(depth) )
                    {
                        depth = int(depth) ;
                        root.addChildAt( protector , depth ) ;
                    }
                    else
                    {
                        root.addChild( protector ) ;
                    }
                }
                else
                {
                    if ( root.contains( protector ) )
                    {
                        root.removeChild( protector ) ;
                    }
                }
            }
        }
         
        /**
         * The protector reference of the manager.
         */
        public function get protector():Protector
        {
        	return _protector ;
        }
        
        /**
         * The protector reference of the manager.
         */
        public function set protector( display:Protector ):void
        {
            if ( _protector )
            {
                _protector.removeEventListener( Event.ADDED_TO_STAGE     , addedToStage     ) ;
                _protector.removeEventListener( Event.REMOVED_FROM_STAGE , removedFromStage ) ;
            }
            _protector = display ;
            if ( _protector )
            {
                _protector.addEventListener( Event.ADDED_TO_STAGE , addedToStage         , false, 0 , true ) ;
                _protector.addEventListener( Event.REMOVED_FROM_STAGE , removedFromStage , false, 0 , true ) ;
            }
        }
        
        /**
         * The root reference of the manager.
         */
        public var root:DisplayObjectContainer ;
        
        /**
         * Resets the enabled counter and clean the manager.
         */
        public function fixEnabled():void
        {
            _enabled = -1  ;
            enabled  = true ;
        } 
         
        /**
         * @private
         */
        protected var _enabled:int ;
        
        /**
         * @private
         */
        protected var _protector:Protector ;
        
        /**
         * Invoked when the protector register in this manager is added to the stage.
         */
        protected function addedToStage( e:Event ):void 
        {
            if ( _protector )
            {
                _protector.start() ;
            }
        }
        
        /**
         * Invoked when the protector register in this manager is removed from the stage.
         */
        protected function removedFromStage( e:Event ):void 
        {
            if ( _protector )
            {
                _protector.stop() ;
            }
        }
    }
}
