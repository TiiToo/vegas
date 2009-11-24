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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package examples 
{
    import vegas.display.CoreSimpleButton;
    import vegas.display.DisplayObjectCollector;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.MouseEvent;

    /**
     * Example with the asgard.display.CoreSimpleButton class.
     */
    public dynamic class CoreSimpleButtonExample extends Sprite 
    {
        public function CoreSimpleButtonExample()
        {
            stage.align      = StageAlign.TOP_LEFT ;
            stage.scaleMode  = StageScaleMode.NO_SCALE ;
            
            var button:CoreSimpleButton = new CoreSimpleButton( "my_button" , new UpState() , new OverState(), new DownState(), new HitTestState() ) ;
            
            button.x = 25  ;
            button.y = 25  ;
            
            button.addEventListener( MouseEvent.CLICK , click ) ;
            
            addChild( button ) ;
            
            trace( "DisplayObject contains 'mybutton' : " + DisplayObjectCollector.contains( "my_button" ) ) ;
            trace( DisplayObjectCollector.get( "my_button" ) ) ;
        }
        
        public function click( e:MouseEvent ):void
        {
            trace(e) ;
        }
    }
}
