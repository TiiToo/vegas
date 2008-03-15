
package system.text 
{

	/**
	 * This tool class contains HTML static utility methods.
	 * @author eKameleon
	 */
	public class HTMLUtils 
	{
		
		/**
		 * Likes textToHtml but escapes double quotes to be attribute safe.
		 */
		public static function attribToHtml(str:String):String  
		{
  			return str.replace( amp, '&amp;').replace( lt, '&lt;' ).replace( gt, '&gt;').replace( quot , '&quot;' ) ;
		}

		/**
		 * Unescapes html to plain text.
		 */
		public static function htmlToText( html:String ):String 
		{
  			var pos:int = html.indexOf('&');
	  		if (pos < 0) 
  			{ 
	  			return html; 
  			}
  			for ( --pos ; ( pos = html.indexOf('&#', pos + 1)) >= 0 ; ) 
	  		{
    			var end:int = html.indexOf(';', pos);
    			if (end >= 0) 
    			{
					var num:String = html.substring(pos + 3, end);
					var radix:uint = 10;
      				if (num && num.charAt(0) == 'x') 
      				{
	        			num = num.substring(1);
        				radix = 16;
      				}
      				var codePoint:int = parseInt(num, radix) ;
      				if (!isNaN(codePoint)) 
      				{
	        			html = ( html.substring(0, pos) + String.fromCharCode(codePoint) +  html.substring(end + 1) ) ;
      				}
    			}
  			}
			
  			return html.replace(reverse_lt, '<').replace(reverse_gt, '>').replace(reverse_apos, "'").replace(reverse_quot, '"').replace(reverse_amp, '&');
		}

		/**
		 * Escapest html special characters to html.
		 */
		public static function textToHtml( str:String ):String 
		{
  			return str.replace( amp, '&amp;').replace( lt, '&lt;').replace( gt, '&gt;') ;
		}		
		
		/**
		 * @private
		 */
		private static var amp:RegExp = new RegExp( "&"  , "g" ) ;

		/**
		 * @private
		 */
		private static var lt:RegExp = new RegExp( "<"  , "g" ) ;

		/**
		 * @private
		 */
		private static var gt:RegExp = new RegExp( ">"  , "g" ) ;

		/**
		 * @private
		 */
		private static var quot:RegExp = new RegExp( "\"" , "g" ) ;
		
		/**
		 * @private
		 */
		private static var reverse_lt:RegExp   = new RegExp( "&lt;"    , "g" ) ;

		/**
		 * @private
		 */
		private static var reverse_gt:RegExp = new RegExp( "&gt;"    , "g" ) ;
		
		/**
		 * @private
		 */
		private static var reverse_apos:RegExp = new RegExp( "&apos;"  , "g" ) ;

		/**
		 * @private
		 */
		private static var reverse_quot:RegExp = new RegExp( "&quot;"  , "g" ) ;
		
		/**
		 * @private
		 */
		private static var reverse_amp:RegExp  = new RegExp( "&amp;"   , "g" ) ;		
		

	}
}
