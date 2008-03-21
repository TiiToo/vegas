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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * This factory class creates and returns Event's object.
 * @author eKameleon
 */
if (vegas.util.factory.EventFactory == undefined) 
{
	
	/**
	 * Creates the EventFactory singleton.
	 */
	vegas.util.factory.EventFactory = {} ;

	/**
	 * Creates a new Event's object.
	 * @param o If this object is a {@code String} this value is the type of the new event or this argument is an Event object or a generic object to creates a new Event.
	 * @param target (optional) The scope of the target of the new Event.
	 * @param context (optional) The context of the new Event.
	 */
	vegas.util.factory.EventFactory.create = function (o, target /*EventTarget*/ , context /*Object*/) /*Event*/ 
	{
		
		var e /*Event*/ = null ;
		
		if (o instanceof vegas.events.Event) 
		{
			
			if (o.getTarget() == null) o.setTarget(target) ;
			if (context) o.setContext(context) ;
			e = o ;
			
		} 
		else if (vegas.util.TypeUtil.typesMatch(o, String)) 
		{
			
			e = new vegas.events.BasicEvent(o, target, context) ;
			
		} 
		else if (vegas.util.TypeUtil.typesMatch(o, Object)) 
		{
			
			if (o.type == undefined) return null ;
			
			e = new vegas.events.BasicEvent(o.type, o.target , o.context) ;
			
			if (target) e.setTarget(target) ;
			
			if (context) e.setContext(context) ;
			
		}
		
		if (!e.getCurrentTarget()) 
		{
			e.setCurrentTarget( e.getTarget() ) ;
		}
		
		return e ;
		
	}
	
}