import lunas.display.components.AbstractBuilder;

import vegas.events.Delegate;

/**
 * @author eKameleon
 */
class lunas.display.components.bar.VisualVScrollbarBuilder extends AbstractBuilder {
	
	// ----o Constructor
	
	function VisualVScrollbarBuilder(mc : MovieClip) {
		super(mc);
	}
	
	// ----o Public Properties
	
	public var bar:MovieClip ;
	public var thumb:MovieClip ;
	
	// ----o Public Methods		

	public function clear():Void {
		//
	}

	public function run():Void {
		_createBar() ;
		_createThumb() ;
	}

	public function update():Void {
		bar._height = target.getH() ;
	}

	// ----o Private Methods
	
	private function _createBar():Void {
		bar = target.bar ;
		bar.onPress = Delegate.create(target, target.dragging) ;
		bar.useHandCursor = false ;
	}

	private function _createThumb():Void {
		thumb = target.thumb ;
		thumb.onPress = Delegate.create(target, target.startDragging) ;
		thumb.onRelease = Delegate.create(target, target.stopDragging) ;
		thumb.onReleaseOutside = thumb.onRelease ;
		thumb.useHandCursor = false ;
	}

}