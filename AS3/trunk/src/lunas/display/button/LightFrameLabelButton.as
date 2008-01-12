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
	import flash.display.MovieClip;
	
	import lunas.display.button.FrameLabelButton;
	import lunas.events.ButtonEvent;
	
	import pegas.colors.LightColor;
	import pegas.transitions.Motion;
	import pegas.transitions.Tween;	

	/**
	 * This LightFrameLabelButton is a button who use a LightColor motion to creates light effects when the button is over or click.
	 * @author eKameleon
	 */
	public class LightFrameLabelButton extends FrameLabelButton 
	{

		/**
		 * Creates a new LightFrameLabelButton instance.
		 * @param states the MovieClip reference with the state frames of this button.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function LightFrameLabelButton(states:MovieClip = null, id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			super( states , id , isConfigurable, name ) ;

			_light = new LightColor( this ) ;
			_tw    = new Tween(_light) ;	

			registerType( ButtonEvent.DISABLED , disabled ) ;
			registerType( ButtonEvent.DOWN     , down ) ;
			registerType( ButtonEvent.OVER     , over ) ;
		}
		
		/**
		 * Invoked when the button is down.
		 */
		public function disabled( e:ButtonEvent ):void
		{
			if ( _tw.running )
			{
				_tw.stop() ;	
			}
			_light.reset() ;
		}
		
		/**
		 * Invoked when the button is down.
		 */
		public function down( e:ButtonEvent ):void
		{
			if ( _tw.running )
			{
				_tw.stop() ;	
			}
			var s:LightFrameLabelButtonStyle = style as LightFrameLabelButtonStyle ;
			if ( s != null )
			{
				if ( s.useEasingSelected )
				{
					_tw.duration   = s.easingSelectedDuration ;
					_tw.useSeconds = s.easingSelectedUseSeconds ;
					_tw.insertProperty( s.easingSelectedProperty, s.easingSelected, s.easingSelectedBegin, s.easingSelectedFinish ) ;
					_tw.run() ;
				}
			}
		}
		
		/**
		 * Returns the IStyle Class of this instance.
		 * @return the IStyle Class of this instance.
	 	 */
		public override function getStyleRenderer():Class 
		{
			return LightFrameLabelButtonStyle ;
		}

		/**
		 * Invoked when the button is over.
		 */
		public function over( e:ButtonEvent ):void
		{
			if ( _tw.running )
			{
				_tw.stop() ;	
			}
			var s:LightFrameLabelButtonStyle = style as LightFrameLabelButtonStyle ;
			if ( s != null )
			{
				if ( s.useEasingOver )
				{
					_tw.duration   = s.easingOverDuration ;
					_tw.useSeconds = s.easingOverUseSeconds ;
					_tw.insertProperty( s.easingOverProperty, s.easingOver, s.easingOverBegin, s.easingOverFinish ) ;
					_tw.run() ;
				}
			}
		}
		
		/**
		 * @private
		 */
		private var _light:LightColor ;

		/**
		 * @private
		 */
		private var _tw:Tween ;
		
	}
}
