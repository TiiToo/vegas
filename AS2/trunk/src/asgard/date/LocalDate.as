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

/**	LocalDate

	AUTHOR
	
		Name : LocalDate
		Package : asgard.date
		Version : 1.0.0.0
		Date :  2005-09-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	STATIC PROPERTIES
	
		Months
		
			- JANUARY : Fully written out string for january.
			
			- FEBRUARY : Fully written out string for february.
			
			- MARCH : Fully written out string for march.
			
			- APRIL : Fully written out string for april.
			
			- MAY : Fully written out string for may.
			
			- JUNE : Fully written out string for june.
			
			- JULY : Fully written out string for july.
			
			- AUGUST : Fully written out string for august.
			
			- SEPTEMBER : Fully written out string for september.
			
			- OCTOBER : Fully written out string for october.
			
			- NOVEMBER : Fully written out string for november.
			
			- DECEMBER : Fully written out string for december.
		
		Days
		
			- MONDAY : Fully written out string for monday.
			
			- TUESDAY : Fully written out string for tuesday.
			
			- WEDNESDAY : Fully written out string for wednesday.
			
			- THURSDAY : Fully written out string for thursday.
			
			- FRIDAY : Fully written out string for friday.
			
			- SATURDAY : Fully written out string for saturday.
			
			- SUNDAY : Fully written out string for sunday.


	STATIC METHODS
	
		- getDays():Array
		
		- getMonths():Array
	
----------  */

// TODO il faut finir la localization 

class asgard.date.LocalDate {

	// ----o Construtor
	
	private function LocalDate() {}
	
	// ---- Statics Properties
	
	static public var JANUARY:String = "January" ;
	static public var FEBRUARY:String = "February" ;
	static public var MARCH:String = "March" ;
	static public var APRIL:String = "April" ;
	static public var MAY:String = "May" ;
	static public var JUNE:String = "June" ;
	static public var JULY:String = "July" ;
	static public var AUGUST:String = "August" ;
	static public var SEPTEMBER:String = "September" ;
	static public var OCTOBER:String = "October" ;
	static public var NOVEMBER:String = "November" ;
	static public var DECEMBER:String = "December" ;
	
	static public var MONDAY:String = "Monday" ;
	static public var TUESDAY:String = "Tuesday" ;
	static public var WEDNESDAY:String = "Wednesday" ;
	static public var THURSDAY:String = "Thursday" ;
	static public var FRIDAY:String = "Friday" ;
	static public var SATURDAY:String = "Saturday" ;
	static public var SUNDAY:String = "Sunday" ;

	// ---- Static Methods
	
	static public function getDays():Array {
		return [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY] ;
	}
	
	static public function getMonths():Array {
		return [
			JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE,
			JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER
		] ;
	}

}