intrinsic class Video
{
	var deblocking : Number;
	var height : Number;
	var smoothing : Boolean;
	var width : Number;
	
	var _alpha:Number;
	var _x:Number;
	var _y:Number;
	var _width:Number;
	var _height:Number;
	var _xscale:Number;
	var _yscale:Number;
	var _xmouse:Number;
	var _ymouse:Number;

	function attachVideo( source : Object ) : Void;
	function clear() : Void;
}


