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

package vegas.net 
{
    import system.data.Set;
    import system.data.sets.HashSet;
    
    import flash.utils.Dictionary;
    
    /**
     * Multipurpose Internet Mail Extensions (MIME), an Internet media type, originally called a MIME type after MIME and sometimes a Content-type after the name of a header in several protocols whose value is such a type, is a two-part identifier for file formats on the Internet. The identifiers were originally defined in RFC 2046 for use in e-mail sent through SMTP, but their use has expanded to other protocols such as HTTP and SIP.
     * <p>See : <a href="http://www.iana.org/assignments/media-types/text/">http://www.iana.org/assignments/media-types/text/</a> and <a href="http://www.mimetype.org/">http://www.mimetype.org/</a></p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.net.MIME ;
     * 
     * trace( "MIME type 'video/mpeg' extensions : " + MIME.getExtensions("video/mpeg") ) ;
     * trace( "MIME type of the htm extension    : " + MIME.getMimeTypeByExtension("htm") ) ;
     * trace( "MIME type of the jar extension    : " + MIME.getMimeTypeByExtension("jar") ) ;
     * 
     * trace( "---" ) ;
     * 
     * trace( "All MIME types : "  + MIME.getMimeTypes() ) ;
     * </pre>
     */
    public class MIME 
    {
        /**
         * Creates a new Mime instance.
         * @param mimeType The MIME type expression to register.
         * @param extensions The optional Array representation of all extensions of this MIME type.
         */
        public function MIME( mimeType:String = null , extensions:Array = null )
        {
            if ( mimeType != null )
            {
                var a:Array = mimeType.split("/") ;
                this.type = a[0] as String ;
                this.subType = a[1] as String ;
            }
            _extensions = new HashSet() ;
            if ( extensions != null && extensions.length > 0 )
            {
                var l:int = extensions.length ;
                for (var i:int ;i < l; i++ )
                {
                    addExtension(extensions[i]) ;
                }
            }
        }
        
        /**
         * The set of all extensions of this MimeType. 
         */
        public function get extensions():Array
        {
            return _extensions.toArray() ;
        }
        
        /**
         * The subType of the MIME type.
         */
        public var subType:String ;
        
        /**
         * The type of the MIME type.
         */
        public var type:String ;
        
        /**
         * Add a new extension in the collection of all extensions of this MIME type.
         * @return <code class="prettyprint">true</code> if the extension is inserted in the collection of all extensions. 
         */
        public function addExtension( ext:String ):Boolean
        {
            if ( ext != null )
            {
                return _extensions.add(ext) ; 
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Removes an extension in the collection of all extensions of this MIME type.
         * @return <code class="prettyprint">true</code> if the extension is removed. 
         */
        public function removeExtension( ext:String ):Boolean
        {
            return ( ext != null ) ? _extensions.remove(ext) : false ; 
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            return type + "/" + subType ;
        }
        
        /**
         * Returns the real value of the object.
         * @return the real value of the object.
         */
        public function valueOf():String
        {
            return type + "/" + subType ;
        }
        
        /**
         * @private
         */
        private var _extensions:Set ;
        
        /**
         * The types dictionary of all MIME types.
         */
        public static const TYPES:Dictionary = new Dictionary(true) ;
        
        /**
         * Adds the specified mimeType in the dictionary of all MIME types and specified this extensions.
         */
        public static function addMimeType( mimeType:String , ...extensions:Array ):void
        {
            TYPES[mimeType] = new MIME(mimeType, extensions) ;
        }
        
        /**
         * Returns the Array representaiton of all extensions of the specified MIME type.
         * @return the Array representaiton of all extensions of the specified MIME type.
         */
        public static function getExtensions( mimeType:String ):Array
        {
            if ( ( TYPES[ mimeType ] as MIME) != null )
            {
                return (TYPES[mimeType] as MIME).extensions ;
            }
            else
            {
                return null ;
            }
        }
        
        /**
         * Returns the MIME representation of the specified mimeType expression.
         * @return the MIME representation of the specified mimeType expression.
         */
        public static function getMimeType( mimeType:String ):MIME
        {
            return TYPES[ mimeType ] ;
        }
        
        /**
         * Returns the MIME representation of the specified mimeType expression.
         * @return the MIME representation of the specified mimeType expression.
         */
        public static function getMimeTypeByExtension( ext:String ):MIME
        {
            var e:Array   ;
            for each( var item:MIME in TYPES )
            {
                e = item.extensions ;
                if ( e != null && e.length > 0 )
                {
                    for each( var s:String in e )
                    {
                        if ( s == ext )
                        {
                            return item ;
                        }
                    }
                }
            }
            return null ;
        }
        
        /**
         * Returns the MIME representation of the specified mimeType expression.
         * @return the MIME representation of the specified mimeType expression.
         */
        public static function getMimeTypes():Array
        {
            var ar:Array = [] ;
            for each( var item:* in TYPES )
            {
                ar.push( item ) ;
            }
            return ar ;
        }
        
        // application MIME types
        
        addMimeType("application/SLA", "stl") ;
        addMimeType("application/STEP", "step", "step") ;
        addMimeType("application/acad" , "dwg" ) ;        
        addMimeType("application/andrew-inset", "ez") ;
        addMimeType("application/atom+xml", "atom") ;
        addMimeType("application/excel", "xls" ) ;
        addMimeType("application/java-archive", "jar" ) ;        addMimeType("application/javascript", "js" ) ;
        addMimeType("application/json", "json" ) ;
        addMimeType("application/mac-binhex40", "hqx") ;
        addMimeType("application/mac-compactpro", "cpt") ;
        addMimeType("application/mathml+xml", "mathml") ;
        addMimeType("application/msword", "doc") ;
        addMimeType("application/octet-stream", "bin", "dms", "lha", "lzh", "exe", "class", "so", "dll", "dmg") ;
        addMimeType("application/oda", "oda") ;
        addMimeType("application/ogg", "ogg") ;
        addMimeType("application/pdf", "pdf") ;
        addMimeType("application/postscript", "ai", "eps", "ps") ;
        addMimeType("application/rdf+xml", "rdf") ;
        addMimeType("application/smil", "smi", "smil") ;
        addMimeType("application/srgs", "gram") ;
        addMimeType("application/srgs+xml", "grxml") ;
        addMimeType("application/vnd.adobe.apollo-application-installer-package+zip", "air") ;
        addMimeType("application/vnd.mif", "mif") ;
        addMimeType("application/vnd.mozilla.xul+xml", "xul") ;
        addMimeType("application/vnd.ms-excel", "xls") ;
        addMimeType("application/vnd.ms-powerpoint", "ppt") ;
        addMimeType("application/vnd.rn-realmedia", "rm") ;
        addMimeType("application/vnd.wap.wbxml", "wbxml") ;
        addMimeType("application/vnd.wap.wmlc", "wmlc") ;
        addMimeType("application/vnd.wap.wmlscriptc", "wmlsc") ;
        addMimeType("application/voicexml+xml", "vxml") ;
        addMimeType("application/x-bcpio", "bcpio") ;
        addMimeType("application/x-cdlink", "vcd") ;
        addMimeType("application/x-chess-pgn", "pgn") ;
        addMimeType("application/x-cpio", "cpio") ;
        addMimeType("application/x-csh", "csh") ;
        addMimeType("application/x-director", "dcr", "dir", "dxr") ;
        addMimeType("application/x-dvi", "dvi") ;
        addMimeType("application/x-futuresplash", "spl") ;
        addMimeType("application/x-gtar", "gtar") ;
        addMimeType("application/x-hdf", "hdf") ;
        addMimeType("application/x-javascript", "js") ;
        addMimeType("application/x-koan", "skp", "skd", "skt", "skm") ;
        addMimeType("application/x-latex", "latex") ;
        addMimeType("application/x-netcdf", "nc", "cdf") ;
        addMimeType("application/x-sh", "sh") ;
        addMimeType("application/x-shar", "shar") ;
        addMimeType("application/x-shockwave-flash", "swf") ;
        addMimeType("application/x-stuffit", "sit") ;
        addMimeType("application/x-sv4cpio", "sv4cpio") ;
        addMimeType("application/x-sv4crc", "sv4crc") ;
        addMimeType("application/x-tar", "tar") ;
        addMimeType("application/x-tcl", "tcl") ;
        addMimeType("application/x-tex", "tex") ;
        addMimeType("application/x-texinfo", "texinfo", "texi") ;
        addMimeType("application/x-troff", "t", "tr", "roff") ;
        addMimeType("application/x-troff-man", "man") ;
        addMimeType("application/x-troff-me", "me") ;
        addMimeType("application/x-troff-ms", "ms") ;
        addMimeType("application/x-ustar", "ustar") ;
        addMimeType("application/x-wais-source", "src") ;
        addMimeType("application/xhtml+xml", "xhtml", "xht") ;
        addMimeType("application/xml", "xml", "xsl") ;
        addMimeType("application/xml-dtd", "dtd") ;
        addMimeType("application/xslt+xml", "xslt") ;
        addMimeType("application/zip", "zip") ;
        
        // audio MIME types
        
        addMimeType("audio/basic", "au", "snd") ;
        addMimeType("audio/midi", "mid", "midi", "kar") ;
        addMimeType("audio/mpeg", "mp3", "mpga", "mp2") ;
        addMimeType("audio/x-aiff", "aif", "aiff", "aifc") ;
        addMimeType("audio/x-mpegurl", "m3u") ;
        addMimeType("audio/x-pn-realaudio", "ram", "ra") ;
        addMimeType("audio/x-wav", "wav") ;
        
        // chemical MIME types
        
        addMimeType("chemical/x-pdb", "pdb") ;
        addMimeType("chemical/x-xyz", "xyz") ;
        
        // image MIME types
        
        addMimeType("image/bmp", "bmp") ;
        addMimeType("image/cgm", "cgm") ;
        addMimeType("image/gif", "gif") ;
        addMimeType("image/ief", "ief") ;
        addMimeType("image/jpeg", "jpg", "jpeg", "jpe") ;
        addMimeType("image/png", "png") ;
        addMimeType("image/svg+xml", "svg") ;
        addMimeType("image/tiff", "tiff", "tif") ;
        addMimeType("image/vnd.djvu", "djvu", "djv") ;
        addMimeType("image/vnd.wap.wbmp", "wbmp") ;
        addMimeType("image/x-cmu-raster", "ras") ;
        addMimeType("image/x-icon", "ico") ;
        addMimeType("image/x-portable-anymap", "pnm") ;
        addMimeType("image/x-portable-bitmap", "pbm") ;
        addMimeType("image/x-portable-graymap", "pgm") ;
        addMimeType("image/x-portable-pixmap", "ppm") ;
        addMimeType("image/x-rgb", "rgb") ;
        addMimeType("image/x-xbitmap", "xbm") ;
        addMimeType("image/x-xpixmap", "xpm") ;
        addMimeType("image/x-xwindowdump", "xwd") ;
        
        // model MIME types
        
        addMimeType("model/iges", "igs", "iges") ;
        addMimeType("model/mesh", "msh", "mesh", "silo") ;
        addMimeType("model/vrml", "wrl", "vrml") ;
        
        // text MIME types
        
        addMimeType("text/calendar", "ics", "ifb") ;
        addMimeType("text/css", "css") ;
        addMimeType("text/ecmascript" , "es" , "eden" ) ;
        addMimeType("text/javascript" , "js" ) ;
        addMimeType("text/html", "html", "htm") ;
        addMimeType("text/plain", "txt", "asc", "m", "hh", "h", "f", "f90", "cc", "c", "asc txt") ;
        addMimeType("text/richtext", "rtx") ;
        addMimeType("text/rtf", "rtf") ;
        addMimeType("text/sgml", "sgml", "sgm") ;
        addMimeType("text/tab-separated-values", "tsv") ;
        addMimeType("text/vnd.wap.wml", "wml") ;
        addMimeType("text/vnd.wap.wmlscript", "wmls") ;
        addMimeType("text/vnd.sun.j2me.app-descriptor", "jad") ;
        addMimeType("text/x-setext", "etx") ;
        addMimeType("text/xml", "xml") ;
        
        // video MIME types
        
        addMimeType("video/dl", "dl") ;
        addMimeType("video/fli", "fli") ;
        addMimeType("video/flv", "flv") ;
        addMimeType("video/gl", "gl") ;        addMimeType("video/h264", "h264") ;
        addMimeType("video/mpeg", "mpg", "mpeg", "mpe", "mp2") ;
        addMimeType("video/quicktime", "mov", "qt") ;
        addMimeType("video/vnd.fvt", "fvt") ;        addMimeType("video/vnd.mpegurl", "m4u", "mxu") ;
        addMimeType("video/vnd.vivo", "viv", "vivo") ;
        addMimeType("video/x-f4v", "f4v") ;        addMimeType("video/x-fli", "fli") ;        addMimeType("video/x-flv", "flv") ;
        addMimeType("video/x-m4v", "m4v") ;
        addMimeType("video/x-ms-asf", "asf") ;
        addMimeType("video/x-ms-asx", "asx") ;
        addMimeType("video/x-ms-wm", "wm") ;        addMimeType("video/x-ms-wmv", "wmv") ;
        addMimeType("video/x-ms-wmx", "wmx") ;
        addMimeType("video/x-ms-wvx", "wvx") ;
        addMimeType("video/x-msvideo", "avi") ;
        addMimeType("video/x-sgi-movie", "movie") ;        addMimeType("x-conference/x-cooltalk", "ice") ;
        
        // www/mime
        
        addMimeType("www/mime", "mime") ;
        
        // x-conference MIME types
        
        addMimeType("x-conference/x-cooltalk", "ice") ;
        
        // x-world MIME types
        
        addMimeType("x-world/x-vrml", "vrm", "vrml") ;
    }
}
