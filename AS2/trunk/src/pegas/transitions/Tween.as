/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */

import pegas.transitions.Motion;
import pegas.transitions.TweenEntry;
import pegas.transitions.TweenModel;

/**
 * The Tween class lets you use ActionScript to move, resize, and fade movie clips easily on the Stage by specifying a property of the target movie clip to be tween animated over a number of frames or seconds.
 * The Tween class also lets you specify a variety of easing methods.
 * <p>Easing refers to gradual acceleration or deceleration during an animation, which helps your animations appear more realistic.</p>
 * <p><b>Example :</b></p>
 * {@code
 * import pegas.process.ActionEvent ;
 * import pegas.transitions.Tween ;
 * import pegas.transitions.easing.Elastic ;
 * 
 * import vegas.events.Delegate ;
 * import vegas.events.EventListener ;
 * 
 * var onDebug:Function = function(ev:ActionEvent):Void
 * {
 *     trace ("debug : " + ev.getType() + " : " + ev.getTarget() ) ;
 * }
 * 
 * var debug:EventListener = new Delegate(this, onDebug) ;
 * 
 * var tw:Tween = new Tween (mc, "_x", Elastic.easeOut, mc._x, 400, 2, true, true) ;
 * tw.addGlobalEventListener( debug ) ;
 * }
 * @author eKameleon
 */
class pegas.transitions.Tween extends Motion 
{

	/**
	 * Creates a new Tween instance.
	 * <p><b>Usage :</b></p>
	 * {@code
	 * var tw:Tween = new Tween( obj, prop:String, e:Function, b:Number, f:Number, d:Number , u:Boolean, auto:Boolean) ;
	 * var tw:Tween = new Tween( obj, ar:Array ) ;
	 * }
	 */
	function Tween( args ) 
	{
		var obj = arguments[0] ;
		if (obj != null) 
		{
			setTarget(obj) ;
		}
		else 
		{
			return ;
		}
		var l:Number = arguments.length ;
		if (l == 2 && arguments[1] instanceof Array) 
		{
			setTweenModel(arguments[1]) ;
		} 
		else if (l > 2) 
		{
			var p:String   = arguments[1] ; // property
			var e:Function = arguments[2] ; // easing
			var b:Number   = arguments[3] ; // begin
			var f:Number   = arguments[4] ; // finish
			var d:Number   = arguments[5] ; // duration
			var u:Boolean  = arguments[6] ; // useSeconds
			var a:Boolean  = arguments[7] ; // auto start
			setDuration(d) ;
			useSeconds = u ;
			setTweenModel( [new TweenEntry(p, e, b, f)] ) ;
			if (a) run() ;
		}
	}

	/**
	 * (read-write) Determinates the model of this Tween.
	 */
	public function get model():TweenModel 
	{
		return getTweenModel() ;
	}

	/**
	 * @private
	 */
	public function set model( o ):Void 
	{
		setTweenModel(o) ;
	}

	/**
	 * Removes all entries in the model of this Tween object.
	 */
	public function clear():Void 
	{
		if ( running ) 
		{
			this.stop() ;
		}
		if ( _model )
		{
			_model.clear() ;
		}
		notifyCleared() ;
	}

	/**
	 * Returns a shallow copy of this Tween object.
	 * @return a shallow copy of this Tween object.
	 */
	public /*override*/ function clone() 
	{
		var t:Tween = new Tween() ;
		t.target     = target ;
		t.duration   = getDuration() ;
		t.useSeconds = useSeconds ;
		if (size() > 0) 
		{
			t.model = model.clone() ;
		}
		return t ;
	}

	/**
	 * Returns the TweenModel reference of this Tween object.
	 * @return the TweenModel model reference of this Tween object.
	 */
	public function getTweenModel():TweenModel
	{
		return _model ;
	}
	
	/**
	 * Inserts a TweenEnry in the model of the Tween object.
	 * @param entry a TweenEntry reference.
	 */
	public function insert( entry:TweenEntry ):Void 
	{
		if ( _model == null )
		{
			setTweenModel() ;
		}
		_model.insert( entry ) ;
	}

	/**
	 * Inserts a new property in the Tween object.
	 * @param prop the string representation of the number property.
	 * @param easing the easing method used by the Tween on this property.
	 * @param begin the begin value.
	 * @param finish the finish value.
	 * @return a TweenEntry defined by the specified arguments.
	 */
	public function insertProperty( prop , easing:Function, begin:Number, finish:Number):TweenEntry 
	{
		var e:TweenEntry = new TweenEntry(prop, easing, begin, finish) ;
		insert(e) ;
		return e ;
	}

	/**
	 * Remove a TweenEntry in the Tween Object.
	 */
	public function remove(o:TweenEntry):Void 
	{
		if (running) stop() ;
		_model.remove(o) ;
	}	
	
	/**
	 * Remove a property in the Tween Object.
	 */
	public function removeProperty(prop:String):Boolean 
	{
		if (running) stop() ;
		return _model.remove(prop) ;
	}

	/**
	 * Sets the model of this Tween object.
	 */
	public function setTweenModel( o ):Void 
	{
		if ( o instanceof TweenModel ) 
		{
			_model = o ;
		}
		else if ( o instanceof Array ) 
		{
			_model = new TweenModel( null , o ) ;
		}
		else 
		{
			_model = new TweenModel() ;
		}
	}
	
	/**
	 * Returns the numbers of elements(properties) in the model of this Tween.
	 * @return the numbers of elements(properties) in the model of this Tween.
	 */
	public function size():Number 
	{
		return _model.size() ;
	}
	
	/**
	 * Update the current Tween in the time.
	 */
	public /*override*/ function update():Void 
	{
		var o        = target ;
		var t:Number = _time ;
		var d:Number = _duration ;
		var a:Array  = _model.toArray() ;
		var l:Number = a.length ;
		while(--l > -1) 
		{
			var e:TweenEntry = a[l] ;
			o[e.prop] = e.setPosition( e.getPosition(t, d) ) ;
			updateAfterEvent() ;
		}
		notifyChanged() ;
	}
	
	private var _model:TweenModel ;

}