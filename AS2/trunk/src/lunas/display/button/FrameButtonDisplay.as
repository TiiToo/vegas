/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import lunas.display.abstract.AbstractButtonDisplay;

import pegas.events.ButtonEvent;
import pegas.events.ButtonEventType;

import vegas.events.Delegate;
import vegas.events.EventListener;

/**
 * The FrameButtonDisplay class is use over a clip with the 4 default frame's labels with the name :
 * <ul>
 * <li>"disabled" : the frame when the button is disabled.</li>
 * <li>"down"     : the frame when the button is down.</li>
 * <li>"over"     : the frame when the button is over.</li>
 * <li>"up"       : the first frame when the button is up.</li>
 * </ul>
 * <p>The {@code stop()} method is call in the first frame of the component when the constructor is launched.</p>
 * This class looks like SimpleButton class but you can use the {@code registerType()} and the {@code unregisterType()} method to add or remove a ButtonEvent type (DISABLED, OVER, DOWN...) corresponding with a frame label in the MovieClip view of the button.
 * @author eKameleon
 * @see pegas.events.ButtonEvent
 */
class lunas.display.button.FrameButtonDisplay extends AbstractButtonDisplay
{

	/**
	 * Creates a new FrameButtonDisplay instance.
	 * @param sName:String the name of the display.
	 * @param target:MovieClip the DisplayObject instance control this target.
	 */
	public function FrameButtonDisplay (sName:String, target:MovieClip ) 
	{
		
		super ( sName, target ) ;
		
		_listener = new Delegate(this, refresh) ;

		this.registerType( ButtonEvent.DISABLED ) ;
		this.registerType( ButtonEvent.DOWN     ) ;
		this.registerType( ButtonEvent.OVER     ) ;
		this.registerType( ButtonEvent.UP       ) ;
	
		getView().stop() ;
			
	}
	
	/**
	 * Invoqued when the view of the button is refresh.
	 */
	public function refresh( e:ButtonEvent ): Void 
	{
		getView().gotoAndStop( e.getType() ) ;
	}
	
	/**
	 * Register the ButtonEvent type passed in argument.
	 */
	public function registerType( type:String ):Void
	{
		this.addEventListener( type , _listener ) ;
	}

	/**
	 * This method delegate the reference of the different views of the button over a other movieclip.
	 * You can override this method.	 
	 */
	public function getView():MovieClip 
	{
		return view ;
	}

	/**
	 * Unregister the ButtonEvent type passed in argument.
	 */
	public function unregisterType( type:String ):Void
	{
		this.removeEventListener( type , _listener ) ;
	}

	private var _listener:EventListener ;

}
