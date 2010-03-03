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
package lunas
{
    import flash.display.Sprite;
    import flash.events.Event;

    /**
     * This interface defines all methods to create scrollbar components.
     */
    public interface Scrollbar extends Progressbar
    {
        /**
         * The bar display of the scrollbar.
         */
        function get bar():Sprite ;
        
        /**
         * @private
         */
        function set bar( bar:Sprite ):void ;
        
        /**
         * Indicates if the layout direction of the thumb is invert.
         */
        function get invert():Boolean ;
        
        /**
         * @private
         */
        function set invert( b:Boolean ):void ;
        
        /**
         * Indicates if the bar is dragging.
         */
        function get isDragging():Boolean ; 
        
        /**
         * The thumb display of the scrollbar.
         */
        function get thumb():Sprite ;
        
        /**
         * @private
         */
        function set thumb( thumb:Sprite ):void ;
        
        /**
         * (Read-write) Determinates the size of the thumb.
         */
        function get thumbSize():Number ;
        
        /**
         * @private
         */
        function set thumbSize( value:Number ):void ;
        
        /**
         * Invoked when the bar is dragging.
         */
        function dragging( e:Event = null ):void ;
        
        /**
         * Dispatchs an event when the user drag the bar.
         */
        function notifyDrag():void ;
        
        /**
         * Dispatchs an event when the user start to drag the bar.
         */
        function notifyStartDrag():void ;
        
        /**
         * Dispatchs an event when the user stop to drag the bar.
         */
        function notifyStopDrag():void ;
        
        /**
         * Invoked when the user start to drag the bar.
         */
        function startDragging( e:Event=null ):void ; 
        
        /**
         * Invoked when the user stop to drag the bar.
         */
        function stopDragging( e:Event=null ):void ; 
    }
}
