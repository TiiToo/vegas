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

// TODO Finir les tests sur toutes les méthodes.
// TODO test la R/W "name"

// ---o Constructor

system.events.EventDispatcherTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this, name ) ;
}

// ----o Inherit

system.events.EventDispatcherTest.prototype = new buRRRn.ASTUce.TestCase() ;
system.events.EventDispatcherTest.prototype.constructor = system.events.EventDispatcherTest ;

proto = system.events.EventDispatcherTest.prototype ;

// ----o Public Methods

proto.testConstructor = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    this.assertNotNull( dispatcher ) ;
}

proto.testInherit = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    this.assertTrue( dispatcher instanceof system.events.IEventDispatcher ) ;
}

proto.testToSource = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    this.assertEquals( dispatcher.toSource() , "new system.events.EventDispatcher()" ) ;
}

proto.testToString = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    this.assertEquals( "[EventDispatcher]", dispatcher.toString() ) ;
}

proto.testAddChild = function () 
{
    var d1 = new system.events.EventDispatcher() ;
    var d2 = new system.events.EventDispatcher() ;
    d1.addChild(d2) ;
    this.assertEquals( d2.parent , d1 ) ;
}

proto.testAddEventListener = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    
    var listener = new system.events.mocks.MockEventListener() ;
    
    dispatcher.addEventListener( "type" , listener ) ;
    
    this.assertTrue( dispatcher.hasEventListener( "type" ) ) ;
    this.assertTrue( "type" , dispatcher.getRegisteredTypes()[0] ) ;
}

proto.testAddGlobalEventListener = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    var listener   = new system.events.mocks.MockEventListener() ;
    
    dispatcher.addGlobalEventListener( listener ) ;
    
    var listeners = dispatcher.getGlobalEventListeners() ;
    
    this.assertEquals( 1 , listeners.length ) ;
}

proto.testDispatchEvent = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    var listener   = new system.events.mocks.MockEventListener() ;
    var event      = new system.events.Event( "type" , dispatcher , "context" ) ;
    
    dispatcher.addEventListener( "type" , listener ) ;
    
    dispatcher.dispatchEvent( event ) ;
    
    this.assertEquals( event      , listener.event ) ;
    this.assertEquals( "type"     , listener.event.type   ) ;
    this.assertEquals( dispatcher , listener.event.target ) ;
}

/*

proto.testFlush = function () 
{
    try 
    {
        var ed = system.events.EventDispatcher.getInstance() ;
        system.events.EventDispatcher.flush() ;
    }
    catch (e) 
    {
        this.fail( "#1") ;
    }
}

proto.testGetEventListeners = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    
    dispatcher.addEventListener("MY_EVENT", this) ;
    
    var listeners = dispatcher.getEventListeners("MY_EVENT") ;
    
    this.assertTrue( listeners instanceof system.events.EventListenerGroup ) ;
}

proto.testGetGlobalEventListener = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    
    dispatcher.addGlobalEventListener(this) ;
    
    var listeners = dispatcher.getGlobalEventListeners() ;
    
    this.assertTrue( listeners instanceof system.events.EventListenerGroup ) ;
}

proto.testGetInstance = function () 
{
    var dispatcher;
    
    dispatcher = system.events.EventDispatcher.getInstance() ;
    this.assertTrue( dispatcher , "#1" ) ;
    
    dispatcher = system.events.EventDispatcher.getInstance("myDispatcher") ;
    this.assertTrue( dispatcher , "#2" ) ;
    
    system.events.EventDispatcher.flush() ;
}

proto.testGetRegisteredTypes = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    
    dispatcher.addEventListener("MY_EVENT", this) ;
    
    var set = dispatcher.getRegisteredEventTypes() ;
    
    this.assertTrue( set ) ;
}

proto.testGetTarget = function () 
{
    var dispatcher = new system.events.EventDispatcher(this) ;
    var target = dispatcher.getTarget() ;
    this.assertEquals( target, this,  "ED_13 : getTarget() failed." ) ;
}

proto.testHasEventListener = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    dispatcher.addEventListener("MY_EVENT", this) ;
    var b = dispatcher.hasEventListener("MY_EVENT") ;
    this.assertTrue( b , "ED_11 : hasEventListener failed." ) ;
}

proto.testParent = function () 
{
    var o1 = new system.events.EventDispatcher() ;
    var o2 = new system.events.EventDispatcher() ;
    o2.parent = o1 ;
    this.assertEquals( o2.parent , o1,  "ED_12 : parent property failed." ) ;
}

proto.testRelease = function () 
{
    try 
    {
        var ed = system.events.EventDispatcher.getInstance("myDispatcher") ;
        system.events.EventDispatcher.release("myDispatcher") ;
    }
    catch (e) 
    {
        this.fail( "ED_13 : static release method failed.") ;
    }
}

proto.testRemoveChild = function () 
{
    var o1 = new system.events.EventDispatcher() ;
    var o2 = new system.events.EventDispatcher() ;
    o1.addChild(o2) ;
    o1.removeChild(o2) ;
    this.assertNull( o1.parent ,  "ED_14: removeChild() failed." ) ;
}


proto.testRemoveEventListener = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    
    dispatcher.addEventListener("MY_EVENT", this) ;
    
    var result = dispatcher.removeEventListener( "MY_EVENT" , this ) ;
    
    this.assertNotNull( result ) ;
}

proto.testRemoveGlobalEventListener = function () 
{
    var dispatcher = new system.events.EventDispatcher() ;
    
    dispatcher.addGlobalEventListener(this) ;
    
    var result = dispatcher.removeGlobalEventListener(this) ;
    var listeners = dispatcher.getGlobalEventListeners() ;
    
    var test = (result != null) && (listeners.size() == 0) ;
    
    this.assertTrue( test ) ;
}

proto.testRemoveInstance = function () 
{
    system.events.EventDispatcher.getInstance("myDispatcher") ;
    
    var b = system.events.EventDispatcher.removeInstance("myDispatcher") ;
    
    this.assertTrue( b ) ;
}

proto.handleEvent = function ( e ) 
{
    this.assertTrue( e instanceof system.events.BasicEvent , e.getContext() ) ;
}
*/
// ----o Encapsulate

delete proto ;
