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

system.process.TaskGroupTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

system.process.TaskGroupTest.prototype             = new buRRRn.ASTUce.TestCase() ;
system.process.TaskGroupTest.prototype.constructor = system.process.TaskGroupTest ;

proto = system.process.TaskGroupTest.prototype ;

// ----o Public Methods

proto.setUp = function()
{
    this.group = new system.process.TaskGroup() ; 
    
    this.task1 = new system.process.mocks.MockTask() ;
    this.task2 = new system.process.mocks.MockTask() ;
    this.task3 = new system.process.mocks.MockTask() ;
    this.task4 = new system.process.mocks.MockTask() ;
    
    this.group.addAction( this.task1 ) ;
    this.group.addAction( this.task2 ) ;
    this.group.addAction( this.task3 ) ;
    this.group.addAction( this.task4 ) ;
}

proto.tearDown = function()
{
    this.group = undefined ;
    this.task1 = undefined ;
    this.task2 = undefined ;
    this.task3 = undefined ;
    this.task4 = undefined ;
}

proto.testEVERLASTING = function () 
{
    this.assertEquals( system.process.TaskGroup.EVERLASTING , "everlasting" ) ;
}

proto.testNORMAL = function () 
{
    this.assertEquals( system.process.TaskGroup.NORMAL , "normal" ) ;
}

proto.testTRANSIENT = function () 
{
    this.assertEquals( system.process.TaskGroup.TRANSIENT , "transient" ) ;
}

proto.testConstructor = function () 
{
    this.assertNotNull( this.group ) ;
}

proto.testInherit = function () 
{
    this.assertTrue( this.group instanceof system.process.CoreAction ) ;
}

proto.testLength = function () 
{
    this.assertEquals( 4 , this.group.length ) ;
}

////////

delete proto ;