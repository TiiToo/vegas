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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

// TODO il faut rajouter des erreurs en cas de date invalide
// TODO il faut finir la localization 

import asgard.date.DateFormatter;
import asgard.date.LocalDate;

import vegas.core.HashCode;
import vegas.core.ICloneable;
import vegas.core.ICopyable;
import vegas.core.IEquality;
import vegas.core.IFormattable;
import vegas.core.IHashable;
import vegas.core.ISerializable;
import vegas.util.serialize.Serializer;

/**
 * This class contains all tools to creates a calendar.
 * <p><b>Example :</b></p>
 * {@code
 * import asgard.date.Calendar ;
 * 
 * var c1:Calendar = new Calendar(2005, 2, 15) ;
 * trace ("c1 getTime : " + c1.getTime()) ;
 * trace ("c1 toSource : " + c1.toSource()) ;
 * var c2:Calendar = new Calendar() ;
 * 
 * trace ("-- c1 : " + c1) ;
 * trace ("-- c2 : " + c2) ;
 * 
 * trace ("> c1 after c2 : " + c1.after(c2)) ;
 * trace ("> c2 after c1 : " + c2.after(c1)) ;
 * trace ("> c1 before c2 : " + c1.before(c2)) ;
 * 
 * trace ("> c1 format : " + c1.format("dd/mm/yyyy HH' h' nn' mn' ss' s'")) ;
 * 
 * var clone:Calendar = c1.clone() ;
 * trace ("-- c1 clone : " + clone) ;
 * trace ("> c1 equals clone : " + c1.equals(clone)) ;
 * 
 * trace ("-----") ;
 * var count:Number = Calendar.getDaysInMonth(2005, 11) ;
 * trace ("> days in month 2005/12 : " + count) ;
 * var first:String = Calendar.getFirstDay(2005, 11, true) ;
 * trace ("> first day 2005/12 : " + first) ;
 * 
 * var fc:Array = Calendar.getFullMonthCalendar(2005, 11) ;
 * trace ("> full calendar 2005/12 : " + fc) ;
 * }
 * @author eKameleon
 */
class asgard.date.Calendar extends Date implements ICloneable, ICopyable, IEquality, IFormattable, IHashable, ISerializable 
{

	/**
	 * Creates a new Calendar instance.
	 */
	public function Calendar(yearOrTimevalue:Number, month:Number, date:Number, hour:Number, minute:Number, second:Number, millisecond:Number) 
	{
		super(yearOrTimevalue, month, date, hour, minute, second, millisecond) ;
	}

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

	/**
 	 * Adds the specified amount of time to the this instance.
	 * @param date The Date object to perform addition on
	 * @param field The this field constant to be used for performing addition.
	 * @param amount The number of units (measured in the field constant) to add to the date.
	 * @return the new {@code Date} object.
	 */
	static public function add(date:Date, field:String, amount:Number):Date 
	{
		var d:Date = new Date(date.getTime());
		switch (field) 
		{
			case Calendar.MONTH :
			{
				var newMonth:Number = date.getMonth() + amount;
				var years:Number = 0;
				if (newMonth < 0) 
				{
					while (newMonth < 0) 
					{
						newMonth += 12;
						years -= 1 ;
					}
				}
				else if (newMonth > 11) 
				{
					while (newMonth > 11) 
					{
						newMonth -= 12;
						years += 1;
					}
				}
				d.setMonth(newMonth) ;
				d.setFullYear(date.getFullYear() + years) ;
				break ;
			}
			case Calendar.DAY :
			{
				d.setDate(date.getDate() + amount) ;
				break;
			}
			case Calendar.YEAR :
			{
				d.setFullYear(date.getFullYear() + amount) ;
				break;
			}
			case Calendar.WEEK :
			{
				d.setDate(date.getDate() + 7);
				break;
			}
		}
		return d ;
	}
	
	/**
	 * Returns {@code true} if the current time of this Calendar is after the time of Calendar when; false otherwise.
	 * @return {@code true} if the current time of this Calendar is after the time of Calendar when; false otherwise.
	 */
	public function after(d:Date):Boolean 
	{
		return d.getTime() < getTime() ;
	}

