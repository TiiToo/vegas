﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.display.button 
{
	import flash.display.Shape;
	
	import lunas.core.AbstractButton;	

	/**
	 * This AquaButton class defines a button component with a aqua effect inside.
	 * @author eKameleon
	 */
	public class AquaButton extends AbstractButton 
	{

		/**
		 * Creates a new AquaButton instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
	 	 */	
		public function AquaButton(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			super( id, isConfigurable, name );
		}

		/**
	     * The background of the button.
	     */
    	public var background:Shape ;		

		/**
		 * The min height size of the component.
		 */
		public var minHeight:Number = 30 ;
		
		/**
		 * The min width size of the component.
		 */
		public var minWidth:Number = 30 ;
		
		/**
		 * Returns the constructor function of the {@code IBuilder} of this instance.
		 * @return the constructor function of the {@code IBuilder} of this instance.
		 */
		public override function getBuilderRenderer():Class
		{
			return AquaButtonBuilder ;
		}
		
		/**
		 * Returns the constructor of the IStyle of this instance.
		 * @return the constructor of the IStyle of this instance.
		 */
		public override function getStyleRenderer():Class
		{
			return AquaButtonStyle ;
		}
		
	    /**
	     * Invoked when the label change in the component.
	     */
    	public override function viewLabelChanged():void 
	    {
        	update() ;
    	}
    
		/**
		 * Invoked when the icon property is changed.
		 */
		public function viewIconChanged():void 
		{
			update() ;
		}  		
		
	    /**
     	 * Invoked when the style of the component is changed.
	     */
    	public override function viewStyleChanged():void 
    	{
	        update() ;
	    }
		
	}

}
