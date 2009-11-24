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
  
*/
package examples 
{
    import vegas.date.Time;
    
    import flash.display.Sprite;
    
    public class TimeExample extends Sprite 
    {
        public function TimeExample()
        {
            var time:Time ;
            
            time = new Time( 12000 ) ;
            trace( time + " : " + time.getSeconds() + " seconds" ) ;
            trace( time + " : " + time.getMinutes(3) + " minutes" ) ;
            
            trace("---") ;
            
            var time1:Time = new Time( 2  , Time.DAY_FORMAT ) ;
            trace( "days         : " + time1.inDays() ) ;
            trace( "hours        : " + time1.inHours() ) ;
            trace( "minutes      : " + time1.inMinutes() ) ;
            trace( "seconds      : " + time1.inSeconds() ) ;
            trace( "milliseconds : " + time1.inMilliSeconds() ) ;
            
            trace("---") ;
            
            
            var time2:Time = new Time( 24 , Time.HOUR_FORMAT ) ;
            
            var time3:Time = time1.plus(time2) ; // + 24H
            trace( "days         : " + time3.inDays() ) ;
            trace( "hours        : " + time3.inHours() ) ;
            trace( "minutes      : " + time3.inMinutes() ) ;
            trace( "seconds      : " + time3.inSeconds() ) ;
            trace( "milliseconds : " + time3.inMilliSeconds() ) ;
        }
    }
}