	/**
	 * Returns {@code true} if the current time of this Calendar is before the time of Calendar when; false otherwise.
	 * @return {@code true} if the current time of this Calendar is before the time of Calendar when; false otherwise. 
	 */
	public function before(d:Date):Boolean 
	{
		return d.getTime() > getTime() ;
	}
	
	/**
	 * Returns the shallow copy of this object.
	 * @return the shallow copy of this object.
	 */
	public function clone() 
	{
		return new Calendar(valueOf()) ;
	}
	
	/**
	 * Returns the deep copy of this object.
	 * @return the deep copy of this object.
	 */
	public function copy() 
	{
		return new Calendar(valueOf()) ;
	}
	
	/**
	 * Compares the specified object with this object for equality.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	public function equals(o):Boolean 
	{
		return o instanceof Date && o.valueOf() == valueOf() ;
	}

	/**
	 * Format the current Calendar date.
	 * @return the format string representation of the current Calendar date.
	 */
	public function format(pattern:String):String 
	{
		return (new DateFormatter(pattern)).format(this) ;
	}

	/**
	 * Returns the array representation of all days in the current month.
	 * @return the array representation of all days in the current month.
	 */
	static public function getCurrentFullMonthCalendar():Array 
	{
		var d:Date = new Date() ;
		return getFullMonthCalendar(d.getFullYear(), d.getMonth()) ;
	}

