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
	
	METHOD SUMMARY
	
		- after(d:Date):Boolean
		
			true if the current time of this Calendar is after the time of Calendar when; false otherwise.
		
		- before(d:Date):Boolean
		
			true if the current time of this Calendar is before the time of Calendar when; false otherwise.
		
		- clone():Calendar
		
		- equals(o):Boolean
		
		- format(pattern:String):String
		
		- getCurrentFullMonthCalendar():Array
		
		- static getDaysInMonth(y:Number, m:Number):Number
		
		- static getFirstDay(y:Number , m:Number, nameFlag:Boolean)
		
		- static getFullMonthCalendar(y:Number, m:Number):Array
		
		- toSource():String
	
	INHERIT
	
		Date

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

	// ----o Public Methods
	
	public function after(d:Date):Boolean {
		return d.getTime() < getTime() ;
	}
	
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

	public function hashCode():Number {
		return null ;
	}

	public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [Serializer.toSource(valueOf())]) ;
	}

	// ----o Init HashCode
	
	static private var _initHashCode:Boolean = HashCode.initialize(Calendar.prototype) ;

}