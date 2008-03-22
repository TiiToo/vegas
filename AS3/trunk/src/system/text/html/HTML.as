﻿/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
  	- Alcaraz Marc (aka eKameleon) <ekameleon@gmail.com> (2007-2008)

*/
package system.text.html
    {
    import system.text.html.Entities;
        
    /**
     * The HTML tool class.
     */
    public class HTML
        {
        
        private var _data:String;
        
        /**
         * Creates a new HTML instance.
         * @param text The HTML text value of the object.
         * @param convert The convert flag who indicates if the html text must be encoded.
         */
        public function HTML( text:String = "", convert:Boolean = true )
            {
            if( convert )
                {
                text = HTML.encode( text );
                }
            _data = text;
            }
        
        /**
         * Appends the specified text in the HTML string.
         * @param text The text to append.
         * @param convert Indicates if the text is encoded. 
         */
        public function append( text:String, convert:Boolean = true ):void
            {
            if( convert )
                {
                text = HTML.encode( text );
                }
            _data += text;
            }        
        
	    /**
	     * Encodes the specified text passed in argument.
	     * <p><b>Example :</b></p>
	     * <pre class="prettyprint">
	     * import system.text.html.HTML  ;
	     * trace( HTML.encode("<b>hello world</b>" ) ) ; // &lt;b&gt;hello world&lt;/b&gt;
	     * </pre>
	     * @return a string encode text.
	     */
        public static function encode( text:String ):String
            {
            var html:String = "";
            var c:String;
            var last:String;
            
            var l:uint = text.length ;
            for( var i:uint = 0; i<l ; i++ )
                {
                c = text.charAt(i);
                
                if( (c == " ") && (last != " ") )
                    {
                    html += c;
                    last = c;
                    continue;
                    }
                
                if( Entities.findByChar( c ) )
                    {
                    html += Entities.toHTML( c );
                    } 
                else
                    {
                    html += c;
                    }
                
                last = c;
                }
            
            return html;
            }
        
	    /**
	     * Decodes the specified string.
	     * <p><b>Example :</b></p>
	     * <pre class="prettyprint">
	     * import system.text.html.HTML  ;
	     * trace( HTML.decode("&lt;b&gt;hello world&lt;/b&gt;" ) ) ; // <b>hello world</b>
	     * </pre>
	     * @return the decode string.
	     */        
        public static function decode( html:String ):String
            {
            var text:String = "";
            var c:String;
            var ent:String;
            var l:uint = html.length ;
            for( var i:uint = 0 ; i<l ; i++ )
                {
                c = html.charAt(i);
                
                if( c == "&" )
                    {
                    ent = c;
                    i++;
                    
                    while( c != ";" )
                        {
                        c = html.charAt(i);
                        ent += c;
                        i++;
                        }
                    
                    text += Entities.fromName( ent );
                    i--;
                    continue;
                    }
                
                text += c;
                }
            
            return text;
            }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
            {
            return _data;
            }
        
        /* TODO:
           - method toXML or toXMLString
           - method valueOf ? doing an HTML decode to obtain the raw string ? or toHTMLString method
           - static methods to handle HTML tags as bold, paragraph, font, etc. (or a Tag class, BoldTag class, FontTag class, etc...)
        */
        
        }
    }

