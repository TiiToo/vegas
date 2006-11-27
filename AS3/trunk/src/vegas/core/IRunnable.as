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

package vegas.core
{

	/**
	 * The IRunnable interface should be implemented by any class whose instances are intended to be executed by a "thread".
	 * The class must define a method of no arguments called run.
	 * @author eKameleon
	 * @version 1.0.0.0
	 */	
	public interface IRunnable
	{
	
		/**
		 * Run the command.
		 */
		function run( ...arguments:Array ):void ;
	
	}

}