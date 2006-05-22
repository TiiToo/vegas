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

/**	Calendar

	AUTHOR
	
		Name : Calendar
		Package : asgard.date
		Version : 1.0.0.0
		Date :  2005-12-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new Calendar(yearOrTimevalue:Number, month:Number, date:Number, hour:Number, minute:Number, second:Number, millisecond:Number) ;
	
	CONSTANT SUMMARY
	
		- static DAY:String
		
		- static MONTH:String
		
		- static WEEK:String
		
		- static YEAR:String
	
		- static ONE_DAY_MS:Number
	
	METHOD SUMMARY
	
		- static add(date:Date, field:String, amount:Number):Date
	
		- after(d:Date):Boolean
		
		- before(d:Date):Boolean
		
		- clone():Calendar
		
		- equals(o):Boolean
		
		- format(pattern:String):String
		
		- getCurrentFullMonthCalendar():Array
		
		- static getDaysInMonth(y:Number, m:Number):Number
		
		- static getDayOffset(date:Date, calendarYear:Number):Number
		
		- static getFirstDay(y:Number , m:Number, nameFlag:Boolean)
		
		- static getFullMonthCalendar(y:Number, m:Number):Array
		
		- static getJan1(calendarYear:Number):Date
		
		- static getWeekNumber(date:Date, calendarYear:Number, weekStartsOn:Number):Number
		
		- static subtract(date:Date, field:String, amount:Number):Date
		
		- toSource():String
	
	INHERIT
	
		Date → Calendar

	IMPLEMENT
	
		ICloneable, IEquality

----------  */

// TODO il faut rajouter des erreurs en cas de date invalide
// TODO il faut finir la localization 

import asgard.date.DateFormatter;
import asgard.date.LocalDate;

import vegas.core.HashCode;
import vegas.core.ICloneable;
import vegas.core.IEquality;
import vegas.core.IFormattable;
import vegas.core.IHashable;
import vegas.core.ISerializable;
import vegas.util.serialize.Serializer;

class asgard.date.Calendar extends Date implements ICloneable, IEquality, IFormattable, IHashable, ISerializable {

	// ----o Construtor
	
	public function Calendar(yearOrTimevalue:Number, month:Number, date:Number, hour:Number, minute:Number, second:Number, millisecond:Number) {
		super(yearOrTimevalue, month, date, hour, minute, second, millisecond) ;
	}

	// ----o Constants
	
	/**
	* Constant field representing Day
	* @type String
	*/
	static public var DAY:String = "D" ;
	
	/**
	* Constant field representing Month
	* @type String
	*/	
	static public var MONTH:String = "M" ;
	
	/**
	* Constant field representing Week
	* @type String
	*/
	static public var WEEK:String = "W" ;
	
	/**
	* Constant field representing Year
	* @type String
	*/
	static public var YEAR:String = "Y" ;

	/**
	* Constant field representing one day, in milliseconds
	* @type Integer
	*/
	static public var ONE_DAY_MS:Number = 1000*60*60*24 ;

	static private var __ASPF__ = _global.ASSetPropFlags(Calendar, null , 7, 7) ;

	// ----o Public Methods

	/**
	* Adds the specified amount of time to the this instance.
	* @param {Date} date	The JavaScript Date object to perform addition on
	* @param {string} field	The this field constant to be used for performing addition.
	* @param {Integer} amount	The number of units (measured in the field constant) to add to the date.
	* @return {date}
	*/
	static public function add(date:Date, field:String, amount:Number):Date {
		var d:Date = new Date(date.getTime());
		switch (field) {
			case Calendar.MONTH:
				var newMonth:Number = date.getMonth() + amount;
				var years:Number = 0;
				if (newMonth < 0) {
					while (newMonth < 0) {
						newMonth += 12;
						years -= 1 ;
					}
				} else if (newMonth > 11) {
					while (newMonth > 11) {
						newMonth -= 12;
						years += 1;
					}
				}
				d.setMonth(newMonth) ;
				d.setFullYear(date.getFullYear() + years) ;
				break ;
			
			case Calendar.DAY:
				d.setDate(date.getDate() + amount) ;
				break;
			
			case Calendar.YEAR:
				d.setFullYear(date.getFullYear() + amount) ;
				break;
			
			case Calendar.WEEK :
				d.setDate(date.getDate() + 7);
				break;
		}
		return d ;
	}
	
	/**
	 * @return true if the current time of this Calendar is after the time of Calendar when; false otherwise.
	 */
	public function after(d:Date):Boolean {
		return d.getTime() < getTime() ;
	}

	/**
	 * @return true if the current time of this Calendar is before the time of Calendar when; false otherwise. 
	 */
	public function before(d:Date):Boolean {
		return d.getTime() > getTime() ;
	}
	
	public function clone() {
		return new Date(valueOf()) ;
	}
	
