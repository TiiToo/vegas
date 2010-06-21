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

system.events.FrontControllerTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

system.events.FrontControllerTest.prototype             = new buRRRn.ASTUce.TestCase() ;
system.events.FrontControllerTest.prototype.constructor = system.events.FrontControllerTest ;

proto = system.events.FrontControllerTest.prototype ;

// ----o Initialize

proto.setUp = function()
{
    // 
}

proto.tearDown = function()
{
    system.events.EventDispatcher.flush() ;
    system.events.FrontController.flush() ;
}

// ----o Public Methods

proto.testConstructor = function () 
{
    var controller = new system.events.FrontController() ;
    this.assertEquals( controller.getEventDispatcher() , system.events.EventDispatcher.getInstance() ) ;
}

proto.testConstructorChannel = function()
{
    var controller = new system.events.FrontController("channel") ;
    this.assertEquals( controller.getEventDispatcher() , system.events.EventDispatcher.getInstance("channel") ) ;
}

proto.testConstructorBadChannel = function()
{
    var controller = new system.events.FrontController( 2 ) ;
    this.assertEquals( controller.getEventDispatcher() , system.events.EventDispatcher.getInstance() ) ;
}

proto.testConstructorTarget = function()
{
    var dispatcher = new system.events.EventDispatcher() ;
    var controller = new system.events.FrontController( null , dispatcher ) ;
    this.assertEquals( controller.getEventDispatcher() , dispatcher ) ;
}

proto.testAdd = function()
{
    var listener   = new system.events.mocks.MockEventListener() ;
    var controller = new system.events.FrontController() ;
    
    controller.add( "type", listener ) ;
    
    this.assertEquals( 1 , controller.size() , "#1" ) ;
    
    controller.add( "type", listener ) ;
    
    this.assertEquals( 1 , controller.size() , "#2" ) ;
}

proto.testAddTypeArgumentError = function()
{
    var controller = new system.events.FrontController() ;
    try
    {
        controller.add( null , null ) ;
        this.fail("#1");
    }
    catch( e )
    {
        this.assertTrue( e instanceof TypeError , "#2" ) ;
        this.assertEquals( "The FrontController add() method failed, the 'type' argument not must be null and must be a String." , e.message , "#3") ;
    }
}

proto.testAddEventListenerArgumentError = function()
{
    var controller = new system.events.FrontController() ;
    try
    {
        controller.add( "test" , null ) ;
        this.fail("#1");
    }
    catch( e )
    {
        this.assertTrue( e instanceof TypeError , "#2" ) ;
        this.assertEquals( "The FrontController add() method failed, the event type 'test' failed, the 'listener' argument not must be null." , e.message , "#3") ;
    }
}

// ----o Encapsulate

delete proto ;