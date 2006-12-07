import test.visitor.diaporama.visitors.ClearVisitor;
import test.visitor.diaporama.visitors.HideVisitor;
import test.visitor.diaporama.visitors.LoaderVisitor;
import test.visitor.diaporama.visitors.ShowVisitor;

import vegas.util.visitor.AbstractVisitable;
import vegas.util.visitor.IVisitor;

/**
 * The Picture class to display a picture in a Movieclip who contains a container movieclip inside.
 * @author eKameleon
 */
class test.visitor.diaporama.Picture extends AbstractVisitable
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
	 * Accept a IVisitor object 
	 */
	public function accept( visitor:IVisitor ) 
	{
		
		switch( true )
		{
			
			case visitor instanceof ClearVisitor :
			{
				ClearVisitor(visitor).visit(this) ;
				break ;
			}
			
			case visitor instanceof HideVisitor :
			{
				HideVisitor(visitor).visit(this) ;
				break ;
			}	

			case visitor instanceof LoaderVisitor :
			{
				LoaderVisitor(visitor).visit(this) ;
				break ;
			}	

			case visitor instanceof ShowVisitor :
			{
				ShowVisitor(visitor).visit(this) ;
				break ;
			}
				
		}
	}

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