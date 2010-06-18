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

system.events.EventListenerEntryTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

system.events.EventListenerEntryTest.prototype             = new buRRRn.ASTUce.TestCase() ;
system.events.EventListenerEntryTest.prototype.constructor = system.events.EventListenerEntryTest ;

proto = system.events.EventListenerEntryTest.prototype ;

// ----o Public Methods

proto.testConstructor = function () 
{
    var entry = new system.events.EventListenerEntry() ;
    this.assertNull( entry.listener ) ;
    this.assertEquals( 0 , entry.priority ) ;
    this.assertFalse( entry.capture ) ;
    this.assertFalse( entry.autoRemove ) ;
}

proto.testConstructorWithArguments = function () 
{
    var listener = new system.events.EventListener() ;
    var entry    = new system.events.EventListenerEntry(listener,true,999,true) ;
    this.assertEquals( listener , entry.listener ) ;
    this.assertEquals( 999      , entry.priority ) ;
    this.assertTrue( entry.capture ) ;
    this.assertTrue( entry.autoRemove ) ;
}

proto.testToString = function () 
{
    var entry ;
    var listener = new system.events.EventListener() ;
    
    entry = new system.events.EventListenerEntry() ;
    this.assertEquals( "[EventListenerEntry listener:null capture:false priority:0 autoRemove:false]" , entry.toString() ) ;
    
    entry = new system.events.EventListenerEntry(listener,true,999,true) ;
    this.assertEquals( "[EventListenerEntry listener:[EventListener] capture:true priority:999 autoRemove:true]" , entry.toString() ) ;
}

//////////

delete proto ;