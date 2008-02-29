import asgard.display.Direction;

import lunas.core.EdgeMetrics;
import lunas.core.IScrollbar;
import lunas.display.abstract.AbstractProgressbarDisplay;

import pegas.events.ButtonEvent;
import pegas.transitions.Tween;
import pegas.transitions.easing.Expo;

/**
 * This class provides a skeletal implementation of all the {@code IScrollbar} display components, to minimize the effort required to implement this interface.
 * This class contains a different implementation of the AS2 AbstractScrollbarDisplay class.
 * The AS2 AbstractSliderDisplay class is based on the AS3 AbstractScrollbarDisplay class. 
 * @author eKameleon
 */
class lunas.display.abstract.AbstractSliderDisplay extends AbstractProgressbarDisplay implements IScrollbar
{

	/**
	 * Creates a new AbstractSliderDisplay instance.
	 * @param sName the name of the display.
	 * @param target the DisplayObject instance control this target.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	private function AbstractSliderDisplay( sName:String, target:MovieClip , bGlobal:Boolean , sChannel:String ) 
	{ 
		
		super ( sName, target , bGlobal , sChannel ) ;
		if ( _border == null )
		{
			 _border = EdgeMetrics.EMPTY ;
		}
		_eDrag      = new ButtonEvent( ButtonEvent.DRAG, this ) ;
		_eStartDrag = new ButtonEvent( ButtonEvent.START_DRAG, this ) ;
		_eStopDrag  = new ButtonEvent( ButtonEvent.STOP_DRAG, this ) ;
		_nDirection = Direction.VERTICAL ;
	}

	/**
	 * The name of the event when the user drag the scrollbar.
	 */
	public static var DRAG:String = ButtonEvent.DRAG ;

	/**
	 * The name of the event when the user start to drag the scrollbar.
	 */
	public static var START_DRAG:String = ButtonEvent.START_DRAG ;

	/**
	 * The name of the event when the user stop to drag the scrollbar.
	 */
	public static var STOP_DRAG:String = ButtonEvent.STOP_DRAG ;

    /**
     * Indicates the thickness, in pixels, of the four edge regions around a visual component.
     */
    public function get border():EdgeMetrics
    {
        return _border ;
    }
        
    /**
     * @private
     */
    public function set border( em:EdgeMetrics ):Void
    {
        _border = em ||  EdgeMetrics.EMPTY ;
        update() ;
    }

	/**
	 * Indicates the duration of the easing effect if is active.
	 */
	public var duration:Number = 24  ;	

	/**
	 * Indicates the easing method if the easing effect is active.
	 */
	public var easing:Function = null ;

	/**
	 * A static object use to defines the inverse position property name of the bar.
	 */
	public function get invertPosField():Object
	{
		var o:Object = {} ;
		o[propX] = o[propY] ;
		o[propY] = o[propX] ;
		return o ;
	}

	/**
	 * A static object use to defines the inverse size properties name of the bar.
	 */
	public function get invertSizeField():Object 
	{
		var o:Object  = {} ;
		o[propWidth]  = o[propHeight] ;
		o[propHeight] = o[propWidth] ;
		return o ;
	}

	/**
	 * (read-only) Returns {@code true} if the bar is dragging.
	 * @return {@code true} if the bar is dragging.
	 */
	public function get isDragging():Boolean 
	{
		return getIsDragging() ;	
	}
	
	/**
	 * The height property name
	 */
	public var propHeight:String = "_height" ;

	/**
	 * The width property name
	 */
	public var propWidth:String  = "_width" ;

	/**
	 * The x property name
	 */
	public var propX:String = "_x" ;

	/**
	 * The xmouse property name
	 */
	public var propXmouse:String = "_xmouse" ;

	/**
	 * The y property name
	 */
	public var propY:String = "_y" ;
	
	/**
	 * The ymouse property name
	 */
	public var propYmouse:String = "_ymouse" ;

	/**
	 * (Read-write) The maximum value of this scrollbar.
	 */
	public function get maximum():Number
	{
		return _max;
	}

