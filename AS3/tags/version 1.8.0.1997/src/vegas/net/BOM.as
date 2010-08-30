﻿/*  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at              http://www.mozilla.org/MPL/     Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the License.     The Original Code is VEGAS Framework.    The Initial Developer of the Original Code is  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.  Portions created by the Initial Developer are Copyright (C) 2004-2010  the Initial Developer. All Rights Reserved.    Contributor(s) :    Alternatively, the contents of this file may be used under the terms of  either the GNU General Public License Version 2 or later (the "GPL"), or  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),  in which case the provisions of the GPL or the LGPL are applicable instead  of those above. If you wish to allow use of your version of this file only  under the terms of either the GPL or the LGPL, and not to allow others to  use your version of this file under the terms of the MPL, indicate your  decision by deleting the provisions above and replace them with the notice  and other provisions required by the LGPL or the GPL. If you do not delete  the provisions above, a recipient may use your version of this file under  the terms of any one of the MPL, the GPL or the LGPL.  */package vegas.net {    import core.reflect.getClassName;    /**     * The BOM enumeration class.      * A byte-order mark (BOM) is the Unicode character at code point U+FEFF ("zero-width no-break space") when that character is used to denote the endianness of a string of UCS/Unicode characters encoded in UTF-16 or UTF-32. It is conventionally used as a marker to indicate that text is encoded in UTF-8, UTF-16 or UTF-32.     * <p>More informations in Wikipedia : <a href="http://en.wikipedia.org/wiki/Byte-order_mark#endnote_UTF-8">Byte-order mark</a></p>     */    public class BOM    {        /**         * Creates a new BOM instance.         * @param name The name key of the enumeration.         * @param values The Array representation of all values of the BOM enumeration.         */        public function BOM( name:String = "" , values:Array = null  , option:* = null )        {            _name   = name   ;            _values = values ;            _option = option ;        }                /**         * The optional value of the BOM (only in the BOCU-1 BOM).         */        public function get option():*        {        	return _option ;        }                /**         * Returns the source code String representation of the object.         * @return the source code String representation of the object.         */        public function toSource( indent:int = 0 ):String        {            var classname:String = getClassName( this );            if( _name != "" )            {                return classname + "." + _name;            }            return classname;        }                /**         * Returns the String representation of the object.         * @return the String representation of the object.         */        public function toString():String        {            return _name;        }                /**         * Returns the primitive value of the object.         * @return the primitive value of the object.         */        public function valueOf():*        {            return _values ;        }                /**         * The UTF-8 BOM.         * <p>More informations in Wikipedia : <a href="http://en.wikipedia.org/wiki/UTF-8">UTF-8</a></p>         */        public static const UTF8:BOM = new BOM( "UTF-8", [ 0xEF , 0xBB , 0xBF ] ) ;                /**         * The UTF-16 (BE) BOM.         * <p>More informations in Wikipedia : <a href="http://en.wikipedia.org/wiki/UTF-16">UTF-16/UCS-2</a></p>         */        public static const UTF16_BE:BOM = new BOM( "UTF16_BE", [ 0xFE , 0xFF ] ) ;                /**         * The UTF-16 (LE) BOM.         * <p>More informations in Wikipedia : <a href="http://en.wikipedia.org/wiki/UTF-16">UTF-16/UCS-2</a></p>         */        public static const UTF16_LE:BOM = new BOM( "UTF16_LE", [ 0xFF , 0xFE ] ) ;                /**         * The UTF-32 (BE) BOM.         * <p>More informations in Wikipedia : <a href="http://en.wikipedia.org/wiki/UTF-32">UTF-32/UCS-4</a></p>         */        public static const UTF32_BE:BOM = new BOM( "UTF32_BE", [ 0x00 , 0x00 , 0xFE , 0xFF ] ) ;                /**         * The UTF-32 (LE) BOM.         * <p>More informations in Wikipedia : <a href="http://en.wikipedia.org/wiki/UTF-32">UTF-32/UCS-4</a></p>         */        public static const UTF32_LE:BOM = new BOM( "UTF32_LE", [ 0xFF , 0xFE , 0x00 , 0x00 ] ) ;                /**         * The UTF-7 BOM.         * <p>More informations in Wikipedia : <a href="http://en.wikipedia.org/wiki/UTF-7">UTF-7</a></p>         */        public static const UTF7:BOM = new BOM( "UTF7", [ 0x2B , 0x2F , 0x76 , 0x38 | 0x39 | 0x2B | 0x2F ] ) ;                /**         * The UTF-1 BOM.         * <p>More informations in Wikipedia : <a href="http://en.wikipedia.org/wiki/UTF-1">UTF-1</a></p>         */        public static const UTF1:BOM = new BOM( "UTF1", [ 0xF7 , 0x64 , 0x4C ] ) ;                    /**         * The UTF-EBCDIC BOM.         * <p>More informations in Wikipedia : <a href="http://en.wikipedia.org/wiki/UTF-EBCDIC">UTF-EBCDIC</a></p>         */        public static const UTF_EBCDIC:BOM = new BOM( "UTF_ECBDIC", [ 0xDD , 0x73 , 0x66 , 0x73 ] ) ;                /**         * The SCSU BOM.         * <p>More informations in Wikipedia : <a href="http://en.wikipedia.org/wiki/Standard_Compression_Scheme_for_Unicode">Standard Compression Scheme for Unicode</a></p>         */        public static const SCSU:BOM = new BOM( "SCSU", [ 0x0E , 0xFE , 0xFF ] ) ;                /**         * The BOCU-1 BOM.         * <p>More informations in Wikipedia : <a href="http://en.wikipedia.org/wiki/BOCU-1">Binary Ordered Compression for Unicode</a></p>         */        public static const BOCU_1:BOM = new BOM( "BOCU_1", [ 0xFB , 0xEE , 0x28 ] , 0xFF ) ; // use option                /**         * @private         */        private var _name:String ;                /**         * @private         */        private var _option:* ;                /**         * @private         */        private var _values:Array ;    }}