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

vegas.net.ResponderTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

vegas.net.ResponderTest.prototype             = new buRRRn.ASTUce.TestCase() ;
vegas.net.ResponderTest.prototype.constructor = vegas.net.ResponderTest ;

proto = vegas.net.ResponderTest.prototype ;

// ----o Initialize

proto.setUp = function()
{
    this.resultValue = null ;
    
    this.result = function( value )
    {
        this.resultValue = value ;
    }.bind( this ) ;
    
    
    this.statusValue = null ;
    
    this.status = function( value )
    {
        this.statusValue = value ;
    }.bind( this );
    
    this.responder = new vegas.net.Responder( this.result , this.status ) ;
}

proto.tearDown = function()
{
    this.responder   = undefined ;
    this.result      = undefined ;
    this.resultValue = undefined ;
    this.status      = undefined ;
    this.statusValue = undefined ;
}

// ----o Tests

proto.testConstructor = function () 
{
    this.assertTrue( this.responder.result == this.result ) ;
    this.assertTrue( this.responder.status == this.status ) ;
}

proto.testEmptyConstructor = function () 
{
    this.responder = new vegas.net.Responder() ;
    this.assertNotNull( this.responder ) ;
    this.assertNull( this.responder.result ) ;
    this.assertNull( this.responder.status ) ;
}

proto.testOnResult = function () 
{
    this.responder.onResult( "test" ) ;
    this.assertEquals( "test" , this.resultValue ) ;
}

proto.testOnStatus = function () 
{
    this.responder.onStatus( "test" ) ;
    this.assertEquals( "test" , this.statusValue ) ;
}

proto.testToString = function () 
{
    this.assertEquals( "[Responder]" , this.responder.toString() ) ;
}


// ----o Encapsulate

delete proto ;