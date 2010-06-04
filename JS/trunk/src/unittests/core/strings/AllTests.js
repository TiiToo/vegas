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

load("unittests/core/strings/centerTest.js"              ) ;
load("unittests/core/strings/compareTest.js"             ) ;
load("unittests/core/strings/endWithTest.js"             ) ;
load("unittests/core/strings/fastformatTest.js"          ) ;
load("unittests/core/strings/indexOfAnyTest.js"          ) ;
load("unittests/core/strings/insertTest.js"              ) ;
load("unittests/core/strings/lastIndexOfAnyTest.js"      ) ;
load("unittests/core/strings/lineTerminatorCharsTest.js" ) ;
load("unittests/core/strings/padTest.js"                 ) ;
load("unittests/core/strings/repeatTest.js"              ) ;

// ----o constructor

core.strings.AllTests = function( /*String*/ name ) 
{
    buRRRn.ASTUce.TestCase.call( this, name );
}

// ----o Inherit

core.strings.AllTests.prototype             = new buRRRn.ASTUce.TestCase() ;
core.strings.AllTests.prototype.constructor = core.strings.AllTests ;

// ----o Public Methods

core.strings.AllTests.suite = function() {
    
    var TestSuite = buRRRn.ASTUce.TestSuite;
    
    var suite = new TestSuite( "core.strings unit tests" );
    
    //suite.simpleTrace = true;
    
    suite.addTest( new TestSuite( core.strings.centerTest              ) ) ;
    suite.addTest( new TestSuite( core.strings.compareTest             ) ) ;
    suite.addTest( new TestSuite( core.strings.endWithTest             ) ) ;
    suite.addTest( new TestSuite( core.strings.fastformatTest          ) ) ;
    suite.addTest( new TestSuite( core.strings.indexOfAnyTest          ) ) ;
    suite.addTest( new TestSuite( core.strings.insertTest              ) ) ;
    suite.addTest( new TestSuite( core.strings.lastIndexOfAnyTest      ) ) ;
    suite.addTest( new TestSuite( core.strings.lineTerminatorCharsTest ) ) ;
    suite.addTest( new TestSuite( core.strings.padTest                 ) ) ;
    suite.addTest( new TestSuite( core.strings.repeatTest              ) ) ;
    
    return suite ;
}
