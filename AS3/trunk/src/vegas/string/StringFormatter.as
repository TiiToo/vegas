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

package vegas.string
{
	import system.Strings;
	
	import vegas.util.AbstractFormatter;	

	/**
     * Replaces the pattern item in a specified String with the text equivalent of the value of a specified Object instance.
     * <p><b>Usage :</b></p>
     * <code>
     * import vegas.string.StringFormatter ;
     * 
     * var f:StringFormatter ;
     * var result:String ;
     * 
     * f = new StringFormatter() ;
     * f.pattern = "Brad's dog has {0,-4:_} fleas." ;
     * result = f.format(42) ;
     * trace (">> " + result) ;
     * 
     * f.pattern = "Brad's dog has {0,6:#} fleas.";
     * result = f.format(41) ;
     * trace (">> " + result) ;
     * 
     * f.pattern = "Brad's dog has {0,-8} fleas." ;
     * result = f.format(12) ;
     * trace (">> " + result) ;
     * 
     * f.pattern = "{3} {2} {1} {0}" ;
     * result = f.format("a", "b", "c", "d") ;
     * trace (">> " + result) ;
     * </code>
     * @author eKameleon
     */
	public class StringFormatter extends AbstractFormatter
	{

    	/**
    	 * Creates a new StringFormatter instance.
    	 * @param pattern the format pattern.
    	 */
		public function StringFormatter( pattern:String )
		{
			super( pattern ) ;
		}
		
		/**
	     * Format the pattern with all the arguments passed in this method.
	     * @return the new string representation of the pattern. 
	     */
		public override function format(...arguments:Array):String 
		{
			return Strings.format.apply(null, [pattern].concat(arguments)) ; 
		}
		
	}
}