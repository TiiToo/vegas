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
    import flash.text.TextFieldAutoSize;
    import graphics.Direction;
    import graphics.geom.EdgeMetrics;

    import lunas.containers.ListContainer;
    import lunas.events.ButtonEvent;

    import flash.display.DisplayObject;
    import flash.events.IEventDispatcher;
    import flash.events.MouseEvent;

    /**
     * The builder of the ItemButton component.
     */
    public class ItemButtonBuilder extends IconButtonBuilder 
    {
        /**
         * Creates a new ItemButtonBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function ItemButtonBuilder( target:DisplayObject )
        {
            super(target);
        }
        
        /**
         * The picture container reference of the component.
         */
        public var iconContainer:ListContainer ;
        
        /**
         * The light picture delete button reference of the component.
         */
        public var deleteIcon:LightButton ;
        
        /**
         * The light picture option button reference of the component.
         */
        public var optionIcon:LightButton ; 
        
        /**
         * Attach the DisplayObject view of the delete button.
         */
        public function attachDeleteButton( state:DisplayObject ):void
        {
            if( _deleteDisplay != null ) 
            {
                iconContainer.removeChild(_deleteDisplay) ;
                deleteIcon.target = null ;
            }
            _deleteDisplay = state ;
            if( _deleteDisplay != null ) 
            {
                deleteIcon.target = _deleteDisplay ;
                deleteIcon.addChild(_deleteDisplay) ;
            }
            ( target as ItemButton ).update() ;
        }
        
        /**
         * Attach the DisplayObject view of the delete button.
         */
        public function attachOptionButton( state:DisplayObject ):void
        {
            if( _optionDisplay != null ) 
            {
                iconContainer.removeChild(_optionDisplay) ;
                optionIcon.target = null ;
            }
            _optionDisplay = state ;
            if( _optionDisplay != null ) 
            {
                optionIcon.target = _optionDisplay ;
                optionIcon.addChild(_optionDisplay) ;
            }
            ( target as ItemButton ).update() ;
        }
        
        /**
         * Clear the view of the component.
         */
        public override function clear():void 
        {
            super.clear() ; 
            if ( iconContainer != null && iconContainer.childCount )
            {
                iconContainer.clear() ;
                iconContainer = null ;
            }
            deleteIcon = null ;
            optionIcon = null ;
            _deleteDisplay = null ;
            _optionDisplay = null ;
        }
        
        /**
         * Invoked when the button is disabled.
         */
        public override function disabled( e:ButtonEvent = null ):void
        {
            super.disabled(e) ;
            deleteIcon.enabled = false ;
            optionIcon.enabled = false ;
        }
        
        /**
         * Runs the build of the component.
         */
        public override function run(...arguments:Array):void
        {
            super.run() ;
            
            var t:ItemButton = target as ItemButton ;
            
            iconContainer = new ListContainer() ;
            iconContainer.direction = Direction.HORIZONTAL ;
            
            deleteIcon = new LightButton ;
            deleteIcon.addEventListener( MouseEvent.MOUSE_DOWN , _stopImmediatePropagation ) ;
            deleteIcon.addEventListener( MouseEvent.CLICK      , deleteClick ) ;
            
            optionIcon = new LightButton ;
            optionIcon.addEventListener( MouseEvent.MOUSE_DOWN , _stopImmediatePropagation ) ;
            optionIcon.addEventListener( MouseEvent.CLICK, optionClick ) ;
            
            t.addChild(iconContainer) ;
            iconContainer.addChild(optionIcon) ;
            iconContainer.addChild(deleteIcon) ;
            
            t.registerView(background) ;
        }
        
        /**
         * Update the view of the component.
         */
        public override function update():void 
        {
            refreshIconContainer() ;
            
            super.update() ;
            
            // TODO fix with autoSize ???
            
            var b:ItemButton      = target as ItemButton ;    
            var s:ItemButtonStyle = b.style as ItemButtonStyle ;
            
            var mb:Number = 0 ;
            var ml:Number = 0 ;
            var mr:Number = 0 ;
            var mt:Number = 0 ;
            
            var pb:Number = 0 ;
            var pl:Number = 0 ;
            var pr:Number = 0 ;
            var pt:Number = 0 ;
            
            if ( s.margin )
            {
                mb = EdgeMetrics.filterNaNValue( s.margin.bottom ) ;
                ml = EdgeMetrics.filterNaNValue( s.margin.left   ) ;
                mr = EdgeMetrics.filterNaNValue( s.margin.right  ) ;
                mt = EdgeMetrics.filterNaNValue( s.margin.top    ) ;
            }
            
            if ( s.padding )
            {
                pb = EdgeMetrics.filterNaNValue( s.padding.bottom ) ;
                pl = EdgeMetrics.filterNaNValue( s.padding.left   ) ;
                pr = EdgeMetrics.filterNaNValue( s.padding.right  ) ;
                pt = EdgeMetrics.filterNaNValue( s.padding.top    ) ;
            }
            
            field.autoSize = TextFieldAutoSize.NONE ; // Fix problem with style.autoSize:Boolean property
            
            field.x = ml ;
            field.y = pt + mt ;
            
            field.width  = b.w - pl - ml - mr - pr  ;
            field.height = b.h - mb - pb - pt - mt ;
            
            if ( iconContainer != null )
            {
                field.width -= iconContainer.width ;
            }
            
            if ( container != null )
            {
                field.x     += container.width + pl ;
                field.width -= container.width ;
            }
        }
        
        /**
         * Invoked when the delete button is selected.
         */
        protected function deleteClick( e:MouseEvent ):void
        {
            e.stopImmediatePropagation() ;
            ( target as IEventDispatcher ).dispatchEvent(new ButtonEvent(ItemButton.DELETE)) ;
        }
        
        /**
         * Invoked when the option button is selected.
         */
        protected function optionClick( e:MouseEvent ):void
        {
            e.stopImmediatePropagation() ;
            ( target as IEventDispatcher ).dispatchEvent(new ButtonEvent(ItemButton.OPTION)) ;
        }
        
        /**
         * Refresh the container.
         */
        protected override function refreshContainer():void
        {
            if ( container )
            {
                var t:ItemButton      = target as ItemButton ;    
                var s:ItemButtonStyle = t.style as ItemButtonStyle ;
                var ml:Number = 0 ;
                if ( s.margin != null )
                {
                    ml = EdgeMetrics.filterNaNValue( s.margin.left ) ;
                }
                container.x       = ml ;
                container.y       = (t.h - container.height) / 2 ;
                container.filters = s.iconFilters ;
            }
        }

        /**
         * Refresh the container.
         */
        protected function refreshIconContainer():void
        {
            if ( iconContainer != null )
            {
                iconContainer.update() ;
                var t:ItemButton      = target as ItemButton ;
                var s:ItemButtonStyle = t.style as ItemButtonStyle ;
                var mr:Number = 0 ;
                if ( s.padding != null )
                {
                    mr = EdgeMetrics.filterNaNValue(s.padding.right) ;
                }
                iconContainer.space = s.spacing ;
                iconContainer.x = t.w - mr - iconContainer.width ;
                iconContainer.y = (t.h - iconContainer.height) / 2 ;
            }
        } 
        
        /**
         * @private
         */
        private var _deleteDisplay:DisplayObject ;
        
        /**
         * @private
         */
        private var _optionDisplay:DisplayObject ;
        
        /**
         * @private
         */
        private function _stopImmediatePropagation( e:MouseEvent ):void
        {
            e.stopImmediatePropagation() ;
        }   
    }
}
