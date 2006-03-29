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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**	DateFormatter

	AUTHOR
	
		Name : DateFormatter
		Package : asgard.date
		Version : 1.0.0.0
		Date :  2005-09-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
	
		- DAY_AS_NUMBER : Placeholder for day in month as number in date format.
		
		- DAY_AS_TEXT : Placeholder for day in week as text in date format.
		
		- HOUR_IN_AM_PM : Placeholder for hour in am/pm (1 - 12) in date format.
		
		- HOUR_IN_DAY : Placeholder for hour in day (0 - 23) in date format.
		
		- MINUTE : Placeholder for minute in hour in date format.
		
		- MILLISECOND : Placeholder for millisecond in date format.

		- MONTH_AS_NUMBER : Placeholder for month in year as number in date format.
		
		- MONTH_AS_TEXT : Placeholder for month in year as text in date format.
		
		- RANGE_DAY_AS_TEXT
		
		- RANGE_DAY_AS_NUMBER
		
		- RANGE_HOUR
		
		- RANGE_MILLISECOND
		
		- RANGE_MINUTE
		
		- RANGE_MONTH
		
		- RANGE_SECOND
		
		- QUOTE : Quotation beginning and ending token. 

		- SECOND : Placeholder for second in minute in date format. 

		- YEAR : Placeholder for year in date format.

	PROPERTY SUMMARY
	
		- static DEFAULT_DATE_FORMAT:String
		
		- pattern:String [R/W]

	METHOD SUMMARY
	
		- format(date:Date):String
	
		- formatDayAsNumber(day:Number, cpt:Number):String
		
		- formatDayAsText(day:Number, cpt:Number):String
		
		- formatHourInAmPm(hour:Number, cpt:Number):String
		
		- formatHourInDay(hour:Number, cpt:Number):String
		
		- formatMillisecond(millisecond:Number, cpt:Number):String
		
		- formatMinute(minute:Number, cpt:Number):String
		
		- formatMonthAsNumber(month:Number, cpt:Number):String
		
		- formatMonthAsText(month:Number, cpt:Number):String
		
		- formatSecond(second:Number, cpt:Number):String
		
		- formatYear(year:Number, cpt:Number):String
		
		- getZeros(cpt:Number):String
	
		- getPattern():String
		
		- setPattern(pattern:String)
	
	INHERIT
	
		CoreObject
			|
			AbstractFormatter
	
	IMPLEMENT
	
		IFormatter, IFormattable, IHashable
	
	TODO : améliorer la gestion des erreurs des méthodes de cette classe.
	
----------  */

import asgard.date.LocalDate;

import vegas.errors.IllegalArgumentError;
import vegas.maths.Range;
import vegas.util.format.AbstractFormatter;

class asgard.date.DateFormatter extends AbstractFormatter {

	// ----o Construtor
	
	public function DateFormatter(p:String) {
		super(p || DEFAULT_DATE_FORMAT) ;
	}

	// ----o Static Property
	
	static public  var DEFAULT_DATE_FORMAT:String = "dd.mm.yyyy HH:nn:ss" ;
	
	// ----o CONSTANT
	
	static public var DAY_AS_NUMBER:String = "d";
	static public var DAY_AS_TEXT:String = "D";
	static public var HOUR_IN_AM_PM:String = "h";
	static public var HOUR_IN_DAY:String = "H";
	static public var MILLISECOND:String = "S";
	static public var MONTH_AS_NUMBER:String = "m";
	static public var MONTH_AS_TEXT:String = "M";
	static public var MINUTE:String = "n";
	static public var QUOTE:String = "'";
	static public var RANGE_DAY_AS_TEXT:Range = new Range(0, 6) ;
	static public var RANGE_HOUR:Range = new Range(0, 23) ;
	static public var RANGE_MINUTE:Range = new Range(0, 59) ;
	static public var RANGE_MILLISECOND:Range = new Range(0, 999) ;
	static public var RANGE_MONTH:Range = new Range(0, 11) ;
	static public var RANGE_SECOND:Range = new Range(0, 59) ;
	static public var SECOND:String = "s";
	static public var YEAR:String = "y";
	
	// ----o Public Methods
	