	/**
	 * @private
	 */
	public function set maximum(m:Number):Void
	{
		_max = m;
		viewPositionChanged() ;
	}
	
	/**
	 * (Read-write) The minimum value of this scrollbar.
	 */
	public function get minimum():Number
	{
		return _min;
	}
	
	/**
	 * @private
	 */
	public function set minimum(m:Number):Void
	{
		_min = m;
		viewPositionChanged() ;
	}	

	/**
	 * Determinates if the bar use easing effects or not.
	 */
	public var noEasing:Boolean = true ;

    /**
     * Determinates the size of the thumb.
     */
    public function get thumbSize():Number
    {
		var hBorder:Number = EdgeMetrics.filterNaNValue( border.top ) + EdgeMetrics.filterNaNValue( border.bottom ) ;
		var wBorder:Number = EdgeMetrics.filterNaNValue( border.left ) + EdgeMetrics.filterNaNValue( border.right ) ;
        if( isNaN(_thumbSize) )
        {
          	return ( direction == Direction.HORIZONTAL ) ? h - hBorder : w - wBorder ;
        }
        else
        {
         	return ( direction == Direction.HORIZONTAL ) ? Math.min( _thumbSize , w ) : Math.min( _thumbSize , h ) ;
        }
     }
	
	/**
     * @private
     */        
    public function set thumbSize( value:Number ):Void
    {
        _thumbSize = value ;
        update() ;
    }

	/**
	 * Invoked when the bar is dragging.
	 */
	public function dragging():Void 
	{
		var t = getThumb() ;
		var b = getBar()   ;
		var ts:Number          = thumbSize ;
		var oldPosition:Number = position ;
		var newPosition:Number ;
		if( direction == Direction.HORIZONTAL )
		{
			newPosition = t[propX] / (b[propWidth] - ts) * (_max - _min) + _min ;
			if ( _invert )
			{
				newPosition = (_max + _min) - newPosition ;
			}
		}
		else
		{
			var range:Number = b[propHeight] - ts ;
			newPosition = _min + ( range - t[propY] ) / range * (_max - _min) ;
			if ( _invert == false )
			{
				newPosition = (_max + _min) - newPosition ;
			}
		}
		setPosition( Math.round(newPosition) ) ;
		if(newPosition != oldPosition)
		{
			notifyDrag() ;
		}			
	}

	/**
	 * Returns the background bar reference. Overrides this method in the concrete implementations.
	 * @return the background bar reference.
	 */
	public function getBar():MovieClip 
	{
		return null ; // override this method !
	}

	/**
	 * Returns {@code true} if the component is dragging.
	 * @return {@code true} if the component is dragging.
	 */
	public function getIsDragging():Boolean 
	{
		return _isDragging ;
	}
	
	/**
	 * Returns the string representation of the current size field property of this component with the current direction value.
	 * @return the string representation of the current size field property of this component with the current direction value.
	 */
	public function getSizeField():String 
	{
		return (getDirection() == Direction.VERTICAL) ? propHeight : propWidth ;
	}
	
	/**
	 * Returns the string representation of the current mouse field property of this component with the current direction value.
	 * @return the string representation of the current mouse field property of this component with the current direction value.
	 */
	public function getMouseField():String 
	{
		return (getDirection() == Direction.VERTICAL) ? propYmouse : propXmouse ;
	}
	
	/**
	 * Returns the thumb reference. Overrides this method in the concrete implementations.
	 * @return the thumb reference.
	 */
	public function getThumb():MovieClip 
	{
		return null ; // override this method !
	}

	/**
	 * Dispatchs an event when the user drag the bar.
	 */
	public function notifyDrag( position:Number ):Void 
	{
		_eDrag.position = position ;
		dispatchEvent( _eDrag ) ;
	}

	/**
	 * Dispatchs an event when the user start to drag the bar.
	 */
	public function notifyStartDrag():Void
	{
		dispatchEvent( _eStartDrag ) ;	
	}

	/**
	 * Dispatchs an event when the user stop to drag the bar.
	 */
	public function notifyStopDrag():Void
	{
		dispatchEvent( _eStopDrag ) ;	
	}

