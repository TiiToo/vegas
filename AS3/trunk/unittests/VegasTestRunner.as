﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package  
{
	import flash.display.Sprite;
	
	import buRRRn.ASTUce.Runner;
	import buRRRn.ASTUce.config;    

	/**
	 * The main VEGAS TestRunner launcher.
	 * @author eKameleon
	 */
	public class VegasTestRunner extends Sprite
	{
		
            public function VegasTestRunner()
            {

                // buRRRn.ASTUce.config.allowErrorTrace     = false ;
                // buRRRn.ASTUce.config.showPrinterDetails  = false ;
                // buRRRn.ASTUce.config.showPrinterShortTests = false ;
                
                buRRRn.ASTUce.config.allowStackTrace     = false ;
                buRRRn.ASTUce.config.maxColumn           = 62 ;
                buRRRn.ASTUce.config.showConstructorList = false ;
               
                // testing all.
                
                Runner.main( AllTests );

            
        }
	}
}
