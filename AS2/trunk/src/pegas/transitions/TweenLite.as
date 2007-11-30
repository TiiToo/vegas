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

/**
 * The TweenLite class lets you use ActionScript to move, resize, and fade movie clips easily on the Stage by specifying a property of the target movie clip to be tween animated over a number of frames or seconds.
 * The TweenLite class also lets you specify a variety of easing methods.
 * <p>Easing refers to gradual acceleration or deceleration during an animation, which helps your animations appear more realistic.</p>
 * <p><b>Example :</b></p>
 * {@code
 * import pegas.process.ActionEvent ;
 * import pegas.transitions.TweenLite ;
 * import pegas.transitions.easing.* ;
 * 
 * import vegas.events.Delegate ;
 * import vegas.events.EventListener ;
 * 
 * var onDebug:Function = function( ev:ActionEvent ):Void
 * {
 *     trace (":: debug -> " + ev.type + " : " + ev.target ) ;
 * }
 * 
 * var debug:EventListener = new Delegate(this, onDebug) ;
 * 
 * var tw:TweenLite = new TweenLite (mc, "_x", Elastic.easeOut, mc._x, 400, 2, true, true) ;
 * tw.addGlobalEventListener( debug ) ;
 * }
 * @author eKameleon
 */
class pegas.transitions.TweenLite extends Motion 
{

	/**
	 * Creates a new TweenLite instance.
	 * <p><b>Usage :</b></p>
	 * {@code
	 * var tw:TweenLite = new TweenLite( obj, prop:String, e:Function, b:Number, f:Number, d:Number , u:Boolean, auto:Boolean) ;
	 * }
	 */
	function TweenLite( obj , prop:String , easing:Function , begin:Number , finish:Number , duration:Number , useSeconds:Boolean , auto:Boolean ) 
	{
		this.target     = obj        ;
		this.duration   = duration   ;
		this.useSeconds = useSeconds ;
		this.setTweenEntry( prop , easing, begin, finish ) ;
		if ( auto == true ) 
		{
			run() ;
		}
	}

	/**
	 * Returns the TweenEntry reference of this tween.
	 * @return the TweenEntry reference of this tween.
	 */
	public function get tweenEntry():TweenEntry 
	{
		return _entry ;
	}

	/**
	 * (read-write) Sets the model of this Tween object.
	 */
	public function set tweenEntry( entry:TweenEntry ):Void 
	{
		_entry = entry || new TweenEntry() ;
	}

	/**
	 * Returns a shallow copy of this Tween object.
	 * @return a shallow copy of this Tween object.
	 */
	public /*override*/ function clone() 
	{
		var t:TweenLite = new TweenLite(target) ;
		t.duration   = duration   ;
		t.useSeconds = useSeconds ;
		t.tweenEntry = tweenEntry.clone() ;
		return t ;
	}
	
	/**
	 * Instructs the tweened animation to continue tweening from its current animation point to a new finish and duration point.
	 * @param finish A number indicating the ending value of the target object property that is to be tweened.
	 * @param duration A number indicating the length of time or number of frames for the tween motion.
	 * @param noRestart This optional flag is used to fix the restart process of the tween.
	 */
	public function continueTo(finish:Number, duration:Number, noRestart:Boolean ):Void 
	{
		_entry.begin  = target[_entry.prop] ;
		_entry.finish = finish ;
		if ( !isNaN(duration) )
		{
			this.duration = duration;
		}
		if ( noRestart == true  )
		{
			return ;
		}
		if ( running == false )
		{
			this.run();
		}
	}

	/**
	 * Set the TweenEntry property of this TweenLite object.
	 * @param prop the property name of the object to change.
	 * @param easing the easing function of the tween entry.
	 * @param begin the begin value.
	 * @param finish the finish value. 
	 */
	public function setTweenEntry( prop:String, easing:Function , begin:Number , finish:Number ):Void
	{
		if ( _entry == null )
		{
			_entry = new TweenEntry() ;
		}
		_entry.prop   = prop   ;
		_entry.easing = easing ; 	
		_entry.begin  = begin  ;
		_entry.finish = finish ;
	}

	/**
	 * Update the current Tween in the time.
	 */
	public /*override*/ function update():Void 
	{
		target[_entry.prop] = _entry.setPosition( _entry.getPosition(_time, _duration) ) ;
		updateAfterEvent() ;
		notifyChanged() ;
	}
	
	/**
	 * Instructs the tweened animation to play in reverse from its last direction of tweened property increments. 
	 * If this method is called before a Tween object's animation is complete, the animation abruptly jumps to the end of its play and then plays in a reverse direction from that point.
	 */
	public function yoyo():Void 
	{
		continueTo( _entry.begin, getTime() );
	}
	
	private var _entry:TweenEntry ;
	
}