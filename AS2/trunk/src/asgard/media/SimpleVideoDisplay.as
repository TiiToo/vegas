/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */
 
import asgard.media.AbstractVideoDisplay;

/**
 * This display control a Video object and this attached Sound object.
 * @author eKameleon
 */
class asgard.media.SimpleVideoDisplay extends AbstractVideoDisplay
{
	
	/**
	 * Creates a new SimpleVideoDisplay instance.
	 * If the target reference contains a {@ode Video} instance with the name "video", this object is used in the display.
	 * @param sName the name of the display.
	 * @param target the target of this display.
	 * @param (optional) the {@code Video} object of this display. 
	 */	
	public function SimpleVideoDisplay( sName:String, target:MovieClip, video:Video) 
	{
		super(sName, target, video);
	}

}