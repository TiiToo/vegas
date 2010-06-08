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

system.data.maps.ArrayMapTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

system.data.maps.ArrayMapTest.prototype             = new buRRRn.ASTUce.TestCase() ;
system.data.maps.ArrayMapTest.prototype.constructor = system.data.maps.ArrayMapTest ;

// ----o Initialize

system.data.maps.ArrayMapTest.prototype.setUp = function()
{
    this.map = new system.data.maps.ArrayMap(["key1", "key2"],["value1", "value2"]) ;
}

system.data.maps.ArrayMapTest.prototype.tearDown = function()
{
    this.map = undefined ;
}

// ----o Public Methods

system.data.maps.ArrayMapTest.prototype.testConstructor = function () 
{
    this.assertNotNull( this.map , "#1" ) ;
    
    this.assertEquals( this.map.get("key1") , "value1" , "#2-1 - The ArrayMap constructor failed : map.get('key1')") ;
    this.assertEquals( this.map.get("key2") , "value2" , "#2-2 - The ArrayMap constructor failed : map.get('key2')") ;
    
    this.map = new system.data.maps.ArrayMap() ;
    this.assertEquals( this.map.size() , 0 , "#3") ;
    
    this.map = new system.data.maps.ArrayMap(null,["value1", "value2"]) ;
    this.assertEquals( this.map.size() , 0 , "#4") ;
}

system.data.maps.ArrayMapTest.prototype.testClear = function () 
{
    this.map.clear() ;
    this.assertEquals( this.map.size() , 0 , "The ArrayMap clear method failed.") ;
}

system.data.maps.ArrayMapTest.prototype.testClone = function () 
{
    var clone = this.map.clone() ;
    this.assertNotNull( clone , "#1") ;
    this.assertEquals( clone.size()  , this.map.size()  , "#2") ;
    this.assertEquals( clone["key1"] , this.map["key1"] , "#3") ;
    this.assertEquals( clone["key2"] , this.map["key2"] , "#4") ;
}

system.data.maps.ArrayMapTest.prototype.testContainsKey = function () 
{
    this.assertTrue( this.map.containsKey("key1") , "#1") ;
    this.assertTrue( this.map.containsKey("key2") , "#2") ;
    this.assertFalse( this.map.containsKey("key3") , "#3") ;
}

system.data.maps.ArrayMapTest.prototype.testContainsValue = function () 
{
    this.assertTrue( this.map.containsValue("value1") , "#1") ;
    this.assertTrue( this.map.containsValue("value2") , "#2") ;
    this.assertFalse( this.map.containsValue("value3") , "#3") ;
}