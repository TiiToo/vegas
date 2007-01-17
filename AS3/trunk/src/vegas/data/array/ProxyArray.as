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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.data.array
{

    import vegas.core.HashCode;
    import vegas.core.ICloneable;
    import vegas.core.ICopyable;
    import vegas.core.ISerializable;
    import vegas.core.IFormattable;
    import vegas.core.IHashable;

    import vegas.data.iterator.ArrayIterator;
    import vegas.data.iterator.Iterable;
    import vegas.data.iterator.Iterator;
    
    import vegas.util.ClassUtil ;
    import vegas.util.Copier ;
    import vegas.util.Serializer ;
        
    import flash.utils.Proxy;
    import flash.utils.flash_proxy 
    
    /**
     * The ProxyArray class.
     * <p><b>Example :</b></p>
     * <p>{@code
     * var a:ProxyArray = new ProxyArray() ;
     * a.push("item1") ;
     * a.push("item2") ;
     * a.push("item3") ;
     * a.push("item4") ;
     * 
     * trace("> " + a) ;
     * trace("source : " + a.toSource()) ;
     * var a2:ProxyArray = new ProxyArray( [[1, 2], [3, 4]] ) ;
     * var copy:ProxyArray = a2.copy() ;
     * copy[1][0] = "new value" ;  
     * trace(a2 + " : " + copy) ;
	 * }
	 * </p>
     * @author eKameleon
     */
    dynamic public class ProxyArray extends Proxy implements ICloneable, ICopyable, IFormattable, IHashable, Iterable, ISerializable
    {
        
		/**
		 * Creates a new ProxyArray instance.
		 */        
        public function ProxyArray( ar:Array=null )
        {
            _ar = (ar == null) ? [] : [].concat(ar)  ;
        }
		
    	/**
    	 * Init HashCode method.
		 */
		HashCode.initialize(ProxyArray.prototype) ;
		
        /**
         * Init Proxy.
         */
        flash_proxy override function callProperty( methodName:*, ... args):* 
        {
            var res:* ;
            switch (methodName.toString()) 
            {
            
                default :
                    res = _ar[methodName].apply(_ar, args);
                    break;
                    
            }
            return res ;
        }
        
        /**
         * Init Proxy getProperty.
         */
        flash_proxy override function getProperty(name:*):* 
        {
            return _ar[name];
        }
		
        /**
         * Init Proxy setProperty.
         */
        flash_proxy override function setProperty(name:*, value:*):void 
        {
            _ar[name] = value;
        }
		
		/**
		 * Creates and returns a shallow copy of the object.
		 */	
        public function clone():*
        {
            return new ProxyArray(_ar.slice()) ;
        }
		
		/**
		 * Creates and returns a deep copy of the object.
		 */	
        public function copy():*
        {
            return new ProxyArray(Copier.copy(_ar)) ;
		}
		
		/**
		 * Returns a hashcode value for the object.
		 */
        public function hashCode():uint
        {
            return null ;
		}

		/**
		 * Returns the iterator of the object.
		 */
    	public function iterator():Iterator 
    	{
		    return new ArrayIterator(_ar) ;
	    }

		/**
		 * Returns a Eden reprensation of the object.
		 * @return a string representing the source code of the object.
		 */
        public function toSource(...arguments):String
        {
            return "new " + ClassUtil.getPath(this) + "(" + getSourceParams() + ")" ;
        }

		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance
		 */
        public function toString():String
        {
            return _ar.toString() ;
        }
		
        /**
         * This method is used in toSource method.
         */  
        protected function getSourceParams():String
        {
            return Serializer.toSource(_ar) ;
        }
		
		/**
		 * Internal array used in the proxy pattern.
		 */        
        protected var _ar:Array ;
        
    }
}