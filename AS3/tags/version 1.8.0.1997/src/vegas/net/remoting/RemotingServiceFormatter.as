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

package vegas.net.remoting
{
    import core.dump;
    import core.reflect.getClassName;

    import system.data.Iterable;
    import system.data.Iterator;
    import system.formatters.Formattable;

    /**
     * Formats a RemotingService object in this String representation.
     */
    public class RemotingServiceFormatter implements Formattable
    {
        /**
         * Creates a new RemotingServiceFormatter instance.
         */
        public function RemotingServiceFormatter()
        {
            super();
        }
        
        /**
         * Converts the object to a custom string representation.
         */
        public function format( value:* = null ):String
        {
            var rs:RemotingService = value as RemotingService;
            if ( rs == null )
            {
                return "" ;
            }
            var r:* = rs.getResult() ;
            var txt:String = "[" + getClassName(rs) ;
            if ( rs.serviceName )
            {
                txt += " serviceName:" + rs.serviceName ;
            }
            if ( rs.methodName )
            {
                txt  += " methodName:" + rs.methodName ;
            }
            if (rs.serviceName)
            {
                txt += " result:" ;
            }
            if (r != undefined) 
            {
                if (r is Iterable) 
                {
                    txt += "[\r" ;
                    var it:Iterator = (r as Iterable).iterator() ;
                    while ( it.hasNext() ) 
                    {
                        txt += "\t" + dump( it.next() ) + "\r" ;
                    }
                } 
                else 
                {
                    txt += r  ;
                }
                txt += "]" ;
            }
            else 
            {
                txt += "empty]";
            }
            return txt ;
        }
    }
}