/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2011
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

package examples 
{
    import system.date.DateEvaluator;
    import system.evaluators.EdenEvaluator;
    
    import vegas.net.FlashVars;
    
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    /**
     * Test the vegas.net.FlashVars class.
     * Launchs this example in the deploy/FlashVars.html page
     */
    public class FlashVarsExample extends Sprite 
    {
        public function FlashVarsExample()
        {
            // field
            
            var field:TextField = new TextField() ;
            
            field.defaultTextFormat = new TextFormat("Arial", 11 , 0xFFFFFF) ;
            field.multiline = true ;
            field.wordWrap  = true ;
            field.width     = 658  ;
            field.height    = 312  ;
            field.x         =  41  ;
            field.y         =  74  ;
            
            addChild( field ) ;
            
            // stage
            
            stage.scaleMode = "noScale" ;
            
            // example
            
            var flashVars:FlashVars = new FlashVars( this ) ; // register the FlashVars of the application
            
            var txt:String = "test FlashVars \r" ;
            
            // true ( if the flash vars exist )
            txt += "flashVars.contains('test') : " + flashVars.contains( "test" ) + "\r" ;
            
            // "test" (null if not exist).
            txt += "flashVars.getValue('test') : " + flashVars.getValue("test") + "\r" ; 
            
            field.text = txt ;
            
            // 12.06.2006 16:12:24 (null if not exist).
            txt += "flashVars.getValue('date', new EdenEvaluator(false), new DateEvaluator()) : " + flashVars.getValue("date", new EdenEvaluator(false), new DateEvaluator()) + "\r" ; 
            
            field.text = txt ;
        }
    }
}
