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

system.signals.InternalSignalTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

system.signals.InternalSignalTest.prototype             = new buRRRn.ASTUce.TestCase() ;
system.signals.InternalSignalTest.prototype.constructor = system.signals.InternalSignalTest ;

// ----o Public Methods

system.signals.InternalSignalTest.prototype.setUp = function()
{
    this.signal = new system.signals.InternalSignal() ;
    this.receiver1  = function( message ) 
    { 
        throw message ;
    };
    this.receiver2 = new system.signals.samples.ReceiverClass() ;
}

system.signals.InternalSignalTest.prototype.tearDown = function()
{
    this.signal    = undefined ;
    this.receiver1 = undefined ;
    this.receiver2 = undefined ;
}

system.signals.InternalSignalTest.prototype.testInterface = function () 
{
    this.assertTrue( this.signal instanceof system.signals.Signaler ) ; 
}

system.signals.InternalSignalTest.prototype.testConstructor = function () 
{
    this.assertNotNull( this.signal ) ; 
}

system.signals.InternalSignalTest.prototype.testConstructorWithTypes = function () 
{
    this.assertNull( this.signal.types , "01" ) ;
    
    this.signal = new system.signals.InternalSignal([]) ;
    this.assertNotNull( this.signal.types , "02") ;
    
    this.signal = new system.signals.InternalSignal([String,Boolean,Number]) ;
    this.assertEquals( String  , this.signal.types[0] , "03-01" ) ;
    this.assertEquals( Boolean , this.signal.types[1] , "03-02" ) ;
    this.assertEquals( Number  , this.signal.types[2] , "03-03" ) ;
}

system.signals.InternalSignalTest.prototype.testConstructorWithBadTypes = function () 
{
    try
    {
        this.signal = new system.signals.InternalSignal([String,"hello",Number]) ;
        this.fail( "The constructor must notify an error with a no valid Class reference in the types Array") ;
    }
    catch( e )
    {
        this.assertEquals( "Invalid types representation, the Array of types failed at index 1 should be a constructor function but was:\"hello\"." , e.message ) ;
    }
}

system.signals.InternalSignalTest.prototype.testLength = function()
{
    this.assertEquals( this.signal.length , 0 , "01 - length failed.") ;
    this.signal.connect( this.receiver1 ) ;
    this.assertEquals( this.signal.length , 1 , "02 - length failed.") ;
    this.signal.connect( this.receiver2 ) ;
    this.assertEquals( this.signal.length , 2 , "03 - length failed.") ;
    this.signal.connect( this.receiver2 ) ;
    this.assertEquals( this.signal.length , 2 , "04 - length failed.") ;
}