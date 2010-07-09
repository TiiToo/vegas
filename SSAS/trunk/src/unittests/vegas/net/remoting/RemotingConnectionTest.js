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

vegas.net.remoting.RemotingConnectionTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

vegas.net.remoting.RemotingConnectionTest.prototype             = new buRRRn.ASTUce.TestCase() ;
vegas.net.remoting.RemotingConnectionTest.prototype.constructor = vegas.net.remoting.RemotingConnectionTest ;

proto = vegas.net.remoting.RemotingConnectionTest.prototype ;

// ----o Initialize

proto.setUp = function()
{
    this.connection = new vegas.net.remoting.RemotingConnection( "http://localhost/vegas/gateway.php" ) ;
}

proto.tearDown = function()
{
    this.connection = undefined ;
}

// ----o Tests

proto.testAMF_SERVER_DEBUG = function () 
{
    this.assertEquals( "amf_server_debug" , vegas.net.remoting.RemotingConnection.AMF_SERVER_DEBUG ) ;
}

proto.testCREDENTIALS = function () 
{
    this.assertEquals( "Credentials" , vegas.net.remoting.RemotingConnection.CREDENTIALS ) ;
}

proto.testConstructor = function () 
{
    this.assertNotNull( this.connection  ) ;
    this.assertEquals( "http://localhost/vegas/gateway.php" , this.connection.uri ) ;
}

proto.testInherit = function () 
{
    this.assertTrue( this.connection instanceof vegas.net.Connection ) ;
}

proto.testDebug = function () 
{
    this.assertEquals( '{amf:false,amfheaders:false,coldfusion:false,error:true,httpheaders:false,m_debug:true,recordset:true,trace:true}' , core.dump( this.connection.debug ) ) ;
}

proto.testClone = function()
{
    var clone = this.connection.clone() ;
    this.assertNotNull( clone ) ;
    this.assertTrue( clone instanceof vegas.net.remoting.RemotingConnection ) ;
    this.assertEquals( this.connection.uri , clone.uri ) ;
}

proto.testSetCredentials = function () 
{
    try
    {
        this.connection.setCredentials( new vegas.net.remoting.RemotingAuthentification( "name" , "pass" ) ) ;
    }
    catch( e )
    {
        this.fail( "#1 : " + e ) ;
    }
}

proto.testToString = function () 
{
    this.assertEquals( "[RemotingConnection]" , this.connection.toString() ) ;
}

// ----o Encapsulate

delete proto ;