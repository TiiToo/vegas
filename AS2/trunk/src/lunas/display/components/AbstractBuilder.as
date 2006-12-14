/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import lunas.display.components.IBuilder;

import vegas.core.CoreObject;

/**
 * @author eKameleon
 */
class lunas.display.components.AbstractBuilder extends CoreObject implements IBuilder 
{
	
	private function AbstractBuilder( mc:MovieClip ) 
	{
		target = mc ;
	}

	public var target:MovieClip ;
	
	public function clear():Void 
	{
		// override
	}
	
	public function run():Void 
	{
		// override
	}

	public function getTarget():MovieClip 
	{
		return target ;
	}
	
	public function setTarget(t:MovieClip):Void 
	{
		target = t ;
	}
	
	public function update():Void 
	{
		// override
	}

}