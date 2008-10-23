/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.core 
{
    import andromeda.ioc.factory.strategy.IObjectFactoryStrategy;
    import andromeda.ioc.factory.strategy.ObjectFactoryMethod;
    
    import buRRRn.ASTUce.framework.TestCase;    

    /**
	 * @author eKameleon
	 */
	public class IObjectDefinitionTest extends TestCase 
	{

		public function IObjectDefinitionTest(name:String = "")
		{
			super(name);
		}
		
		public var instance:ConcreteObjectDefinition ;
		
        public function setUp():void
        {
            instance = new ConcreteObjectDefinition() ;
		}
        
        public function tearDown():void
        {
            instance = undefined ;            
        }

		public function testGetConstructorArguments():void
		{
			assertTrue( instance.getConstructorArguments() is Array , "getConstructorArguments method failed.") ;
		}
			
		public function testGetDestroyMethodName():void
		{
			assertEquals( instance.getDestroyMethodName() , "destroy" , "getDestroyMethodName method failed.") ;
		}
	
		public function testGetFactoryStrategy():void
		{
			
            var o:IObjectFactoryStrategy = instance.getFactoryStrategy() ;	
			assertNotNull ( o , "getFactoryStategy 01 failed.") ;
			assertTrue    ( o is ObjectFactoryMethod , "getFactoryStategy 02 failed.") ;
			
						
		}
		
		public function testGetInitMethodName():void
		{
			// FIXME finish test
		}
			
		public function testGetMethods():void
		{
			// FIXME finish test
		}
		
		public function testGetProperties():void
		{
			// FIXME finish test
		}
		
		public function testGetScope():void
		{
			// FIXME finish test			
		}
	
		public function testGetType():void
		{
			// FIXME finish test			
		}
		
		public function testIsLazyInit():void
		{
			// FIXME finish test		
		}
		
		public function TestIsSingleton():void
		{
			// FIXME finish test
		}
		
		public function testSetConstructorArguments():void
		{
			// FIXME finish test	
		}
			
		public function testSetDestroyMethodName():void
		{
			// FIXME finish test	
		}
			
		public function testSetFactoryMethod(value:ObjectMethod):void
		{
			// FIXME finish test	
		}
		
		public function testSetInitMethodName(value:String = null):void
		{
			// FIXME finish test
		}
			
		public function testSetMethods():void
		{
			// FIXME finish test 
		}
			
		public function TestSetProperties():void
		{
			// FIXME finish test
		}
			
		public function TestSetScope():void
		{
			// FIXME finish test	
		}
			
		public function TestSetType():void
		{
			// FIXME finish test	
		}
			
		public function testIdentify():void
		{
			// FIXME finish test
		}
			
		public function set testId():void
		{
			// FIXME finish test
		}

	}
}

import andromeda.ioc.factory.strategy.IObjectFactoryStrategy;
import andromeda.ioc.factory.strategy.ObjectFactoryMethod;

class ConcreteObjectDefinition implements IObjectDefinition
{

	public function getConstructorArguments():Array
	{
		return [] ;
	}
	
    public function getDependsOn():Array
    {
        return ["d1","d2"] ;
    }
    	
	public function getDestroyMethodName():String
	{
		return "destroy" ;
	}
	
    
    public function getFactoryStrategy():IObjectFactoryStrategy
    {
    	return new ObjectFactoryMethod("factory","name",["arg1","arg2"]) ;
    }	
	
    public function getGenerates():Array
    {
        return ["g1","g2"] ;
    }   	
	
	public function getInitMethodName():String
	{
		return "init" ;
	}
	
    public function getListeners():Array
    {
        return new Array() ;
    }
    	
	public function getMethods():Array
	{
		return [] ;
	}
	
	public function getProperties():Array
	{
		return new Array() ;
	}
	
	public function getScope():String
	{
		return "scope" ;
	}
	
	public function getType():String
	{
		return "type" ;
	}
	
	public function isLazyInit():Boolean
	{
		return true ;
	}
	
	public function isSingleton():Boolean
	{
		return true ;
	}
	
	public function setConstructorArguments(value:Array = null):void
	{
		throw new Error("setConstructorArguments") ;
	}
	
    public function setDependsOn(ar:Array):void
    {
        throw new Error("setDependsOn") ;
    }	
	
	public function setDestroyMethodName(value:String = null):void
	{
		throw new Error("setDestroyMethodName") ;
	}
		
	public function setFactoryMethod(value:ObjectMethod):void
	{
		throw new Error("setFactoryMethod") ;
	}
    
    public function setFactoryStrategy(value:IObjectFactoryStrategy):void
    {
    	throw new Error("setFactoryStrategy") ;
    }	
	
    public function setGenerates(ar:Array):void
    {
        throw new Error("setGenerates") ;
    }   	
	
	public function setInitMethodName(value:String = null):void
	{
		throw new Error("setInitMethodName") ;
	}
	
    public function setListeners(ar:Array = null):void
    {
        throw new Error("setListeners") ;       
    }   	
	
	public function setMethods(ar:Array = null):void
	{
		throw new Error("setMethods") ;
	}
	
	public function setProperties(ar:Array = null):void
	{
		throw new Error("setProperties") ;
	}
	
	public function setScope(scope:String = null):void
	{
		throw new Error("setScope") ;
	}
	
	public function setType(value:String = null):void
	{
		throw new Error("setType") ;
	}
	
	public function get identify():*
	{
		return true ;
	}
	
	public function get id():*
	{
		return _id ;
	}
	
	public function set identify(value:*):void
	{
		_identify = value ;
	}
	
	public function set id(id:*):void
	{
		_id = id ;
	}
	
    /**
     * Indicates if the object definition lock this ILockable object during the population 
     * of the properties and the initialization of the methods defines in the object definition.
     */
    public function get lock():*
    {
        return _lock ;
    } 
            
    /**
     * @private
     */
    public function set lock( value:* ):void 
    {
        _lock = value ;	
    }	

    /**
     * @private
     */
	private var _id:* ;

    /**
     * @private
     */
	private var _identify:* ;

    /**
     * @private
     */
    private var _lock:* ;
    
}