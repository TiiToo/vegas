import andromeda.util.visitor.AbstractVisitable;

/**
 * The Picture class to display a picture in a Movieclip who contains a container movieclip inside.
 * @author eKameleon
 */
class test.observer.diaporama.Picture extends AbstractVisitable
{

	/**
	 * Creates a new Picture instance.
	 */	
	public function Picture( name:String, target:MovieClip , url:String , hide:Boolean) 
	{
		
		this.name = name ;
		
		this.url  = url ;
		
		view = target ;
		
		container = view.createEmptyMovieClip("container", 1) ;
		container._x = margin ;
		container._y = margin ;
		
		setVisible( !hide ) ;
	}

	/**
	 * The container reference in the picture display.
	 */
	public var container:MovieClip ;

	/**
	 * The margin in the picture to display the container.
	 */
	public var margin:Number = 10 ;

	/**
	 * The name of the picture.
	 */
	public var name:String ;

	/**
	 * The url of the picture.
	 */
	public var url:String ;

	/**
	 * The view of the picture.
	 */
	public var view:MovieClip ;
	
	/**
	 * Returns true if the picture is visible.
	 */
	public function isVisible():Boolean 
	{
		return view._visible ;		
	}
	
	/**
	 * Sets the visible property of the picture.
	 */
	public function setVisible( b:Boolean ):Void
	{
		view._visible = b ;
	}
	
	/**
	 * Returns the string representation of this object.
	 * @return the string representation of this object.
	 */
	public function toString():String
	{
		return "[Picture " + name + "]" ;
	}

}