	/**
	 * Returns the numbers of days in a specified month.
	 */
	static public function getDaysInMonth(y:Number, m:Number):Number 
	{
		var monthDays:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31] ;
		if (((y%4 == 0) && !(y%100 == 0) ) || (y%400 == 0)) 
		{
			monthDays[1] = 29 ;
		}
		return monthDays[m] ;
	}

	/**
	 * Calculates the number of days the specified date is from January 1 of the specified calendar year.
	 * Passing January 1 to this function would return an offset value of zero.
	 * @param date The Date for which to find the offset
	 * @param calendarYear The calendar year to use for determining the offset
	 * @return The number of days since January 1 of the given year
	 */
	static public function getDayOffset(date:Date, calendarYear:Number):Number 
	{
		var beginYear = Calendar.getJan1(calendarYear); // Find the start of the year. This will be in week 1.
		return Math.ceil( (date.getTime() - beginYear.getTime()) / Calendar.ONE_DAY_MS );
	}

	/**
	 * Returns the first day in the specified month.
	 * @return the first day in the specified month.
	 */
	static public function getFirstDay(y:Number , m:Number, nameFlag:Boolean) 
	{
		var d:Number = (new Date (y, m)).getDay() ;
		return nameFlag ? LocalDate.getDays()[d] : d ;
	}
	
	/**
	 * Returns an array representation of a full month.
	 * @return an array representation of a full month.
	 */
	static public function getFullMonthCalendar(y:Number, m:Number):Array 
	{
		var min:Number = getFirstDay (y , m) ;
		var max:Number = min + getDaysInMonth (y, m) ;
		var ar:Array = new Array () ;
		for (var i:Number = 0 ; i < max ; i++) 
		{
			ar[i] = (i < min) ? null : (i - min + 1) ;
		}
		return ar ;
	}

	/**
	 * Retrieves a Date object representing January 1 of any given year.
	 * @param calendarYear	The calendar year for which to retrieve January 1
	 * @return January 1 of the calendar year specified.
	 */
	static public function getJan1(calendarYear:Number):Date 
	{
		return new Date(calendarYear, 0, 1) ; 
	}
	
	/**
	 * Returns the {@code Date} of the next month of the specified {@code Date} object.
	 * @return the {@code Data} of the next month of the specified {@code Date} object.
	 */
	static public function getNextMonth( date:Date ):Date
	{
		var today:Date = ( date == undefined) ? new Date() : date ;
		var thisMonth:Number = today.getMonth() ;
		if( thisMonth < 11 )
		{
			today.setMonth(thisMonth + 1) ;
		}
		else
		{
			today.setMonth(0);
			today.setFullYear(today.getFullYear() + 1);
		}
		return today ;
	}

	/**
	 * Returns the {@code Date} of the previous month of the specified {@code Date} object.
	 * @return the {@code Date} of the previous month of the specified {@code Date} object.
	 */
	public static function getPreviousMonth( date:Date ):Date
	{
		var today:Date = ( date == undefined) ? new Date() : date ;
		var thisMonth:Number = today.getMonth();
		if(thisMonth > 0)
		{
			today.setMonth(thisMonth - 1);
		}
		else
		{
			today.setMonth(11);
			today.setFullYear(today.getFullYear() - 1);
		}
		return today;
	}

	/**
	* Calculates the week number for the given date. This function assumes that week 1 is the 
	* week in which January 1 appears, regardless of whether the week consists of a full 7 days.
	* The calendar year can be specified to help find what a the week number would be for a given date if the date overlaps years. 
	* For instance, a week may be considered week 1 of 2005, or week 53 of 2004. 
	* Specifying the optional calendarYear allows one to make this distinction easily.
	* @param date The date for which to find the week number
	* @param calendarYear (optional) The calendar year to use for determining the week number. Default is the calendar year of parameter "date".
	* @param weekStartsOn (optional) The integer (0-6) representing which day a week begins on. Default is 0 (for Sunday).
	* @return The week number of the given date.
	*/
	static public function getWeekNumber(date:Date, calendarYear:Number, weekStartsOn:Number):Number 
	{
		if (isNaN(weekStartsOn)) weekStartsOn = 0 ;
		if (isNaN(calendarYear)) calendarYear = date.getFullYear();
		
		var weekNum:Number = -1 ;
		
		var jan1:Date = Calendar.getJan1(calendarYear);
		var jan1DayOfWeek:Number = jan1.getDay() ;
		
		var month:Number = date.getMonth();
		var day:Number = date.getDate();
		var year:Number = date.getFullYear();
		
		var dayOffset:Number = Calendar.getDayOffset(date, calendarYear); // Days since Jan 1, Calendar Year
			
		if (dayOffset < 0 && dayOffset >= (-1 * jan1DayOfWeek)) 
		{
			weekNum = 1;
		}
		else
		{
			weekNum = 1;
			var testDate:Date = Calendar.getJan1(calendarYear);
			while (testDate.getTime() < date.getTime() && testDate.getFullYear() == calendarYear) 
			{
				weekNum += 1;
				testDate = Calendar.add(testDate, Calendar.WEEK, 1);
			}
		}
		
		return weekNum;
	};

	/**
	 * Returns {@code true} if the current or specified {@code Date} if the last day in the current or specified month.
	 * @return {@code true} if the current or specified {@code Date} if the last day in the current or specified month.
	 */
	static public function isEndOfMonth( date:Date ):Boolean
	{
		var today:Date = (date == undefined) ? new Date() : date ;
		var y:Number = today.getYear() ;
		var m:Number = today.getMonth() ;
		var lastDate:Number = getDaysInMonth( y , m ) ; 
		return today.getDate().valueOf() == lastDate.valueOf() ;
	}

	/**
	 * Returns the hashcode representation of this object.
	 * @return the hashcode representation of this object.
	 */
	public function hashCode():Number 
	{
		return null ;
	}

	/**
	 * Registers this object to be use with AMF protocol. Use this method with Flash remoting class mapping for example.
	 */
	static public function register( registerName:String ):Void
	{
		Object.registerClass( registerName || "Calendar", Calendar) ;
	}

	/**
	* Subtracts the specified amount of time from the this instance.
	* @param date The Date object to perform subtraction on
	* @param field	The this field constant to be used for performing subtraction.
	* @param amount	The number of units (measured in the field constant) to subtract from the date.
	* @return the new Date object.
	*/
	static public function subtract(date:Date, field:String, amount:Number):Date 
	{
		return Calendar.add(date, field, (amount*-1));
	}

	/**
	 * Returns the Eden string representation of this object.
	 * @return the Eden string representation of this object.
	 */
	public function toSource(indent:Number, indentor:String):String 
	{
		return Serializer.getSourceOf(this, [Serializer.toSource(valueOf())]) ;
	}

	static private var _initHashCode:Boolean = HashCode.initialize(Calendar.prototype) ;

}