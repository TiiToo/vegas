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

import buRRRn.ASTUce.TestCase;

import vegas.core.types.Bit;

// TODO finish methods testing.

/**
 * @author eKameleon
 */
class Tests.vegas.core.types.TestBit extends TestCase 
{
	
	/**
	 * Creates a new TestBit instance.
	 */
	function TestBit(name : String) 
	{
		super(name);
	}
	
	public function testConstructor()
	{
		var o:Bit = new Bit(1) ;
		assertNotNull( o, "BIT_00 - constructor is null") ;
		assertTrue( o instanceof Bit , "BIT_00 - constructor is an instance of Bit.") ;
	}
	
	public function testInherit()
	{
		var o:Bit = new Bit(1) ;
		assertTrue( o instanceof Number , "BIT_01 - inherit Number failed.") ;
	}	
	
	public function testHashCode():Void
	{
		var o:Bit = new Bit(1) ;
		var result = o.hashCode() ;
		assertTrue( !isNaN(result) , "BIT_02 - hashCode failed : " + result ) ;
	}
	
	public function testToSource():Void
	{
		var o = new Bit(1) ;
		var result = o.toSource() ;
		assertEquals( result , "new vegas.core.types.Bit(1,2)", "BIT_03 - toSource failed : " + result) ;
	}

	public function testToString():Void
	{
		var result:String ;
		
		var o:Bit ;
		
		o = new Bit(1) ;
		assertEquals( o.toString() , "1b", "BIT_04_01 - toString failed : " + o.toString()) ;
		
		o = new Bit(1234) ;
		assertEquals( o.toString() , "1.21Kb", "BIT_04_02 - toString failed : " + o.toString()) ;
		
		o = new Bit(15002344) ;
		assertEquals( o.toString() , "14.31Mb", "BIT_04_03 - toString failed : " + o.toString()) ;
		
	}
	
	public function testConstants():Void
	{
		
		assertEquals( Bit.DEFAULT_FLOATING_POINTS , 2, 	"BIT_05_01 - Bit.DEFAULT_FLOATING_POINTS failed : " + Bit.DEFAULT_FLOATING_POINTS ) ;
		
		assertEquals( Bit.BYTE  , 8, "BIT_05_02 - Bit.BYTE failed : " + Bit.BYTE ) ;
		assertEquals( Bit.KBIT  , 1024, "BIT_05_03 - Bit.KBIT failed : " + Bit.KBIT ) ;
		assertEquals( Bit.KBYTE , Bit.KBIT * Bit.BYTE  , "BIT_05_04 - Bit.KBYTE failed : " + Bit.KBYTE ) ;
		assertEquals( Bit.MBIT  , Bit.KBIT * Bit.KBIT  , "BIT_05_05 - Bit.MBIT failed  : " + Bit.MBIT  ) ;
		assertEquals( Bit.MBYTE , Bit.KBYTE * Bit.KBIT , "BIT_05_05 - Bit.MBYTE failed : " + Bit.MBYTE ) ;
		assertEquals( Bit.GBIT  , Bit.MBIT * Bit.KBIT  , "BIT_06_05 - Bit.GBIT failed  : " + Bit.GBIT  ) ;
		assertEquals( Bit.GBYTE , Bit.MBYTE * Bit.KBIT , "BIT_06_06 - Bit.GBYTE failed : " + Bit.GBYTE ) ;
		assertEquals( Bit.TBIT  , Bit.GBIT * Bit.KBIT  , "BIT_06_07 - Bit.TBIT failed  : " + Bit.TBIT  ) ;
		assertEquals( Bit.TBYTE , Bit.GBYTE * Bit.KBIT , "BIT_06_08 - Bit.TBYTE failed : " + Bit.TBYTE ) ;		
		
		assertEquals( Bit.TBYTE , Bit.GBYTE * Bit.KBIT, "BIT_06_08 - Bit.TBYTE failed : " + Bit.TBYTE ) ;
	
		assertEquals( Bit.SB  , "b"   , "BIT_06_09 - Bit.SB failed  : " + Bit.SB ) ;
		assertEquals( Bit.SKB , "Kb"  , "BIT_06_10 - Bit.SKB failed : " + Bit.SKB ) ;
		assertEquals( Bit.SMB , "Mb"  , "BIT_06_11 - Bit.SMB failed : " + Bit.SMB ) ;
		assertEquals( Bit.SGB , "Gb"  , "BIT_06_12 - Bit.SGB failed : " + Bit.SGB ) ;
		assertEquals( Bit.STB , "Tb"  , "BIT_06_13 - Bit.STB failed : " + Bit.STB ) ;
		
	}
	
