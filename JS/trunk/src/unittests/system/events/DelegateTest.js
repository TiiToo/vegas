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

system.events.DelegateTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

system.events.DelegateTest.prototype             = new buRRRn.ASTUce.TestCase() ;
system.events.DelegateTest.prototype.constructor = system.events.DelegateTest ;

proto = system.events.DelegateTest.prototype ;

// ----o Initialize

proto.setUp = function()
{
    this.scope =
    {
        toString : function()
        {
            return "scope" ;
        }
    };
}

proto.tearDown = function()
{
    this.scope = undefined ;
}

// ----o Public Methods

proto.testConstructor = function () 
{
    var target  = null ;
    var result = null ;
    
    var action = function () 
    {
        target = this ;
        result = Array.fromArguments( arguments ) ;
    }
    
    var listener = new system.events.Delegate( this.scope , action , "arg3" ) ;
    
    listener.run("arg1","arg2") ;
    
    this.assertEquals( target , this.scope ) ;
    this.assertEquals( "arg3,arg1,arg2" , result.toString() ) ;
}

proto.testConstructorWithNullScopeReference = function () 
{
    try
    {
        var listener = new system.events.Delegate() ;
        fail("#1") ;
    }
    catch( e )
    {
        this.assertEquals( "Delegate constructor failed, the scope argument not must be null." , e.message , "#2" ) ;
    }
}

proto.testConstructorWithNullMethodReference = function () 
{
    try
    {
        var listener = new system.events.Delegate(this.scope) ;
        fail("#1") ;
    }
    catch( e )
    {
        this.assertEquals( "Delegate constructor failed, the method argument not must be null and must be a Function." , e.message , "#2" ) ;
    }
}

proto.testInherit = function() 
{
    var listener = new system.events.Delegate( this.scope , function(){} ) ;
    this.assertTrue( listener instanceof system.events.EventListener ) ;
}


proto.testCreate = function() 
{
    var target = 
    {
        toString : function () { return "[myObject]" ; }
    }
    
    var scope  = null ;
    var result = null ;
    
    var action = function () 
    {
        return "scope:" + this + " args:" + Array.fromArguments(arguments) ; 
    }
    
    var f = system.events.Delegate.create( this.scope , action , 4 , 5 , 6 ) ;
    
    var r = f( 1 , 2 , 3 ) ;
    
    this.assertEquals( r , "scope:scope args:4,5,6,1,2,3") ;
}

delete proto ;