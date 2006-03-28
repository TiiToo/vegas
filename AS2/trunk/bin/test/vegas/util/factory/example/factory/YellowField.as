/* ---------- YellowField

	AUTHOR

		Name : YellowField
		Package : example.factory
		Version : 1.0.0.0
		Date :  2005-11-28
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net
	
----------  */	

class example.factory.YellowField extends TextField {

	// ----o Constructor
	
	public function YellowField() {
		_width = 150 ;
		_height = 50 ;
		var f:TextFormat = new TextFormat("verdana", 20) ;
		f.leftMargin = 4 ;
		f.rightMargin = 4 ;
		setNewTextFormat(f) ;
		textColor = color ;
		selectable = false ;
		border = true ;
		borderColor = 0xFFFFFF ;
		autoSize = "left" ;
	}
	
	// ----o Public Methods
	
	public var color:Number = 0xF5F44E ;
	
}