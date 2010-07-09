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

vegas.net.remoting.RemotingServiceTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

vegas.net.remoting.RemotingServiceTest.prototype             = new buRRRn.ASTUce.TestCase() ;
vegas.net.remoting.RemotingServiceTest.prototype.constructor = vegas.net.remoting.RemotingServiceTest ;

proto = vegas.net.remoting.RemotingServiceTest.prototype ;

// ----o Initialize

proto.setUp = function()
{
    this.service = new vegas.net.remoting.RemotingService
    ( 
        "http://localhost/vegas/gateway.php" , 
        "service" , 
        "method" 
    ) ;
}

proto.tearDown = function()
{
    this.service = undefined ;
}

// ----o Tests

proto.testDEFAULT_DELAY = function () 
{
    this.assertEquals( 8000 , vegas.net.remoting.RemotingService.DEFAULT_DELAY ) ;
}

proto.testConstructor = function () 
{
    this.assertNotNull( this.service ) ;
}

proto.testInherit = function () 
{
    this.assertTrue( this.service instanceof system.process.CoreAction ) ;
}

proto.testClone = function()
{
    var clone = this.service.clone() ;
    this.assertNotNull( clone ) ;
    this.assertTrue( clone instanceof vegas.net.remoting.RemotingService ) ;
}

proto.testDelay = function () 
{
    this.assertEquals( 8000 , this.service.delay , "#1" ) ;
    this.service.delay = 12000 ;
    this.assertEquals( 12000 , this.service.delay , "#2" ) ;
    this.service.delay = -10 ;
    this.assertEquals( 0 , this.service.delay , "#3" ) ;
    this.service.delay = null ;
    this.assertEquals( 0 , this.service.delay , "#4" ) ;
}

proto.testFaultIt = function () 
{
    this.assertNotNull( this.service.faultIt ) ;
    this.assertTrue( this.service.faultIt instanceof system.signals.Signal ) ;
}

proto.testGatewayUrl = function () 
{
    this.assertEquals( "http://localhost/vegas/gateway.php" , this.service.gatewayUrl , "#1" ) ;
    this.service.gatewayUrl = "test" ;
    this.assertEquals( "test" , this.service.gatewayUrl , "#2" ) ;
    this.service.gatewayUrl = null ;
    this.assertNull( this.service.gatewayUrl , "#3" ) ;
}

proto.testMethodName = function () 
{
    this.assertEquals( "method" , this.service.methodName ) ;
    this.service.methodName = "my_method" ;
    this.assertEquals( "my_method" , this.service.methodName ) ;
}

proto.testmultipleSimultaneousAllowed = function () 
{
    this.assertFalse( this.service.multipleSimultaneousAllowed , "#1" ) ;
    this.service.multipleSimultaneousAllowed = true ;
    this.assertTrue( this.service.multipleSimultaneousAllowed , "#2" ) ;
}

proto.testObjectEncoding = function ()
{
    this.assertEquals( vegas.net.ObjectEncoding.DEFAULT , this.service.objectEncoding , "#1" ) ;
    this.service.objectEncoding = vegas.net.ObjectEncoding.AMF0 ;
    this.assertEquals( vegas.net.ObjectEncoding.AMF0 , this.service.objectEncoding , "#2" ) ;
    this.service.objectEncoding = vegas.net.ObjectEncoding.AMF3 ;
    this.assertEquals( vegas.net.ObjectEncoding.AMF3 , this.service.objectEncoding , "#3" ) ;
    this.service.objectEncoding = 99999 ;
    this.assertEquals( vegas.net.ObjectEncoding.AMF3 , this.service.objectEncoding , "#4" ) ;
}

