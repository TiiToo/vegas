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

import vegas.logging.AbstractTarget;

/**
 * All logger target implementations that have a formatted line style output should extend this class. It provides default behavior for including date, time, category, and level within the output.
 * @author eKameleon
 */
class vegas.logging.targets.LineFormattedTarget extends AbstractTarget 
{
	
	/**
	 * Creates a new LineFormattedTarget instance.
	 */
	public function LineFormattedTarget() 
	{
		//
	}

	/**
	 * Indicates if the category for this target should added to the trace.
	 */
	public var includeCategory:Boolean ;
	
	/**
	 * Indicates if the date should be added to the trace.
	 */
	public var includeDate:Boolean ;
	
	/**
	 * Indicates if the level for the event should added to the trace.
	 */
	public var includeLevel:Boolean ;
	
	/**
	 * Indicates if a line number should be added to the trace.
	 */
	public var includeLines:Boolean ; 
	
	/**
	 * Indicates if the time should be added to the trace.
	 */
	public var includeTime:Boolean ;

}