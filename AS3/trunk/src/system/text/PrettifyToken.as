
package system.text 
{

	/**
	 * Token style names. Correspond to css classes.
	 * @author eKameleon
	 */
	public class PrettifyToken 
	{
		
		/** 
		 * Token style for a string literal.
		 */
		public static const STRING:String = 'str' ;
		
		/** 
		 * Token style for a keyword.
		 */
		public static const KEYWORD:String = 'kwd' ;
		
		/**
		 * Token style for a comment.
		 */
		public static const COMMENT:String = 'com' ;
		
		/**
		 * Token style for a type.
		 */
		public static const TYPE:String = 'typ' ;
		
		/**
		 * Token style for a literal value (e.g. 1, null, true).
		 */
		public static const LITERAL:String = 'lit' ;
		
		/**
		 * Token style for a punctuation string.
		 */
		public static const PUNCTUATION:String = 'pun';
		
		/**  
		 * Token style for a punctuation string.
		 */
		public static const PLAIN:String = 'pln';
		
		/**
		 * Token style for an sgml tag.
		 */
		public static const TAG:String = 'tag';
		
		/**
		 * Token style for a markup declaration such as a DOCTYPE.
		 */
		public static const DECLARATION:String = 'dec' ;
		
		/**
		 * Token style for embedded source.
		 */
		public static const SOURCE:String = 'src' ;
		
		/**
		 * Token style for an sgml attribute name.
		 */
		public static const ATTRIB_NAME:String = 'atn' ;
		
		/**
		 * Token style for an sgml attribute value.
		 */
		public static const ATTRIB_VALUE:String = 'atv' ;
		
		
	}
	
}
