/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**	AbstractStepper

	AUTHOR
	
		Name : AbstractStepper
		Package : lunas.display.components.stepper
		Version : 1.0.0.0
		Date :  2006-02-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
		
		- maximum:Number [R/W]
		
		- minimum:Number [R/W]
		
		- nextValue:Number [Read Only]
		
		- previousValue:Number [Read Only]
		
		- stepSize:Number [R/W]
		
		- value:Number [R/W]
	
	METHODS
	
		- getNextValue()
		
		- getMaximum()
		
		- getMinimum()
		
		- getPreviousValue()
		
		- getStepSize()
		
		- getValue()
		
		- setMaximum(n:Number)
		
		- setMinimum(n:Number)
		
		- setStepSize(n:Number)
		
		- setValue (n:Number)

	INHERIT 
	
		MovieClip → AbstractComponent → AbstractStepper
	
	IMPLEMENTS
	
		IStepper
	
	TODO : A tester !!
	
**/

import lunas.display.components.AbstractComponent;
import lunas.display.components.IStepper;

import vegas.util.MathsUtil;

class lunas.display.components.stepper.AbstractStepper extends AbstractComponent implements IStepper {

	// ----o Constructor

	private function AbstractStepper () {
		//
	}

	// ----o Public Properties
	
	// public var maximum:Number ; // [R/W]
	// public var minimum:Number ; // [R/W]
	// public var nextValue:Number ; // [Read Only]
	// public var previousValue:Number ; // [Read Only]
	// public var stepSize:Number ; // [R/W]
	// public var value:Number ; // [R/W]

	// ----o Public Methods

	public function getMaximum():Number { 
		return _maximum ;
	}

	public function getMinimum():Number { 
		return _minimum  ;
	}

	public function getNextValue():Number { 
		return _value + _stepSize ;
	}

	public function getPreviousValue():Number { 
		return _value - _stepSize  ;
	}

	public function getStepSize():Number {
		return _stepSize ;
	}

	public function getValue():Number { 
		return _value  ;
	}

	public function setMaximum(n:Number):Void {
		_maximum = ( n < _minimum) ? _minimum : n ;
		if (_value > _maximum) _value = _maximum ;
		update() ;
	}

	public function setMinimum(n:Number):Void {
		_minimum = (n>_maximum) ? _maximum : n ;
		if (_value < _minimum) _value = _minimum ;
		update() ;
	}

	public function setStepSize(n:Number):Void {
		_stepSize = isNaN(n) ? 1 : n ;
	}

	public function setValue (n:Number):Void {
		_value = MathsUtil.clamp(n, _minimum, _maximum) ;
		update() ;
		notifyChanged() ;
	}

	// ----o Virtual Properties

	public function get maximum():Number {
		return 	getMaximum() ;
	}

	public function set maximum(n:Number):Void {
		setMaximum(n) ;
	}

	public function get minimum():Number {
		return 	getMinimum() ;
	}

	public function set minimum(n:Number):Void {
		setMinimum(n) ;
	}

	public function get nextValue():Number {
		return 	getNextValue() ;
	}

	public function get previousValue():Number {
		return getPreviousValue() ;	
	}

	public function get stepSize():Number {
		return 	getStepSize() ;
	}

	public function set stepSize(n:Number):Void {
		setStepSize(n) ;
	}

	public function get value():Number {
		return 	getValue() ;
	}

	public function set value(n:Number):Void {
		setValue(n) ;
	}

	// ----o Private Properties

	private var _minimum:Number = 0 ; 	
	private var _maximum:Number = 10 ; 
	private var _stepSize:Number = 1 ;
	private var _value:Number = 0 ;

}