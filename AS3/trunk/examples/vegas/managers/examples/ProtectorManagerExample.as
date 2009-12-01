/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package examples 
{
    import graphics.FillStyle;
    
    import vegas.display.Protector;
    import vegas.managers.ProtectorManager;
    
    import flash.display.MovieClip;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    
    public dynamic class ProtectorManagerExample extends MovieClip 
    {
        public function ProtectorManagerExample()
        {
            // stage
            
            stage.align     = StageAlign.TOP_LEFT ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            // manager
            
            var protector:Protector      = new Protector() ;
            
            protector.cursor = new Cursor() ;
            protector.fill   = new FillStyle( 0xD97BD0 , 0.2 ) ;
            
            manager = new ProtectorManager( protector , this ) ;
            
            manager.enabled = true ;
        }
        
        public var manager:ProtectorManager ;
        
        public function keyDown(e:KeyboardEvent):void
        {
            manager.enabled = ! manager.enabled ;
        }
    }
}