proto.testParams = function ()
{
    this.assertTrue( this.service.params instanceof Array , "#1.1" ) ;
    this.assertEquals( 0 , this.service.params.length , "#1.2" ) ;
    
    this.service.params = [] ;
    this.assertTrue( this.service.params instanceof Array , "#2.1" ) ;
    this.assertEquals( 0 , this.service.params.length , "#2.2" ) ;
    
    this.service.params = [2,3,4] ;
    this.assertTrue( this.service.params instanceof Array , "#3.1" ) ;
    this.assertEquals( 3 , this.service.params.length , "#3.2" ) ;
    this.assertEquals( 2 , this.service.params[0] , "#3.3" ) ;
    this.assertEquals( 3 , this.service.params[1] , "#3.4" ) ;
    this.assertEquals( 4 , this.service.params[2] , "#3.5" ) ;
    
    this.service.params = 2 ;
    this.assertTrue( this.service.params instanceof Array , "#4.1" ) ;
    this.assertEquals( 0 , this.service.params.length , "#4.2" ) ;
}

proto.testParams = function ()
{
    this.assertEquals( this.service , this.service.proxy ) ;
}

proto.testResponder = function () 
{
    this.assertEquals( this.service._internalResponder , this.service.responder ) ;
    var responder = new vegas.net.Responder() ;
    this.service.responder = responder ;
    this.assertEquals( responder , this.service.responder ) ;
}

proto.testResult = function () 
{
    this.assertNull( this.service.result ) ;
    this.service.notifyResult( "hello" ) ;
    this.assertEquals( "hello" , this.service.result ) ;
}

proto.testResulIt = function () 
{
    this.assertNotNull( this.service.resultIt ) ;
    this.assertTrue( this.service.resultIt instanceof system.signals.Signal ) ;
}

proto.testServiceName = function () 
{
    this.assertEquals( "service" , this.service.serviceName ) ;
    this.service.serviceName = "my_service" ;
    this.assertEquals( "my_service" , this.service.serviceName ) ;
    this.service.serviceName = null ;
    this.assertEquals( "" , this.service.serviceName ) ;
}

proto.testScope = function () 
{
    this.assertEquals( "singleton" , this.service.scope , "#1" ) ;
    
    this.service.scope = "prototype" ;
    this.assertEquals( "prototype" , this.service.scope , "#2" ) ;
    
    this.service.scope = "unknow" ;
    this.assertEquals( "prototype" , this.service.scope , "#3" ) ;
    
    this.service.scope = null ;
    this.assertEquals( "prototype" , this.service.scope , "#4" ) ;
}

proto.testTimeoutPolicy = function () 
{
    this.assertEquals( system.process.TimeoutPolicy.INFINITY , this.service.timeoutPolicy ) ;
    this.service.timeoutPolicy = system.process.TimeoutPolicy.LIMIT ;
    this.assertEquals( system.process.TimeoutPolicy.LIMIT , this.service.timeoutPolicy ) ;
    this.service.timeoutPolicy = "hello" ;
    this.assertEquals( system.process.TimeoutPolicy.INFINITY , this.service.timeoutPolicy ) ;
}

proto.testGetConnectionSingleton = function()
{
    var connection1 = this.service.getConnection() ;
    var connection2 = this.service.getConnection() ;
    
    this.assertNotNull( connection1 , "#1" ) ;
    this.assertNotNull( connection2 , "#2" ) ;
    
    this.assertTrue( connection1 instanceof vegas.net.remoting.RemotingConnection , "#3" ) ;
    this.assertTrue( connection2 instanceof vegas.net.remoting.RemotingConnection , "#4" ) ;
    
    this.assertEquals( connection1 , connection2 , "#5" ) ;
}

proto.testGetConnectionEmptyGatewayUrl = function()
{
    this.service.gatewayUrl = null ;
    this.assertNull( this.service.getConnection() , "#1" ) ;
    this.service.gatewayUrl = "" ;
    this.assertNull( this.service.getConnection() , "#2" ) ;
}

proto.testToString = function () 
{
    this.assertEquals( "[RemotingService]" , this.service.toString() ) ;
}

// ----o Encapsulate

delete proto ;