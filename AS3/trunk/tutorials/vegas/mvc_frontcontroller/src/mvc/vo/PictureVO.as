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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package mvc.vo
{
    import core.reflect.getClassName;

    import vegas.vo.SimpleValueObject;
    
    /**
     * The value object a of picture element in the GalleryModel.
     */
    public class PictureVO extends SimpleValueObject
    {
        /**
         * Creates a new PictureVO instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function PictureVO( init:Object = null )
        {
            super( init ) ;
        }
        
        /**
         * The name of the picture.
         */
        public var name:String ;
        
        /**
         * The url of the picture.
         */
        public var url:String ;
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public override function toString():String
        {
            return formatToString( getClassName(this) , "id" , "name" , "url" ) ;
        }
    }
}