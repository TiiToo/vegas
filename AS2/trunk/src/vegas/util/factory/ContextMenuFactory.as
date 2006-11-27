/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.events.Delegate;

/**
 * @author eKameleon
 */
class vegas.util.factory.ContextMenuFactory 
{
	
	static public function createItemURL(label:String, url:String, target:String, separator:Boolean):ContextMenuItem 
	{
		var f:Function = Delegate.create(ContextMenuFactory, _getURL, url, target) ;
		var c:ContextMenuItem = new ContextMenuItem(label, f) ;
		c.separatorBefore = separator ;
		return c ;
	}
	
	static public function createItemProxy( label:String, scope , method:Function, separator:Boolean , args:Array):ContextMenuItem 
	{
		var c:ContextMenuItem = new ContextMenuItem(label, Delegate.create.apply(null, [scope, method].concat(args)) ) ;
		c.separatorBefore = separator ;
		return c ;
	}
	
	static private function _getURL(target, item, url:String, where:String) 
	{
		getURL(url, where || "_blank") ;	
	}
	
}