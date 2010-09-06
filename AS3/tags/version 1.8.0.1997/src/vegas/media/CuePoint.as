﻿/*

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

package vegas.media 
{
    import vegas.vo.SimpleValueObject;
    
    /**
     * The CuePoint information object.
     */
    public class CuePoint extends SimpleValueObject 
    {
        /**
         * Creates a new CuePoint instance.
         * @param init An Object with the properties 'name', 'parameters', 'time' and 'type' used to define this CuePoint object.
         */    
        public function CuePoint(init:Object = null)
        {
            super( init );
        }
        
        /**
         * The name of the CuePoint.
         */
        public var name:String ;
            
        /**
         * A associative array of name/value pair strings specified for this cue point. 
         * Any valid string can be used for the parameter name or value.
         */
        public var parameters:Array ;
        
        /**
         * The time of the CuePoint.
         */
        public var time:String ;
            
        /**
         * The type of the CuePoint.
         */
        public var type:String ;
        
        /**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
        public override function toString():String
        {
            var txt:String = "[CuePoint" ;
            if (name != null)
            {
                txt += ",name:" + name ;
            }
            if (time != null)
            {
                txt += ",time:" + time ;
            }
            if (type != null)
            {
                txt += ",type:" + type ;
            } 
            if (parameters != null)
            {
                txt += ",parameters:" + parameters ;
            } 
            txt += "]" ;
            return txt ;     
        }
        
    }

}