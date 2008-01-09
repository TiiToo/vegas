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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.display.button 
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import lunas.display.abstract.AbstractButton;
	import lunas.events.ButtonEvent;
	
	import vegas.data.sets.HashSet;	

	/**
	 * The FrameLabelButton class is use over a clip with the 4 default frame's labels with the name :
 	 * <ul>
 	 * <li>"disabled" : the frame when the button is disabled.</li>
	 * <li>"down"     : the frame when the button is down.</li>
	 * <li>"over"     : the frame when the button is over.</li>
	 * <li>"up"       : the first frame when the button is up.</li>
	 * </ul>
	 * <p>The {@code stop()} method is call in the first frame of the component when the constructor is launched.</p>
	 * This class looks like SimpleButton class but you can use the {@code registerType()} and the {@code unregisterType()} method to add or remove a ButtonEvent type (DISABLED, OVER, DOWN...) corresponding with a frame label in the MovieClip view of the button.
	 * @author eKameleon
	 */
	public class FrameLabelButton extends AbstractButton 
	{

		/**
		 * Creates a new FrameLabelButton instance.
		 * @param states the MovieClip reference with the state frames of this button.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
	 	 */	
		public function FrameLabelButton( states:MovieClip=null , id:* = null, isConfigurable:Boolean = false, name:String = null )
		{
			super( id, isConfigurable, name );
			_set = new HashSet() ;
			if ( states != null )
			{
				this.states == states ;
			}
			// default
			registerType( ButtonEvent.DISABLED ) ;
			registerType( ButtonEvent.DOWN     ) ;
			registerType( ButtonEvent.OVER     ) ;
			registerType( ButtonEvent.UP       ) ;
		}
		
		/**
		 * Indicates the MovieClip reference with the state frames of this button.
		 */
		public function get states():MovieClip
		{
			return _states ;	
		}
		
		/**
		 * @private
		 */
		public function set states( states:MovieClip ):void
		{
			var ar:Array  = _set.toArray() ;
			var size:uint ;
			if ( _states != null && _set.size() > 0 )
			{
				size = ar.length ;
				while(--size > -1)
				{
					removeEventListener(ar[size], refreshState )	;
				}
			}
			_states = states ;
			_states.gotoAndStop(1); // fix the MovieClip and stop this frame in the first frame.
			if ( _states != null && _set.size() > 0 )
			{
				size = ar.length ;
				while(--size > -1)
				{
					addEventListener( ar[size], refreshState , false, 0, true )	;
				}
				addChild(_states) ;
			}
		}

		/**
		 * Registers the ButtonEvent type passed in argument.
		 */
		public function registerType( type:String ):void
		{
			var b:Boolean = _set.insert( type ) ;
			if ( b && states != null)
			{
				addEventListener( type , refreshState ) ;
			}
		}
		
		/**
		 * Unregisters the ButtonEvent type passed in argument.
		 */
		public function unregisterType( type:String ):void
		{
			if ( type in ButtonEvent && _set.contains( type ) )
			{
				_set.remove( type ) ;
				if ( states != null )
				{
					removeEventListener( type , refreshState ) ;
				}
			}
		}		

		/**
		 * @private
		 */
		private var _states:MovieClip ;
		
		/**
		 * @private
		 */
		private var _set:HashSet ;

		/**
		 * Invoked when the view of the button is refresh.
		 */
		protected function refreshState( e:Event ):void 
		{
			var type:String = e.type ;
			if (states != null )
			{
				var noExistFrameLabel:Function = function( element:*, index:int, ar:Array ):Boolean
				{
				    return (element as FrameLabel).name != type ;
				} ;
				if ( !states.currentLabels.every( noExistFrameLabel , this ) )
				{
					states.gotoAndStop( e.type ) ;
				}
			}
			else
			{
				states.gotoAndStop(1) ;
			}
		}
		
	}

}