	/**
	 * Invoked when the user start to drag the bar.
	 */
	public function startDragging():Void 
	{
		notifyStartDrag() ;
		_isDragging = true ;
		Mouse.addListener(this) ;
		var t:MovieClip = getThumb() ;
		var b:MovieClip = getBar()   ;		
		var ts:Number = thumbSize ;
		trace(ts) ;
		if( direction == Direction.HORIZONTAL )
		{
			t.startDrag(false, 0 , 0 , b[propWidth] - thumbSize , 0 ) ;
		}
		else
		{
			t.startDrag(false, 0 , 0 , 0 , b[propHeight] - thumbSize ) ;
		}
	}

	/**
	 * Invoked when the user stop to drag the bar.
	 */
	public function stopDragging():Void 
	{
		_isDragging = false ;
		Mouse.removeListener(this) ;
		getThumb().stopDrag();
		notifyStopDrag() ;
	}
	
	/**
	 * Invoked when the position value of the bar is changed.
	 */
	public function viewPositionChanged( flag:Boolean ):Void 
	{
		if (_tw.getRunning()) 
		{
			_tw.stop() ;
		}		
		try
		{
			
			var value:Number   ;
			var posField:String = (_nDirection == Direction.VERTICAL) ? propY : propX ;
			
			var t:MovieClip = getThumb() ;
			var b:MovieClip = getBar()   ;
			
			_fixPosition() ;
			if ( !isDragging )
			{
				var range:Number ;
				var ts:Number = thumbSize ;
				if(direction == Direction.HORIZONTAL)
				{
					t[propY] = 0 ;
					range = b[propWidth] - ts ;
				}
				else
				{
					t[propX] = 0 ;
					range = b[propHeight] - ts ;
				}
				value  = (_position - _min) / (_max - _min) * range ;
				if ( _invert )
				{
					value = range - value ;
				} 
				if ( flag || _isDragging || noEasing ) 
				{
					t[posField] = value ;
				} 
				else 
				{
					_tw = new Tween 
					( 
						t, 
						posField, 
						easing || Expo.easeOut ,
						t[posField] ,  
						value , 
						isNaN(duration) ? 24 : duration
					) ;
					_tw.run() ;
				}				
			}
		}
		catch( e:Error )
		{
			//
		}
	}


	/**
	 * The max value of the scrollbar.
	 */
	/*protected*/ var _max:Number = 100 ;

	/**
	 * The min value of the scrollbar.
	 */
	/*protected*/ var _min:Number = 0 ;		

    /**
     * @private
     */
    private var _border:EdgeMetrics ;	

	/**
	 * @private
	 */
	private var _eDrag:ButtonEvent ;
	
	/**
	 * @private
	 */	
	private var _eStartDrag:ButtonEvent ;
	
	/**
	 * @private
	 */	
	private var _eStopDrag:ButtonEvent ;

	/**
	 * @private
	 */
	private var _invert:Boolean = false ;

	/**
	 * @private
	 */	
	private var _isDragging:Boolean ;

	/**
	 * @private
	 */
	private var _lineScrollSize:Number = 1 ;

	/**
	 * @private
	 */	
	private var _mouseOffset:Number = 0 ;
	
	/**
	 * @private
	 */	
	private var _nDirection:Number ; 

	/**
	 * @private
	 */
	private var _thumbSize:Number ;

	/**
	 * @private
	 */	
	private var _tw:Tween ;

	/**
	 * Fix the position of the bar to be within minimum and maximum.
	 * @private
	 */
	private function _fixPosition():Void
	{
		if(_max > _min)
		{
			_position = Math.min(_position, _max) ;
			_position = Math.max(_position, _min) ;
		}
		else
		{
			_position = Math.max(_position, _max) ;
			_position = Math.min(_position, _min) ;
		}
	}

	/**
	 * @private
	 */	
	private function onMouseUp():Void
	{
		stopDragging() ;
	}

	/**
	 * @private
	 */	
	private function onMouseMove():Void
	{
		dragging() ;
	}

}
