/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard AS3 Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.net.remoting
{
    import system.Reflection;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.formatters.Formattable;
    
    import vegas.core.CoreObject;
    import vegas.util.TypeUtil;    

    /**
	 * Formats a RemotingService object in this String representation.
     */
	public class RemotingServiceFormatter extends CoreObject implements Formattable
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
			var txt:String = "[" + Reflection.getClassName(rs) ;
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
						var item:* = it.next() ;
						if (TypeUtil.isExplicitInstanceOf( item, Object ) )
						{
							txt += "\t[\r" ;
							for (var prop:String in value) 
							{
								txt += "\t\t " + prop + " : " + item[prop] + "\r" ;
							}	
							txt += "\t] " ; 
							txt += ( it.hasNext() ) ? "," : "" ;
							txt += "\r" ;
						}
						else
						{
							txt += "\t" + item + "\r" ;
						}
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