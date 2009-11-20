/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
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
