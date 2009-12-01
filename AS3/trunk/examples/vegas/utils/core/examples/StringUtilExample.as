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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package examples 
{
    import vegas.utils.StringUtil;
    
    import flash.display.Sprite;
    
    public class StringUtilExample extends Sprite 
    {
        public function StringUtilExample()
        {
            var b1:Boolean = StringUtil.isEmpty("") ; // true
            var b2:Boolean = StringUtil.isEmpty("hello world") ; // false
            
            trace( "isEmpty '' : " + b1 ) ; // true
            trace( "isEmpty 'hello world' : " + b2 ) ; // false
            
            trace("----") ;
            
            trace( "'hello world' firstChar : " + StringUtil.firstChar("hello world") ) ; // d
            trace( "'hello world' lastChar  : " + StringUtil.lastChar("hello world") ) ; // d
            
            
            trace("---- StringUtil.reverse") ;
            
            trace( "hello reverse : " + StringUtil.reverse("hello") ) ; // hello reverse : olleh
            
            trace("----") ;
            
            var result:String ;
            
            result = StringUtil.splice("hello world", 0, 1, "H") ;
            trace(result) ; // Hello world
            
            result = StringUtil.splice("hello world", 6, 0, "life") ;
            trace(result) ; // hello lifeworld
            
            result = StringUtil.splice("hello world", 6, 5, "life") ;
            trace(result) ; // hello life
            
            trace("----") ;
            
            trace( StringUtil.ucFirst("hello world" )) ; // Hello world
            trace( StringUtil.ucWords("hello world" )) ; // Hello World
        }
    }
}
