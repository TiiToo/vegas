
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

class Tests.ASTUce.ComparisonFailureTest extends TestCase
    {
    
    function ComparisonFailureTest( name )
        {
        super( name );
        }
    
    function testComparisonErrorMessage()
        {
        var failure = new ComparisonFailure( "b", "c", "a" );
        assertEquals( "a expected:<b> but was:<c>", failure.getMessage(), "CF_001" );
        }
    
    function testComparisonErrorStartSame()
        {
        var failure = new ComparisonFailure( "ba", "bc", null );
        assertEquals( "expected:<...a> but was:<...c>", failure.getMessage(), "CF_002" );
        }
    
    function testComparisonErrorEndSame()
        {
        var failure = new ComparisonFailure( "ab", "cb", null);
        assertEquals( "expected:<a...> but was:<c...>", failure.getMessage(), "CF_003" );
        }
    
    function testComparisonErrorSame()
        {
        var failure = new ComparisonFailure( "ab", "ab", null );
	    assertEquals( "expected:<ab> but was:<ab>", failure.getMessage(), "CF_004" );
        }
    
    function testComparisonErrorStartAndEndSame()
        {
        var failure = new ComparisonFailure( "abc", "adc", null );
	    assertEquals( "expected:<...b...> but was:<...d...>", failure.getMessage(), "CF_005" );
        }
    
    function testComparisonErrorStartSameComplete()
        {
        var failure = new ComparisonFailure( "ab", "abc", null );
	    assertEquals( "expected:<...> but was:<...c>", failure.getMessage(), "CF_006" );
        }
    
    function testComparisonErrorEndSameComplete()
        {
        var failure = new ComparisonFailure( "bc", "abc", null );
	    assertEquals( "expected:<...> but was:<a...>", failure.getMessage(), "CF_007" );
        }
    
    function testComparisonErrorOverlapingMatches()
        {
        var failure = new ComparisonFailure( "abc", "abbc", null );
	    assertEquals( "expected:<......> but was:<...b...>", failure.getMessage(), "CF_008" );
        }
    
    function testComparisonErrorOverlapingMatches2()
        {
        var failure = new ComparisonFailure( "abcdde", "abcde", null );
	    assertEquals( "expected:<...d...> but was:<......>", failure.getMessage(), "CF_009" );
        }
    
    function testComparisonErrorWithActualNull()
        {
        var failure = new ComparisonFailure( "a", null, null );
	    assertEquals( "expected:<a> but was:<null>", failure.getMessage(), "CF_010" );
        }
    
    function testComparisonErrorWithExpectedNull()
        {
        var failure = new ComparisonFailure( null, "a", null );
	    assertEquals( "expected:<null> but was:<a>", failure.getMessage(), "CF_010" );
        }
    
    }

