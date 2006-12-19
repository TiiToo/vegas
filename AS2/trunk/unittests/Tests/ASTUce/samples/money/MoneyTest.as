
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASTUce: ActionScript Test Unit compact edition AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

import buRRRn.ASTUce.*;
import buRRRn.ASTUce.samples.*;

/* Class: MoneyTest
*/
class Tests.ASTUce.samples.money.MoneyTest extends TestCase
    {
    
    private var f12CHF:Money;
    private var f14CHF:Money;
    private var f7USD:Money;
    private var f21USD:Money;
    
    private var fMB1:IMoney;
    private var fMB2:IMoney;
    
    
    function MoneyTest( name )
        {
        super( name );
        }
    
    function setUp():Void
        {
        f12CHF = new Money( 12, "CHF" );
        f14CHF = new Money( 14, "CHF" );
        f7USD  = new Money(  7, "USD" );
        f21USD = new Money( 21, "USD" );
        
        fMB1 = MoneyBag.create( f12CHF, f7USD );
        fMB2 = MoneyBag.create( f14CHF, f21USD );
        }
    
    function testBagMultiply()
        {
        // {[12 CHF][7 USD]} *2 == {[24 CHF][14 USD]}
        var expected = MoneyBag.create( new Money( 24, "CHF" ), new Money( 14, "USD" ) );
        
        assertSame( fMB1, fMB1 );
        assertEquals( expected, fMB1.multiply(2) ); 
        assertEquals( fMB1, fMB1.multiply(1) );
        assertTrue( fMB1.multiply(0).isZero() );
        }
    
    function testBagNegate()
        {
        // {[12 CHF][7 USD]} negate == {[-12 CHF][-7 USD]}
        var expected = MoneyBag.create( new Money(-12, "CHF"), new Money(-7, "USD") );
        
        assertEquals( expected, fMB1.negate() );
        }
    
    function testBagSimplePlus()
        {
        // {[12 CHF][7 USD]} + [14 CHF] == {[26 CHF][7 USD]}
        var expected = MoneyBag.create( new Money(26, "CHF"), new Money(7, "USD") );
        
        assertEquals( expected, fMB1.plus(f14CHF) );
        }
    
    function testBagMinus()
        {
        // {[12 CHF][7 USD]} - {[14 CHF][21 USD] == {[-2 CHF][-14 USD]}
        var expected = MoneyBag.create( new Money(-2, "CHF"), new Money(-14, "USD") );
        
        assertEquals( expected, fMB1.minus(fMB2) );
        }
    
    function testBagSumPlus()
        {
        // {[12 CHF][7 USD]} + {[14 CHF][21 USD]} == {[26 CHF][28 USD]}
        var expected = MoneyBag.create( new Money(26, "CHF"), new Money(28, "USD") );
        
        assertEquals( expected, fMB1.plus(fMB2) );
        }
    
    function testIsZero()
        {
        assertTrue( fMB1.minus(fMB1).isZero() ); 
        assertTrue( MoneyBag.create(new Money (0, "CHF"), new Money (0, "USD")).isZero() );
        }
    
    function testMixedSimplePlus()
        {
        // [12 CHF] + [7 USD] == {[12 CHF][7 USD]}
        var expected = MoneyBag.create( f12CHF, f7USD );
        
        assertEquals( expected, f12CHF.plus(f7USD) );
        }
    
    function testBagNotEquals()
        {
        var bag = MoneyBag.create( f12CHF, f7USD );
        
        assertFalse( bag.equals( new Money(12, "DEM").plus(f7USD) ) );
        }
    
    function testMoneyBagEquals()
        {
        assertTrue( !fMB1.equals(null) ); 
        assertEquals( fMB1, fMB1 );
        
        var equal = MoneyBag.create( new Money(12, "CHF"), new Money(7, "USD") );
        
        assertTrue( fMB1.equals(equal) );
        assertTrue( !fMB1.equals(f12CHF) );
        assertTrue( !f12CHF.equals(fMB1) );
        assertTrue( !fMB1.equals(fMB2) );
        }
    
    function testMoneyEquals()
        {
        assertTrue( !f12CHF.equals(null) ); 
        
        var equalMoney = new Money(12, "CHF");
        
        assertEquals( f12CHF, f12CHF );
        assertEquals( f12CHF, equalMoney );
        assertTrue( !f12CHF.equals(f14CHF) );
        }
    
    function testSimplify()
        {
        var m = MoneyBag.create( new Money(26, "CHF"), new Money(28, "CHF") );
        
        assertEquals( new Money(54, "CHF"), m );
        }
    
    function testNormalize2()
        {
        // {[12 CHF][7 USD]} - [12 CHF] == [7 USD]
        var expected = new Money(7, "USD");
        
        assertEquals( expected, fMB1.minus(f12CHF) );
        }
    
    function testNormalize3()
        {
        // {[12 CHF][7 USD]} - {[12 CHF][3 USD]} == [4 USD]
        var ms1 = MoneyBag.create( new Money(12, "CHF"), new Money(3, "USD") );
        var expected = new Money(4, "USD");
        
        assertEquals( expected, fMB1.minus(ms1) );
        }
    
    }

