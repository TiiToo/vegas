
import asgard.display.DisplayObject;
import asgard.display.StageAlign;
import asgard.display.StageScaleMode;

import test.visitor.diaporama.control.Controller;
import test.visitor.diaporama.model.GalleryModel;
import test.visitor.diaporama.Picture;

import vegas.data.iterator.Iterator;
import vegas.events.Delegate;

/**
 * The main class of the gallery.
 * @author eKameleon
 */
class test.visitor.diaporama.Gallery extends DisplayObject
{
	
	/**
	 * Creates a new Gallery instance.
	 */
	private function Gallery( target:MovieClip ) 
	{
		
		super( GALLERY_NAME , target );
		
		Controller.getInstance() ;

		Stage.align = StageAlign.TOP_LEFT ;
		Stage.scaleMode = StageScaleMode.NO_SCALE ;
		Stage.addListener(this) ;
		
		onResize = Delegate.create(this, resize) ;

		initialize() ;
		
		Key.addListener(this) ;
		Mouse.addListener(this) ;
		
	}

	/**
	 * (const) the name of the GalleryDisplay.
	 */
	static public var GALLERY_NAME:String = "gallery" ; 

	/**
	 * The link of liaison of the movieclip in the library.
	 */
	static public var PICTURE_VIEW_ID:String = "picture_view" ;
	
	/**
	 * The container reference of all Pictures.
	 */
	public var container:MovieClip ;
	
	/**
	 *	The singleton reference of the Gallery display instance. 
	 */
	static public var gallery:Gallery ;
	
	/**
	 * The numbers of picture in the gallery.
	 */
	public var nPicture:Number = 6 ;

	/**
	 * Clear and initialize the view of the display. 
	 */
	public function clear():Void
	{
		if (container)
		{
			container.removeMovieClip() ;	
		}
		container = view.createEmptyMovieClip("container", 10 ) ;	
	}
	
	/**
	 * Initialize the application model.
	 */
	public function initialize():Void
	{
		
		GalleryModel.getInstance().clear() ;
		
		var picture:Picture ;
		var count:Number = 3 ;
		
		for (var i:Number = 1 ; i<= nPicture ; i++)
		{
			var mc:MovieClip = container.attachMovie( PICTURE_VIEW_ID , "picture_mc" + i , i ) ;
			var picture:Picture = new Picture("picture " + i , mc , "library/picture" + i + ".jpg") ; 
			GalleryModel.getInstance().addPicture( picture ) ;
		}
		
		resize() ;
		
		GalleryModel.getInstance().run() ;
		
	}

	/**
	 * The main method to launch the application.
	 */
	static public function main( target:MovieClip ):Void
	{
		if (gallery == null)
		{
			gallery = new Gallery(target) ;	
		}	
	}

	/**
	 * Invoqued when the user press a key.
	 */
	public function onKeyDown():Void
	{
		var code:Number = Key.getCode() ;
		switch (code)
		{
			case Key.RIGHT :
			{
				GalleryModel.getInstance().next() ;	
				break ;
			}
			case Key.LEFT :
			{
				GalleryModel.getInstance().prev() ;	
				break ;
			}
		}	
	}
	
	/**
	 * Invoqued when the user click with this mouse on the stage.
	 */
	public function onMouseDown():Void
	{
		if (_root._xmouse < Stage/2)
		{
			GalleryModel.getInstance().prev() ;
		}
		else
		{
			GalleryModel.getInstance().next() ;
		}
	}

	/**
	 * Resize and change the layout of all items in this display.
	 * @see Stage
	 */
	public function resize():Void
	{
		var model:GalleryModel = GalleryModel.getInstance() ;
		var size:Number = model.size() ;
		if (size > 0)
		{
			var it:Iterator = model.iterator() ;
			while(it.hasNext())
			{
				var cur:Picture = Picture(it.next()) ;
				cur.view._x = (Stage.width - cur.view._width ) / 2 ;
				cur.view._y = (Stage.height - cur.view._height ) / 2 ;
			}
		}
	}
	
	/**
	 * The internal onResize callback function who notify the Stage.onResize event. 
	 */
	private var onResize:Function ;
	
}