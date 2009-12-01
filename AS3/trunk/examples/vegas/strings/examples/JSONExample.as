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
    import system.Reflection;
    
    import vegas.strings.JSON;
    import vegas.strings.json.JSONError;
    
    import flash.display.Sprite;
    
    /**
     * Test the JSON singleton.
     */
    public class JSONExample extends Sprite 
    {
        public function JSONExample()
        {
            var a:Array   = [2, true, "hello"] ;
            var o:Object  = { prop1 : 1 , prop2 : 2 } ;
            var s:String  = "hello world" ;
            var n:Number  = 4 ;
            var b:Boolean = true ;
            
            trace("# Serialize \r") ;
            
            trace("- a : " + JSON.serialize( a ) )  ;
            trace("- o : " + JSON.serialize( o ) )  ;
            trace("- s : " + JSON.serialize( s ) )  ;
            trace("- n : " + JSON.serialize( n ) )  ;
            trace("- b : " + JSON.serialize( b ) )  ;
            
            trace ("\r# Deserialize \r") ;
            
            var source:String = '[ { "prop1" : 0xFF0000 , prop2:2, prop3:"hello", prop4:true} , 2, true, 3, [3, 2] ]' ;
            
            o = JSON.deserialize(source) ;
            
            var l:uint = o.length ;
            
            for (var i:uint = 0 ; i<l ; i++) 
            {
                trace("# " + i + " # " + o[i] + " type " + Reflection.getClassName(o[i]) ) ;
                if (typeof(o[i]) == "object") 
                {
                    for (var each:String in o[i]) 
                    {
                        trace("    # " + each + " : " + o[i][each] + " :: " + Reflection.getClassName(o[i][each]) ) ;
                    }
                }
            }
            
            trace ("\r# JSONError \r") ;
            
            try
            {
                 JSON.deserialize( "[3, 2," ) ;
            }
            catch( er:JSONError )
            {
                 trace( er.toString() ) ;
            }
            
            try
            {
                 JSON.deserialize( '{"prop1":hello"}' ) ;
            }
            catch( er:JSONError )
            {
                 trace( er.toString() ) ;
            }
        }
    }
}
