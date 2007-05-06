intrinsic class FListBoxClass 
	extends FUIComponentClass
{
	
	public function addItem( item:Object, data:Object):Void;
	public function getLength():Number;
	public function getItemAt( index:Number):Object;
	public function getSelectedIndex():Number;
	public function getValue():Number;
	public function removeAll():Void;
	public function setSelectedIndex( index:Number):Void;
	public function sortItemsBy( property:String, Flags:String):Void;
}