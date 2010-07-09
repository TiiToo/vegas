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

vegas.net.remoting.RemotingConnectionCollectorTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

vegas.net.remoting.RemotingConnectionCollectorTest.prototype             = new buRRRn.ASTUce.TestCase() ;
vegas.net.remoting.RemotingConnectionCollectorTest.prototype.constructor = vegas.net.remoting.RemotingConnectionCollectorTest ;

proto = vegas.net.remoting.RemotingConnectionCollectorTest.prototype ;

// ----o Initialize

proto.setUp = function()
{
    this.collector   = new vegas.net.remoting.RemotingConnectionCollector() ;
    this.connection1 = new vegas.net.remoting.RemotingConnection( "http://localhost/gateway1.php" ) ;
    this.connection2 = new vegas.net.remoting.RemotingConnection( "http://localhost/gateway2.php" ) ;
}

proto.tearDown = function()
{
    this.collector   = undefined ;
    this.connection1 = undefined ;
    this.connection2 = undefined ;
}

// ----o Tests

proto.testConstructor = function () 
{
    this.assertNotNull( this.collector  ) ;
}

proto.testAdd = function () 
{
    this.assertTrue( this.collector.add( this.connection1 ) ) ;
    this.assertTrue( this.collector.add( this.connection2 ) ) ;
    this.assertFalse( this.collector.add( this.connection1 ) ) ;
}

proto.testClear = function () 
{
    this.assertTrue( this.collector.add( this.connection1 ) ) ;
    this.assertTrue( this.collector.add( this.connection2 ) ) ;
    this.collector.clear() ;
    this.assertTrue( this.collector.isEmpty() ) ;
}

proto.testContains = function () 
{
    this.assertFalse( this.collector.contains( this.connection1     ) , "#1.1" ) ;
    this.assertFalse( this.collector.contains( this.connection1.uri ) , "#1.2" ) ;
    this.collector.add( this.connection1 ) ;
    this.assertTrue( this.collector.contains( this.connection1     ) , "#2.1" ) ;
    this.assertTrue( this.collector.contains( this.connection1.uri ) , "#2.2" ) ;
}

proto.testGet = function () 
{
    this.collector.add( this.connection1 ) ;
    this.assertEquals( this.connection1 , this.collector.get("http://localhost/gateway1.php") , "#1" )
    this.assertNull( this.collector.get("http://localhost/gateway2.php") , "#2" )
}

proto.testIsEmpty = function () 
{
    this.assertTrue( this.collector.isEmpty() , "#1" ) ;
    this.collector.add( this.connection1 ) ;
    this.assertFalse( this.collector.isEmpty() , "#2" ) ;
}

proto.testRemove = function () 
{
    this.collector.add( this.connection1 ) ;
    this.collector.add( this.connection2 ) ;
    this.assertTrue( this.connection1 == this.collector.remove( this.connection1 ) , "#1") ;
    this.assertEquals( 1 , this.collector.size() , "#2" ) ;
}

proto.testLength = function () 
{
    this.assertEquals( 0 , this.collector.length ) ;
    this.collector.add( this.connection1 ) ;
    this.assertEquals( 1 , this.collector.length ) ;
}

proto.testSize = function () 
{
    this.assertEquals( 0 , this.collector.size() ) ;
    this.collector.add( this.connection1 ) ;
    this.assertEquals( 1 , this.collector.size() ) ;
}

proto.testToString = function () 
{
    this.assertEquals( "[RemotingConnectionCollector]" , this.collector.toString() ) ;
}

proto.testSingleton = function () 
{
    this.assertNotNull( vegas.net.remoting.collector ) ;
    this.assertTrue( vegas.net.remoting.collector instanceof vegas.net.remoting.RemotingConnectionCollector ) ;
}


// ----o Encapsulate

delete proto ;