/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

// ---o Constructor

system.numeric.RomanNumberTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

system.numeric.RomanNumberTest.prototype             = new buRRRn.ASTUce.TestCase() ;
system.numeric.RomanNumberTest.prototype.constructor = system.numeric.RomanNumberTest ;

proto = system.numeric.RomanNumberTest.prototype ;

// ----o Public Methods

proto.testConstructor = function()
{
    var rn = new system.numeric.RomanNumber();
    this.assertNotNull( rn ) ;
}

proto.testConstructorAsRomanString = function()
{
    var rn = new system.numeric.RomanNumber( "MMVIII" );
    this.assertEquals( 2008, rn.valueOf() );
}

proto.testDefault = function()
{
    var rn = new system.numeric.RomanNumber();
    this.assertEquals( "" , rn.toString() );
}

proto.testBasicOperators = function()
{
    var rn  = new system.numeric.RomanNumber( 2008 );
    var rn2 = new system.numeric.RomanNumber( rn.valueOf()  + 1 );
    var rn3 = new system.numeric.RomanNumber( rn2.valueOf() - 1 );
    
    this.assertEquals( 2009, rn2.valueOf() , "#1");
    this.assertEquals( "MMIX", rn2.toString() , "#2");
    
    this.assertEquals( 2008, rn3.valueOf() , "#3");
    this.assertEquals( "MMVIII", rn3.toString() , "#4");
}

proto.testMaxRange = function()
{
    try
    {
        new system.numeric.RomanNumber( system.numeric.RomanNumber.MAX + 1 );
    }
    catch( e )
    {
        this.assertEquals( e.message, "Max value for a RomanNumber is 3999" , "over maximum range throws a specific RangeError message.") ;
        this.assertTrue( e instanceof RangeError , "over maximum range throws a RangeError object.") ;
    }
}

proto.testMinRange = function()
{
    try
    {
        new system.numeric.RomanNumber( system.numeric.RomanNumber.MIN - 1 );
    }
    catch( e )
    {
        this.assertTrue( e instanceof RangeError , "under minimum range throws a RangeError object." ) ;
        this.assertEquals( e.message, "Min value for a RomanNumber is 0" , "under minimum range throws a specific RangeError message.") ;
    }
}

// parse

proto.testParseBasic = function()
{
    var rn = new system.numeric.RomanNumber();
    this.assertEquals( "M", rn.parse( 1000 ) );
    this.assertEquals( "D", rn.parse(  500 ) );
    this.assertEquals( "C", rn.parse(  100 ) );
    this.assertEquals( "L", rn.parse(   50 ) );
    this.assertEquals( "X", rn.parse(   10 ) );
    this.assertEquals( "V", rn.parse(    5 ) );
    this.assertEquals( "I", rn.parse(    1 ) );
    this.assertEquals( "",  rn.parse(    0 ) );
}

//////////

delete proto ;