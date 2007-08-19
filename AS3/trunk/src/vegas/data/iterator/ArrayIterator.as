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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.data.iterator
{
    
    import vegas.core.CoreObject ;
    
    import vegas.data.iterator.Iterator ;
    
    import vegas.util.ClassUtil ;
    import vegas.util.MathsUtil ;
    import vegas.util.Serializer ;

    public class ArrayIterator extends CoreObject implements Iterator
    {
        
        public function ArrayIterator( a:Array )
        {
 		   _a = a ;
    	   _k = -1 ;
        }
        
        public function hasNext():Boolean
        {
            return (_k < _a.length - 1);
        }

        public function key():*
        {
            return _k ;
        }
        
        public function next():*
        {
           return _a[++_k] ;
        }
        
        public function remove():*
        {
            return _a.splice( _k-- , 1 );
        }
        
        public function reset():void
        {
            _k = -1 ;
        }        

        public function seek(position:*):void
        {
		    _k = MathsUtil.clamp ((position-1), -1, _a.length) ;
        }

        override public function toSource(...arguments:Array):String 
        {
            return "new " + ClassUtil.getPath(this) + "(" + Serializer.toSource(_a) + ")" ;
        }

	    protected var _a:Array ; // current array

    	protected var _k:Number ; // current key

    }
}