	public function format(o):String {
		if (!pattern) return "" ;
		var date:Date = (o instanceof Date) ? o : new Date() ;
		var p:String = getPattern() ;
		var a:Array = p.split("") ;
		var l:Number = a.length ;
		var cpt:Number ;
		var ch:String ; // current character
		var i:Number = -1 ;
		var r:String = "" ;
		while (++i < l) {
			ch = a[i] ;
			if (ch == DateFormatter.QUOTE) {
				if (a[i + 1] == DateFormatter.QUOTE) {
					r += "'" ; 
					i++ ;
				}
				var next:Number = i ;
				var prev:Number ;
				while (true) {
					prev = next ;
					next = p.indexOf("'", next + 1) ;
					if (a[next + 1] != QUOTE) break ;
					r += p.substring(prev+1, next+1) ;
					next++;
				}
				r += p.substring(prev+1, next) ;
				i = next ;
			} else if (ch == YEAR) {
				cpt = _count(ch, a.slice(i));
				r += formatYear(date.getFullYear(), cpt);
				i += cpt - 1 ;
			} else if (ch == MONTH_AS_NUMBER) {
				cpt = _count(ch, a.slice(i));
				r += formatMonthAsNumber(date.getMonth(), cpt);
				i += cpt - 1 ;
			} else if (ch == MONTH_AS_TEXT) {
				cpt = _count(ch, a.slice(i));
				r += formatMonthAsText(date.getMonth(), cpt) ;
				i += cpt - 1 ;
			} else if (ch == DAY_AS_NUMBER) {
				cpt = _count(ch, a.slice(i)) ;
				r += formatDayAsNumber(date.getDate(), cpt) ;
				i += cpt - 1 ;
			} else if (ch == DAY_AS_TEXT) {
				cpt = _count(ch, a.slice(i)) ;
				r += formatDayAsText(date.getDay(), cpt) ;
				i += cpt - 1 ;
			} else if (ch == HOUR_IN_AM_PM) {
				cpt = _count(ch, a.slice(i));
				r += formatHourInAmPm(date.getHours(), cpt) ;
				i += cpt - 1 ;
			} else if (ch == HOUR_IN_DAY) {
				cpt = _count(ch, a.slice(i));
				r += formatHourInDay(date.getHours(), cpt) ;
				i += cpt - 1 ;
			} else if (ch == MINUTE) {
				cpt = _count(ch, a.slice(i));
				r += formatMinute(date.getMinutes(), cpt) ;
				i += cpt - 1 ;
			} else if (ch == SECOND) {
				cpt = _count(ch, a.slice(i));
				r += formatSecond(date.getSeconds(), cpt) ;
				i += cpt - 1 ;
			} else if (ch == MILLISECOND) {
				cpt = _count(ch, a.slice(i));
				r += formatMillisecond(date.getMilliseconds(), cpt);
				i += cpt - 1 ;
			} else {
				r += ch;
			}
		} 
		return r ;
	}

	public function formatDayAsNumber(day:Number, cpt:Number):String {
		if (isNaN(cpt)) cpt = 0 ;
		var string:String = day.toString();
		return (getZeros(cpt - string.length) + string);
	}
	
	public function formatDayAsText(day:Number, cpt:Number):String {
		if (RANGE_DAY_AS_TEXT.isOutOfRange(day)) throw new IllegalArgumentError() ;
		if (isNaN(cpt)) cpt = 0 ;
		var days:Array = LocalDate.getDays() ;
		var r:String = days[day] ;
		if (cpt < 4) return r.substr(0, 2);
		return r ;
	}

	public function formatHourInAmPm(hour:Number, cpt:Number):String {
		if (RANGE_HOUR.isOutOfRange(hour)) throw new IllegalArgumentError() ;
		if (isNaN(cpt)) cpt = 0 ;
		var s:String ;
		if (hour == 0) s = (12).toString() ;
		else if (hour > 12) s = (hour - 12).toString() ;
		else s = hour.toString();
		return (getZeros(cpt - s.length) + s);
	}
	
	public function formatHourInDay(hour:Number, cpt:Number):String {
		if (RANGE_HOUR.isOutOfRange(hour)) throw new IllegalArgumentError() ;
		if (isNaN(cpt)) cpt = 0 ;
		var s:String = hour.toString();
		return (getZeros(cpt - s.length) + s) ;
	}

	public function formatMillisecond(millisecond:Number, cpt:Number):String {
		if (RANGE_MILLISECOND.isOutOfRange(millisecond)) throw new IllegalArgumentError() ;
		if (isNaN(cpt)) cpt = 0 ;
		var s:String = millisecond.toString();
		return (getZeros(cpt - s.length) + s) ;
	}

	public function formatMinute(minute:Number, cpt:Number):String {
		if (RANGE_MINUTE.isOutOfRange(minute)) throw new IllegalArgumentError() ;
		if (isNaN(cpt)) cpt = 0 ;
		var s:String = minute.toString();
		return (getZeros(cpt - s.length) + s);
	}
	
	public function formatMonthAsNumber(month:Number, cpt:Number):String {
		if (RANGE_MONTH.isOutOfRange(month)) throw new IllegalArgumentError() ;
		if (isNaN(cpt)) cpt = 0 ;
		var string:String = (month + 1).toString();
		return (getZeros(cpt - string.length) + string) ;
	}
	
	public function formatMonthAsText(month:Number, cpt:Number):String {
		if (RANGE_MONTH.isOutOfRange(month)) throw new IllegalArgumentError() ;
		if (isNaN(cpt)) cpt = 0 ;
		var r:String;
		var months:Array = LocalDate.getMonths() ;
		r = months[month] ;
		if (cpt < 4) return r.substr(0, 3);
		return r;
	}

	public function formatSecond(second:Number, cpt:Number):String {
		if (RANGE_SECOND.isOutOfRange(second)) throw new IllegalArgumentError() ;
		if (isNaN(cpt)) cpt = 0 ;
		var s:String = second.toString();
		return (getZeros(cpt - s.length) + s);
	}

	public function formatYear(year:Number, cpt:Number):String {
		if (isNaN(year)) throw new IllegalArgumentError() ;
		if (isNaN(cpt)) cpt = 0 ;
		if (cpt < 4) return year.toString().substr(2) ;
		return (getZeros(cpt - 4) + year.toString());
	}

	public function getZeros(cpt:Number):String {
		if (cpt < 1 || isNaN(cpt)) return "" ;
		if (cpt < 2) return "0" ;
		var r:String = "00";
		cpt -= 2;
		while (cpt) {
			r += "0" ;
			cpt-- ;
		}
		return r ;
	}
	
	// ----o Private Methods
	
	private function _count(char:String, a:Array):Number {
		if (!a) return 0 ;
		var r:Number = 0 ;
		var i:Number = -1 ;
		var l:Number = a.length ;
		while (++i < l && a[r] == char) r++ ;
		return r ;
	}


}