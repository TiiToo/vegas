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

core.arrays.reduceRightTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

core.arrays.reduceRightTest.prototype             = new buRRRn.ASTUce.TestCase() ;
core.arrays.reduceRightTest.prototype.constructor = core.arrays.reduceRightTest ;

// ----o Public Methods

core.arrays.reduceRightTest.prototype.testReduceRight1 = function () 
{
    var a = [0,1,2,3,4] ;
    
    var callback = function( previousValue , currentValue , index , array )
    {
        return previousValue + currentValue ;
    };
    
    this.assertEquals( 10 , core.arrays.reduceRight( a , callback )      , "#1" ) ;
    this.assertEquals( 20 , core.arrays.reduceRight( a , callback , 10 ) , "#2" ) ;
}

core.arrays.reduceRightTest.prototype.testReduceRight2 = function () 
{
    var a = [[0,1], [2,3], [4,5]] ;
    
    var callback = function( previousValue , currentValue , index , array )
    {
        return previousValue.concat( currentValue ) ;
    };
    
    a = core.arrays.reduceRight( a , callback , [] ) ;
    
    this.assertEquals( a.length , 6 ) ;
    this.assertEquals( 4 , a[0] ) ;
    this.assertEquals( 5 , a[1] ) ;
    this.assertEquals( 2 , a[2] ) ;
    this.assertEquals( 3 , a[3] ) ;
    this.assertEquals( 0 , a[4] ) ;
    this.assertEquals( 1 , a[5] ) ;
}