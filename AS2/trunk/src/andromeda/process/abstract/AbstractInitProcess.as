﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import pegas.process.SimpleAction;

/**
 * This Action lauch an initialize process.
 * @author ekameleon
 */
class andromeda.process.abstract.AbstractInitProcess extends SimpleAction 
{

	/**
	 * Creates a new AbstractRunFlashVars instance.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */	
	function AbstractInitProcess(bGlobal : Boolean, sChannel : String) 
	{
		super(bGlobal, sChannel);
	}
	
	/**
	 * Launch the initialize process in this method.
	 * Overrides this method.
	 */
	public function init():Void
	{
		// override
	}

	/**
	 * Run the process.
	 */
	public function run():Void
	{
		notifyStarted() ;		
		init() ;
		notifyFinished() ;	
	}
	
}