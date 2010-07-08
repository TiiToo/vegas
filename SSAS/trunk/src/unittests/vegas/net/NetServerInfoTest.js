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

vegas.net.NetServerInfoTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

vegas.net.NetServerInfoTest.prototype             = new buRRRn.ASTUce.TestCase() ;
vegas.net.NetServerInfoTest.prototype.constructor = vegas.net.NetServerInfoTest ;

proto = vegas.net.NetServerInfoTest.prototype ;

// ----o Initialize

proto.setUp = function()
{
    this.init = 
    {
         application : "application" ,
         code        : "code"  ,
         level       : "level" ,
         description : "description"
    }
    this.info = new vegas.net.NetServerInfo( this.init ) ;
}

proto.tearDown = function()
{
    this.init = null ;
    this.info = null ;
}

// ----o Public Methods

proto.testInterface = function () 
{
    this.assertNotNull( this.info ) ; 
    this.assertTrue( this.info instanceof system.data.ValueObject ) ;
}

proto.testConstructor = function () 
{
    this.assertNotNull( this.info ) ; 
    this.assertEquals( this.init.application , this.info.application ) ;
    this.assertEquals( this.init.code        , this.info.code ) ;
    this.assertEquals( this.init.description , this.info.description ) ;
    this.assertEquals( this.init.level       , this.info.level ) ;
}

proto.testEmptyConstructor = function () 
{
    this.info = new vegas.net.NetServerInfo() ;
    this.assertNotNull( this.info ) ; 
    this.assertNull( this.info.application ) ;
    this.assertNull( this.info.code ) ;
    this.assertNull( this.info.description ) ;
    this.assertNull( this.info.level ) ;
}

proto.testObjectEncoding = function () 
{
    this.assertEquals( 0 , this.info.objectEncoding ) ;
    this.info.objectEncoding = 3 ;
    this.assertEquals( 3 , this.info.objectEncoding ) ;
}

proto.testToObject = function () 
{
    this.assertEquals( "{application:\"application\",code:\"code\",description:\"description\",level:\"level\"}" , core.dump( this.info.toObject() ) ) ;
}


proto.testToSource = function () 
{
    this.assertEquals( "new vegas.net.NetServerInfo({application:\"application\",code:\"code\",description:\"description\",level:\"level\"})" , this.info.toSource() ) ;
}

proto.testToString = function () 
{
    this.assertEquals( "[NetServerInfo code:code level:level description:description application:application]" , this.info.toString() ) ;
}

// ----o Encapsulate

delete proto ;