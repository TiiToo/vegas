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
    import vegas.date.Calendar;
    
    import flash.display.Sprite;
    
    public class CalendarExample extends Sprite 
    {
        public function CalendarExample()
        {
        trace ("----- after and before") ;
        
        var d1:Date = new Date(2005, 2, 15) ;
        var d2:Date = new Date() ;
        
        trace ("d1 : " + d1) ;
        trace ("d2 : " + d2) ;
        
        trace ("> d1 after d2  : " + Calendar.after  ( d1 , d2 ) ) ; // false
        trace ("> d2 after d1  : " + Calendar.after  ( d2 , d1 ) ) ; // true
        trace ("> d1 before d2 : " + Calendar.before ( d1 , d2 ) ) ; // true
        trace ("> d1 format    : " + Calendar.format ( d1 , "dd/mm/yyyy HH' h' nn' mn' ss' s'")) ;
        
        trace ("----- getDaysInMonth") ;
        
        var count:Number = Calendar.getDaysInMonth( new Date(2005, 11) ) ;
        trace ("> days in month 2005/12 : " + count) ; // 31
        
        trace ("----- getFirstDay") ;
        
        var first:String = Calendar.getFirstDay( new Date(2005, 11), true) ;
        trace ("> first day 2005/12 : " + first) ;
        
        trace ("----- getFullMonthCalendar") ;
        
        var full:Array = Calendar.getFullMonthCalendar( new Date(2005, 11) ) ;
        trace ("> full calendar 2005/12 : " + full) ;
        
        trace ("----- getNextMonth and getPreviousMonth") ;
        
        var next:Date = Calendar.getNextMonth() ;
        trace("> getNextMonth     : " + next) ;
        
        var previous:Date = Calendar.getPreviousMonth() ;
        trace("> getPreviousMonth : " + previous) ;
        
        
        trace ("-----") ;
        
        var isEnd:Boolean ;
        
        isEnd = Calendar.isEndOfMonth() ;
        trace ("> days " + Calendar.format( null, "yyyy-mm-dd") + " is end  : " + isEnd ) ;
        
        isEnd = Calendar.isEndOfMonth( new Date(2007,2,31) ) ;
        trace ("> days " + Calendar.format( new Date(2007,2,31) , "yyyy-mm-dd" ) + " is end  : " + isEnd ) ;
        
        trace ("----- yesterday and tomorrow") ;
        
        trace ( "yesterday : " + Calendar.format( Calendar.yesterday() ,"DDDD yyyy-mm-dd" ) ) ;
        trace ( "toDay     : " + Calendar.format( new Date() , "DDDD yyyy-mm-dd" ) ) ;
        trace ( "tomorrow  : " + Calendar.format( Calendar.tomorrow() , "DDDD yyyy-mm-dd" ) ) ;
        
        
        trace ("----- add method") ;
        
        var begin:Date = new Date( 2007, 5 , 14, 11, 30 , 0, 0  ) ;
        var end:Date   = Calendar.add( begin, Calendar.MINUTE , 10  ) ;
        
        trace( "start  : " + begin + " : " + Calendar.format(begin , "MM dd yyyy HH:nn:ss") ) ;
        trace( "finish : " + end   + " : " + Calendar.format(end   , "MM dd yyyy HH:nn:ss") ) ;
        
        trace ("----- remove method") ;
        
        begin = end ;
        end   = Calendar.subtract( begin, Calendar.MINUTE , 10  ) ;
        
        trace( "start  : " + begin + " : " + Calendar.format(begin , "MM dd yyyy HH:nn:ss") ) ;
        trace( "finish : " + end   + " : " + Calendar.format(end   , "MM dd yyyy HH:nn:ss") ) ;
        }
    }
}
