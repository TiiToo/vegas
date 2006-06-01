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

/** LineFormattedTarget

	AUTHOR
	
		Name : LineFormattedTarget
		Package : vegas.logging.targets
		Version : 1.0.0.0
		Date :  2005-12-10
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
		
		- filters:Array
		
			In addition to the level setting, filters are used to provide a pseudo hierarchical 
			mapping for processing only those events for a given category.
		
		- includeCategory:Boolean
		
			Indicates if the category for this target should added to the trace.
		
		- includeDate:Boolean
		
			Indicates if the date should be added to the trace.
		
		- includeLevel:Boolean
		
			Indicates if the level for the event should added to the trace.
		
		- includeLines:Boolean
		
			Indicates if a line number should be added to the trace.
		
		- includeTime:Boolean
		
			Indicates if the time should be added to the trace.

		- level:Number
		
			Provides access to the level this target is currently set at.

	METHOD SUMMARY
	
		- addLogger(logger:ILogger):Void
		
			Sets up this target with the specified logger.
			
			NOTE this method is called by the framework and should not be called by the developer.
		
		- addNamespace(namespace:String):Boolean
		
		- handleEvent(event:Event) : Void
		
			This method handles a LogEvent from an associated logger.
		
		- logEvent(e:LogEvent):Void
		
			Override this method.
		
		- removeLogger(logger:ILogger):Void
		
			Stops this target from receiving events from the specified logger.
			
			NOTE this method is called by the framework and should not be called by the developer.
		
		- removeNamespace(namespace:String):Boolean
		
		- toString():String

	INHERIT 
	
		CoreObject → AbstractTarget → LineFormattedTarget
		
	IMPLEMENTS
	
		EventListener, ITarget, IFormattable, IHashable

**/	

import vegas.logging.AbstractTarget;

class vegas.logging.targets.LineFormattedTarget extends AbstractTarget {
	
	// ----o Constructor
	
	public function LineFormattedTarget() {
		//
	}
	
	// ----o Public Properties
	
	public var includeCategory:Boolean ;
	
	public var includeDate:Boolean ;
	
	public var includeLevel:Boolean ;
	
	public var includeLines:Boolean ; 
	
	public var includeTime:Boolean ;

}