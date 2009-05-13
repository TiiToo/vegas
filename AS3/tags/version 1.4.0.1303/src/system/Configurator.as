﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2009
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
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

package system
{

    /**
     * The Configurator class defines the basic class used to creates custom configurations.
     */    
    public class Configurator implements Serializable
    {

        /**
         * The internal config object of the configurator.
         * @private
         */
        protected var _config:Object;

        /**
         * Creates a new Configurator object.
         * @param config This argument initialize the configurator with a generic object.
         */        
        public function Configurator( config:Object )
        {
            _config = {};
            load( config );
        }

        /**
         * Copy all properties in the specified passed-in object in the internal config object of the Configurator.
         */
        public function load( config:Object ):void
        {
            for( var member:String in config )
            {
                _config[member] = config[member] ;
            }
        }

        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String
        {
            config.serializer.prettyIndent = indent;
            return config.serializer.serialize( _config );
            /*
            var original:int = eden.prettyIndent;
            eden.prettyIndent = indent;
            var str:String = eden.serialize( _config );
            eden.prettyIndent = original;
            return str;
            */
        }

        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            return toSource( );
        }
    }
}