	public function testGetBit():Void 
	{
		var o:Bit = new Bit( 1 ) ;
		assertEquals( o.getBit(), 1, "BIT_07 - getBit() failed : " + o.getBit() ) ;
	}


	public function testGetBytes():Void 
	{
		var o:Bit = new Bit( 8 ) ;
		assertEquals( o.getBytes(), 1, "BIT_08 - getBytes() failed : " + o.getBytes() ) ;
	}
	

	public function testGetKBit():Void 
	{
		var o:Bit = new Bit( 1024 ) ;
		assertEquals( o.getKBit(), 1, "BIT_09 - getKBit() failed : " + o.getKBit() ) ;	
	}

	public function testGetKBytes():Void 
	{
		var o:Bit = new Bit( 8 * 1024 ) ; // 8192
		assertEquals( o.getKBytes(), 1, "BIT_10 - getKBytes() failed : " + o.getKBytes() ) ;	
	}

	public function testGetMegaBit():Void 
	{
		var o:Bit = new Bit( 1024 * 1024 ) ; // 1048576
		assertEquals( o.getMegaBit(), 1, "BIT_11 - getMegaBit() failed : " + o.getMegaBit() ) ;
	}

	public function testGetMegaBytes():Void 
	{
		var o:Bit = new Bit( 8 * 1024 * 1024 ) ; // 8388608
		assertEquals( o.getMegaBytes(), 1, "BIT_12 - getMegaBytes() failed : " + o.getMegaBytes() ) ;
	}

	public function testGetGigaBit():Void 
	{
		var o:Bit = new Bit( 1024 * 1024 * 1024 ) ; // 1073741824
		assertEquals( o.getGigaBit(), 1, "BIT_13 - getGigaBit() failed : " + o.getGigaBit() ) ;
	}

	public function testGetGigaBytes():Void 
	{
		var o:Bit = new Bit( 8 * 1024 * 1024 * 1024 ) ; // 8589934592
		assertEquals( o.getGigaBytes(), 1, "BIT_14 - getGigaBytes() failed : " + o.getGigaBytes() ) ;
	}

	public function testGetTeraBit():Void 
	{
		var o:Bit = new Bit( 1024 * 1024 * 1024 * 1024 ) ; // 1099511627776
		assertEquals( o.getTeraBit(), 1, "BIT_15 - getTeraBit() failed : " + o.getTeraBit() ) ;
	}

	public function testGetTeraBytes():Void 
	{
		var o:Bit = new Bit( 8 * 1024 * 1024 * 1024 * 1024 ) ; // 8796093022208
		assertEquals( o.getTeraBytes(), 1, "BIT_16 - getTeraBytes() failed : " + o.getTeraBytes() ) ;
	}

	public function testSetFloatingPoints():Void 
	{
		var o:Bit = new Bit( 1000 ) ;
		
		o.setFloatingPoints(2) ;
		assertEquals( o.getKBit(), 0.98, "BIT_17_01 - setFloatingPoints(2) failed : " + o.getKBit() ) ;
		
		o.setFloatingPoints(4) ;
		assertEquals( o.getKBit(), 0.9766, "BIT_17_02 - setFloatingPoints(4) failed : " + o.getKBit() ) ;

		o.setFloatingPoints(0) ;
		assertEquals( o.getKBit(), 1, "BIT_17_03 - setFloatingPoints(0) failed : " + o.getKBit() ) ;

		o.setFloatingPoints(-5) ;
		assertEquals( o.getKBit(), 1, "BIT_17_03 - setFloatingPoints(0) failed : " + o.getKBit() ) ;
			
	}

	public function testValueOf():Void 
	{
		var o:Bit = new Bit( 8 ) ;
		assertEquals( o.valueOf() , 1, "BIT_18 - valueOf failed : " + o.valueOf() ) ;
		
	}

}