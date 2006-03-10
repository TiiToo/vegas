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

/* -------- ITarget [Interface]

	AUTHOR

		Name : ITarget
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2005-10-12
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- filters:Array
		
			In addition to the level setting, filters are used to provide a pseudo hierarchical 
			mapping for processing only those events for a given category.
		
		- level:Number
		
			Provides access to the level this target is currently set at.


	METHOD SUMMARY
	
		- addLogger(logger:ILogger):Void
		
			Sets up this target with the specified logger.
			
			NOTE this method is called by the framework and should not be called by the developer.
		
		- handleEvent(e:Event) 
		
		- removeLogger(logger:ILogger):Void
		
			Stops this target from receiving events from the specified logger.
			
			NOTE this method is called by the framework and should not be called by the developer.
	
	INHERIT
	
		EventListener > ITarget
	
------------*/

import vegas.events.EventListener;
import vegas.logging.ILogger;

interface vegas.logging.ITarget extends EventListener {

	// ----o Public Properties

	// var filters:Array ;
	
	// var level:Number ;
	
	// ----o Public Methods
	
	function addLogger(logger:ILogger):Void ;
	
	// function handleEvent(e:Event) ;
	
	function removeLogger(logger:ILogger):Void ;
	

}