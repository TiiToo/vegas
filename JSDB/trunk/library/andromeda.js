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

try 
{

	var dummy = andromeda ;

} 
catch(e) 
{

	/**
	 * Defined NameSpaces.
	 */
	getNamespace("andromeda") ;
	getNamespace("andromeda.controller") ;
	getNamespace("andromeda.events") ;
	getNamespace("andromeda.ioc") ;
	getNamespace("andromeda.model") ;
	getNamespace("andromeda.model.array") ;
	getNamespace("andromeda.model.map") ;
	getNamespace("andromeda.process") ;	

	/**
	 * andromeda.controller
	 */
	require("andromeda.controller.AbstractController") ;
	require("andromeda.controller.IController") ;
	
	/**
	 * andromeda.events
	 */
	require("andromeda.events.ActionEvent") ;	
	require("andromeda.events.ModelObjectEvent") ;

	/**
	 * andromeda.model
	 */ 
	require("andromeda.model.AbstractModel") ;
	require("andromeda.model.AbstractModelObject") ;
	require("andromeda.model.AbstractValueObject") ;
	require("andromeda.model.IModel") ;
	require("andromeda.model.IModelObject") ;
	require("andromeda.model.IValueObject") ;
	require("andromeda.model.ModelCollector") ;
	require("andromeda.model.SimpleValueObject") ;

	/**
	 * andromeda.model.array
	 */ 
	require("andromeda.model.array.PageableArrayModel") ;
	
	/**
	 * andromeda.model.map
	 */ 
	require("andromeda.model.map.MapModel") ;
	
	/**
	 * pegas.process
	 */ 
	require("andromeda.process.AbstractAction") ;
	require("andromeda.process.IAction") ;
	require("andromeda.process.Message") ;
	require("andromeda.process.Pause") ;
	require("andromeda.process.Sequencer") ;
	require("andromeda.process.SimpleAction") ;
	

}