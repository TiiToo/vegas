/* ---------- Rectangle

	AUTHOR

		Name : Rectangle
		Package : example.factory
		Version : 1.0.0.0
		Date :  2005-11-28
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net
	
----------  */	

class example.factory.Rectangle extends MovieClip {

	// ----o Constructor
	
	public function Rectangle() {
		draw() ;		
	}
	
	// ----o Public Methods
	
	public var color:Number = 0xFF0000 ;
	public var h:Number = 50 ;
	public var w:Number = 50 ;
		
	// ----o Public Methods
	
	public function draw():Void {
		clear() ;
		beginFill(color, 100) ;
		lineStyle(0, color, 100) ;
		lineTo(w, 0) ;
		lineTo(w, h) ;
		lineTo(0, h) ;
		lineTo(0, 0) ;
		endFill() ;
	}
	
}