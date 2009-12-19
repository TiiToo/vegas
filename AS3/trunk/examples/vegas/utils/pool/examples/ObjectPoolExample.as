﻿/*

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

package examples 
{
    import examples.pool.MyBuilder;
    import examples.pool.MyClass;
    
    import vegas.utils.pool.ObjectPool;
    
    import flash.display.Sprite;
    
    /**
     * Example of the ObjectPool and Object
     */
    public class ObjectPoolExample extends Sprite 
    {
        public function ObjectPoolExample()
        {
            var i:int;
            
            var pool:ObjectPool = new ObjectPool() ;
            
            pool.allocate( 10 , MyClass , ["hello label"] ) ;
            
            pool.initialize("init", ["arg1", "arg2"]) ;
            
            var activeObjects:Array = [] ;
            
            //read the first object
            
            activeObjects[0] = pool.get();
            
            var k:int = pool.wasteCount ; 
            
            trace("pool.wasteCount : " + pool.wasteCount) ; // 9
            
            for ( i = 0 ; i < k ; i++ )
            {
                activeObjects.push( pool.get() ) ; // read the remaining 9 objects
            }
            
            // wasteCount is now zero, but usageCount reports 10.
            
            trace("pool.usageCount : " + pool.usageCount) ;
            
            try
            {
                //this will fail because the pool is now empty
                activeObjects.push( pool.get() );
            }
            catch (e:Error)
            {
                trace(e);
            }
            
            k = pool.size() ;
            
            // give all objects back to the pool
            
            for (i = 0; i < k; i++)
            {
                pool.dispose( activeObjects.shift() ) ;
            }
            
            // usage count is zero
            
            trace( pool.usageCount ) ;
            
            trace( "======= use grow property" ) ;
            
            pool.grow = true ;
            
            pool.get() ; // create a new object and the pool is growing witn 10 new objects inside the buffer.
            
            trace("pool.usageCount : " + pool.usageCount) ; // 1
            trace("pool.wasteCount : " + pool.wasteCount) ; // 9
            
            trace( "======= use destroy method" ) ;
            
            pool.destroy() ;
            
            trace("pool.usageCount : " + pool.usageCount) ; // 0
            trace("pool.wasteCount : " + pool.wasteCount) ; // 0
            
            trace( "======= Assign a custom object factory, see the test.pool.MyBuilder class") ;
            
            pool.builder = new MyBuilder();
            
            pool.allocate( 20 ) ;
            
            trace( pool.get() ) ;
            
            trace("pool.usageCount : " + pool.usageCount) ; // 1
            trace("pool.wasteCount : " + pool.wasteCount) ; // 19
        }
    }
}
