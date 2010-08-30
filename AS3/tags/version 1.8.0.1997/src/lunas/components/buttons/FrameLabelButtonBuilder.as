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
package lunas.components.buttons 
{
    import lunas.events.ButtonEvent;
    
    import flash.display.DisplayObject;
    import flash.display.FrameLabel;
    import flash.display.MovieClip;
    import flash.events.Event;
    
    /**
     * The builder of the FrameLabelButton component.
     */
    public class FrameLabelButtonBuilder extends CoreButtonBuilder 
    {
        /**
         * Creates a new FrameLabelButtonBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function FrameLabelButtonBuilder( target:DisplayObject )
        {
            super( target );
        }
        
        /**
         * Initialize all register type of this builder.
         */
        public override function initType():void
        {
            registerType( ButtonEvent.DISABLED ) ;
            registerType( ButtonEvent.DOWN     ) ;
            registerType( ButtonEvent.OVER     ) ;
            registerType( ButtonEvent.UP       ) ;
        }
        
        /**
         * Invoked when a ButtonEvent register in this button is dispatched.
         */
        protected override function refreshState( e:Event ):void 
        {
            var type:String = e.type ;
            var states:MovieClip = (target as FrameLabelButton).states ;
            if ( states != null )
            {
                var noExistFrameLabel:Function = function( element:*, index:int, ar:Array ):Boolean
                {
                    return (element as FrameLabel).name != type ;
                } ;
                if ( !states.currentLabels.every( noExistFrameLabel , this ) )
                {
                    states.gotoAndStop( type ) ;
                }
                else
                {
                    states.gotoAndStop(1) ;
                }
            }
            super.refreshState(e) ;
        }
    }
}
