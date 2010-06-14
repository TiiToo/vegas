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

system.data.collections.ArrayCollectionTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

system.data.collections.ArrayCollectionTest.prototype             = new buRRRn.ASTUce.TestCase() ;
system.data.collections.ArrayCollectionTest.prototype.constructor = system.data.collections.ArrayCollectionTest ;

// ----o Public Methods

system.data.collections.ArrayCollectionTest.prototype.testConstructor = function () 
{
    var c = new system.data.collections.ArrayCollection() ;
    this.assertNotNull( c ) ;
    var a = c.toArray() ;
    this.assertEquals( 0 , a.length ) ;
}

system.data.collections.ArrayCollectionTest.prototype.testConstructorWithArray = function () 
{
    var c = new system.data.collections.ArrayCollection([2,3,4]) ; 
    
    this.assertNotNull( c ) ;
    
    var a = c.toArray() ;
    
    this.assertEquals( 3 , a.length ) ;
    
    this.assertEquals( 2 , a[0] ) ;
    this.assertEquals( 3 , a[1] ) ;
    this.assertEquals( 4 , a[2] ) ;
}

system.data.collections.ArrayCollectionTest.prototype.testConstructorWithIterableObject = function () 
{
    var init = new system.data.collections.ArrayCollection([2,3,4]) ;
    var c    = new system.data.collections.ArrayCollection( init ) ; 
    
    this.assertNotNull( c ) ;
    
    var a = c.toArray() ;
    
    this.assertEquals( 3 , a.length ) ;
    
    this.assertEquals( 2 , a[0] ) ;
    this.assertEquals( 3 , a[1] ) ;
    this.assertEquals( 4 , a[2] ) ;
}