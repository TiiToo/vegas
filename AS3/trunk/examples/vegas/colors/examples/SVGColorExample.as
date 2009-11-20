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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com> 
*/

package examples 
{
    import vegas.colors.SVGColor;
    
    import flash.display.Sprite;
    
    public class SVGColorExample extends Sprite 
    {
        public function SVGColorExample()
        {
            var c:SVGColor ;
            
            c = SVGColor.ALICE_BLUE ;
            trace(c.toString() + " : " + c.valueOf()) ;
            
            trace( "---------" ) ;
            
            c  = SVGColor.YELLOW ;
            trace(c.toString() ) ;
            
            trace( "---------" ) ;
            
            var c1:SVGColor = SVGColor.PURPLE ;
            var c2:SVGColor = SVGColor.get("purple") ;
            
            trace( c1 == c2 ) ;
            
            trace( "---------" ) ;
            
            trace( "contains 'YELLOW' : " + SVGColor.contains( SVGColor.YELLOW ) ) ;
            trace( "contains 'yellow' : " + SVGColor.contains( "yellow" ) ) ;
            
            trace("---------") ;
            
            trace( "SVGColor.ELEMENTS size : " + SVGColor.ELEMENTS.size() ) ;
            trace( "SVGColor.ELEMENTS      : " + SVGColor.ELEMENTS ) ;
        }
    }
}
