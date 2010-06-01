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

load("unittests/core/arrays/containsTest.js") ;
load("unittests/core/arrays/initializeTest.js") ;
load("unittests/core/arrays/pierceTest.js") ;
load("unittests/core/arrays/reduceTest.js") ;
load("unittests/core/arrays/reduceRightTest.js") ;
load("unittests/core/arrays/repeatTest.js") ;
load("unittests/core/arrays/shuffleTest.js") ;

// ----o constructor

core.arrays.AllTests = function( /*String*/ name ) 
{
    buRRRn.ASTUce.TestCase.call( this, name );
}

// ----o Inherit

core.arrays.AllTests.prototype             = new buRRRn.ASTUce.TestCase() ;
core.arrays.AllTests.prototype.constructor = core.arrays.AllTests ;

// ----o Public Methods

core.arrays.AllTests.suite = function() {
    
    var TestSuite = buRRRn.ASTUce.TestSuite;
    
    var suite = new TestSuite( "core.arrays unit tests" );
    
    //suite.simpleTrace = true;
    
    suite.addTest( new TestSuite( core.arrays.containsTest ) ) ;
    suite.addTest( new TestSuite( core.arrays.initializeTest ) ) ;
    suite.addTest( new TestSuite( core.arrays.pierceTest ) ) ;
    suite.addTest( new TestSuite( core.arrays.reduceTest ) ) ;
    suite.addTest( new TestSuite( core.arrays.reduceRightTest ) ) ;
    suite.addTest( new TestSuite( core.arrays.repeatTest ) ) ;
    suite.addTest( new TestSuite( core.arrays.shuffleTest ) ) ;
    
    return suite ;
}
