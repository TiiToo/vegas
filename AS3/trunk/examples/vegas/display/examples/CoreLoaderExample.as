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
    import vegas.display.CoreLoader;
    import vegas.display.DisplayObjectCollector;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.net.URLRequest;

    /**
     * Example with the vegas.display.CoreLoader class.
     */
    public dynamic class CoreLoaderExample extends Sprite 
    {
        public function CoreLoaderExample()
        {
            stage.align      = StageAlign.TOP_LEFT ;
            stage.scaleMode  = StageScaleMode.NO_SCALE ;
            
            var loader:CoreLoader = new CoreLoader( "my_loader" ) ;
            loader.x = 25 ;
            loader.y = 25 ;
            
            addChild( loader ) ;
            
            var url:String = "library/picture.jpg" ;
            var request:URLRequest = new URLRequest( url ) ;
            
            loader.load( request ) ;
            
            trace( "DisplayObject contains 'my_loader' : " + DisplayObjectCollector.contains( "my_loader" ) ) ;
            trace( DisplayObjectCollector.get( "my_loader" ) ) ;
        }

    }
}
