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

// ---o Constructor

system.signals.SignalEntryTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

system.signals.SignalEntryTest.prototype             = new buRRRn.ASTUce.TestCase() ;
system.signals.SignalEntryTest.prototype.constructor = system.signals.SignalEntryTest ;

// ----o Public Methods

system.signals.SignalEntryTest.prototype.testConstructor = function () 
{
    var entry = new system.signals.SignalEntry() ;
    this.assertNotNull( entry ) ; 
    this.assertFalse( entry.auto ) ;
    this.assertEquals( entry.priority , 0 ) ;
    this.assertNull( entry.receiver ) ;
}

system.signals.SignalEntryTest.prototype.testConstructorWithArguments = function () 
{
    var slot  = function() {} ;
    var entry = new system.signals.SignalEntry( slot , 2 , true ) ;
    this.assertNotNull( entry ) ;
    this.assertTrue( entry.auto ) ;
    this.assertEquals( entry.priority , 2 ) ;
    this.assertEquals( entry.receiver , slot ) ;
}

system.signals.SignalEntryTest.prototype.testToString = function () 
{
    var slot  = function() {} ;
    var entry = new system.signals.SignalEntry( slot , 2 , true ) ;
    this.assertEquals( entry.toString() , "[SignalEntry [Type Function] priority:2 auto:true]" ) ;
}