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

if( system.process.mocks.MockActionReceiver == undefined )
{
    system.process.mocks.MockActionReceiver = function ( action /*CoreAction*/ ) 
    {
        this.changeCalled   = false ;
        this.clearCalled    = false ;
        this.infoCalled     = false ;
        this.infoObject     = null ;
        this.loopCalled     = false ;
        this.pauseCalled    = false ;
        this.progressCalled = false ;
        this.resumeCalled   = false ;
        this.stopCalled     = false ;
        this.timeoutCalled  = false ;
        
        this.phase          = null ;
        this.running        = false ;
        
        if ( action )
        {
            this.register( action ) ;
        }
    }
    
    ////////////////////////////////////
    
    /**
     * @extends Object
     */
    proto = system.process.mocks.MockActionReceiver.extend( Object ) ;
    
    ////////////////////////////////////
    
    proto.change = function( action /*CoreAction*/ )
    {
        this.changeCalled = true ;
        this.phase        = task.phase   ;
        this.runnin       = task.running ;
    }
    
    proto.clear = function( action /*CoreAction*/ )
    {
        this.clearCalled = true ;
        this.phase       = task.phase   ;
        this.running     = task.running ;
    }
    
    proto.info = function( action /*CoreAction*/ , info )
    {
        this.infoCalled = true ;
        this.infoObject = info ;
        this.phase      = task.phase   ;
        this.running    = task.running ;
    }
    
    proto.loop = function( action /*CoreAction*/ )
    {
        this.loopCalled = true ;
        this.phase      = task.phase   ;
        this.running    = task.running ;
    }
    
    proto.pause = function( action /*CoreAction*/ )
    {
        this.pauseCalled = true ;
        this.phase       = task.phase   ;
        this.running     = task.running ;
    }
    
    proto.progress = function( action /*CoreAction*/ )
    {
        this.progressCalled = true ;
        this.phase          = task.phase   ;
        this.running        = task.running ;
    }
    
    proto.resume = function( action /*CoreAction*/ )
    {
        this.resumeCalled = true ;
        this.phase        = task.phase   ;
        this.running      = task.running ;
    }
    
    proto.stop = function( action /*CoreAction*/ )
    {
        this.stopCalled = true ;
        this.phase      = task.phase   ;
        this.running    = task.running ;
    }
    
    proto.timeout = function( action /*CoreAction*/ )
    {
        this.timeoutCalled = true ;
        this.phase         = task.phase   ;
        this.running       = task.running ;
    }
    
    ////////////////////////////////////
    
    proto.register = function( action /*CoreAction*/ ) /*void*/
    {
        this.action = action ;
        if ( this.action )
        {
            this.action.changeIt.connect( this.change.bind( this ) ) ;
            this.action.clearIt.connect( this.clear.bind( this ) ) ;
            this.action.infoIt.connect( this.info.bind( this ) ) ;
            this.action.loopIt.connect( this.loop.bind( this ) ) ;
            this.action.pauseIt.connect( this.pause.bind( this ) ) ;
            this.action.progressIt.connect( this.progress.bind( this ) ) ;
            this.action.resumeIt.connect( this.resume.bind( this ) ) ;
            this.action.stopIt.connect( this.stop.bind( this ) ) ;
            this.action.timeoutIt.connect( this.timeout.bind( this ) ) ;
        }
    }
    
    proto.unregister = function() /*void*/
    {
        if ( this.action )
        {
            this.action.changeIt.disconnect() ;
            this.action.clearIt.disconnect() ;
            this.action.infoIt.disconnect() ;
            this.action.loopIt.disconnect() ;
            this.action.pauseIt.disconnect() ;
            this.action.progressIt.disconnect() ;
            this.action.resumeIt.disconnect() ;
            this.action.stopIt.disconnect() ;
            this.action.timeoutIt.disconnect() ;
            this.action = null  ;
        }
    }
    
    ////////////////////////////////////
    
    delete proto ;
}