	public function equals(o):Boolean {
		return o instanceof Date && o.valueOf() == valueOf() ;
	}

	public function format(pattern:String):String {
		return (new DateFormatter(pattern)).format(this) ;
	}

	static public function getCurrentFullMonthCalendar():Array {
		var d:Date = new Date() ;
		return getFullMonthCalendar(d.getFullYear(), d.getMonth()) ;
	}

	static public function getDaysInMonth(y:Number, m:Number):Number {
		var monthDays:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31] ;
		if (((y%4 == 0) && !(y%100 == 0) ) || (y%400 == 0)) monthDays[1] = 29 ;
		return monthDays[m] ;
	}

	/**
	* Calculates the number of days the specified date is from January 1 of the specified calendar year.
	* Passing January 1 to this function would return an offset value of zero.
	* @param {Date}	date The JavaScript date for which to find the offset
	* @param {Integer} calendarYear	The calendar year to use for determining the offset
	* @return {Integer}	The number of days since January 1 of the given year
	*/
	static public function getDayOffset(date:Date, calendarYear:Number):Number {
		var beginYear = Calendar.getJan1(calendarYear); // Find the start of the year. This will be in week 1.
		return Math.ceil( (date.getTime() - beginYear.getTime()) / Calendar.ONE_DAY_MS );
	}

	static public function getFirstDay(y:Number , m:Number, nameFlag:Boolean) {
		var d:Number = (new Date (y, m)).getDay() ;
		return nameFlag ? LocalDate.getDays()[d] : d ;
	}
	
	static public function getFullMonthCalendar(y:Number, m:Number):Array {
		var min:Number = getFirstDay (y , m) ;
		var max:Number = min + getDaysInMonth (y, m) ;
		var ar:Array = new Array () ;
		for (var i:Number = 0 ; i < max ; i++) {
			ar[i] = (i < min) ? null : (i - min + 1) ;
		}
		return ar ;
	}

	/**
	* Retrieves a JavaScript Date object representing January 1 of any given year.
	* @param {Number} calendarYear	The calendar year for which to retrieve January 1
	* @return {Date} January 1 of the calendar year specified.
	*/
	static public function getJan1(calendarYear:Number):Date {
		return new Date(calendarYear, 0, 1) ; 
	}

	/**
	* Calculates the week number for the given date. This function assumes that week 1 is the
	* week in which January 1 appears, regardless of whether the week consists of a full 7 days.
	* The calendar year can be specified to help find what a the week number would be for a given
	* date if the date overlaps years. For instance, a week may be considered week 1 of 2005, or
	* week 53 of 2004. Specifying the optional calendarYear allows one to make this distinction
	* easily.
	* @param {Date}	date The date for which to find the week number
	* @param {Integer} calendarYear	OPTIONAL 
	* 	- The calendar year to use for determining the week number. Default is the calendar year of parameter "date".
	* @param {Integer} weekStartsOn	OPTIONAL - The integer (0-6) representing which day a week begins on. Default is 0 (for Sunday).
	* @return {Integer}	The week number of the given date.
	*/
	static public function getWeekNumber(date:Date, calendarYear:Number, weekStartsOn:Number):Number {
		if (isNaN(weekStartsOn)) weekStartsOn = 0 ;
		if (isNaN(calendarYear)) calendarYear = date.getFullYear();
		var weekNum = -1 ;
		
		var jan1:Date = Calendar.getJan1(calendarYear);
		var jan1DayOfWeek:Number = jan1.getDay() ;
		
		var month:Number = date.getMonth();
		var day:Number = date.getDate();
		var year:Number = date.getFullYear();
		
		var dayOffset = Calendar.getDayOffset(date, calendarYear); // Days since Jan 1, Calendar Year
			
		if (dayOffset < 0 && dayOffset >= (-1 * jan1DayOfWeek)) {
			weekNum = 1;
		} else {
			weekNum = 1;
			var testDate:Date = Calendar.getJan1(calendarYear);
			while (testDate.getTime() < date.getTime() && testDate.getFullYear() == calendarYear) {
				weekNum += 1;
				testDate = Calendar.add(testDate, Calendar.WEEK, 1);
			}
		}
		
		return weekNum;
	};

	public function hashCode():Number {
		return null ;
	}

	/**
	* Subtracts the specified amount of time from the this instance.
	* @param {Date} date	The JavaScript Date object to perform subtraction on
	* @param {Integer} field	The this field constant to be used for performing subtraction.
	* @param {Integer} amount	The number of units (measured in the field constant) to subtract from the date.
	* @return {date}
	*/
	static public function subtract(date:Date, field:String, amount:Number):Date {
		return Calendar.add(date, field, (amount*-1));
	};

	public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [Serializer.toSource(valueOf())]) ;
	}

	// ----o Init HashCode
	
	static private var _initHashCode:Boolean = HashCode.initialize(Calendar.prototype) ;

}