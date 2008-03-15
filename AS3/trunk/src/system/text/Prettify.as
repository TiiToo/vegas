
package system.text 
{

	// in progress... don't use it for the moment.

	/**
	 * The Google Prettify AS3 implementation. 
	 * @author eKameleon
	 */
	public class Prettify 
	{
		
		
		public static var keywords:Object = {} ;
		
		public static var CPP_KEYWORDS     :String = "abstract bool break case catch char class const const_cast continue default delete deprecated dllexport dllimport do double dynamic_cast else enum explicit extern false float for friend goto if inline int long mutable naked namespace new noinline noreturn nothrow novtable operator private property protected public register reinterpret_cast return selectany short signed sizeof static static_cast struct switch template this thread throw true try typedef typeid typename union unsigned using declaration, directive uuid virtual void volatile while typeof";
		public static var CSHARP_KEYWORDS  :String = "as base by byte checked decimal delegate descending event finally fixed foreach from group implicit in interface internal into is lock null object out override orderby params readonly ref sbyte sealed stackalloc string select uint ulong unchecked unsafe ushort var" ;
		public static var JAVA_KEYWORDS    :String = "package synchronized boolean implements import throws instanceof transient extends final strictfp native super" ;
		public static var JSCRIPT_KEYWORDS :String = "debugger export function with NaN Infinity";
		public static var PERL_KEYWORDS    :String = "require sub unless until use elsif BEGIN END";
		public static var PYTHON_KEYWORDS  :String = "and assert def del elif except exec global lambda not or pass print raise yield False True None" ;
		public static var RUBY_KEYWORDS    :String = "then end begin rescue ensure module when undef next redo retry alias defined" ;
		public static var SH_KEYWORDS      :String = "done fi";
		
		public static var KEYWORDS:Array = 
		[
			CPP_KEYWORDS     , 
			CSHARP_KEYWORDS  , 
			JAVA_KEYWORDS    ,
			JSCRIPT_KEYWORDS , 
			PERL_KEYWORDS    , 
			PYTHON_KEYWORDS  ,
			RUBY_KEYWORDS    , 
			SH_KEYWORDS
		] ;
		
		public static function initialize():void
		{
			var size:uint = KEYWORDS.length ;
			for (var k:uint = 0; k < size ; k++) 
			{
	    		var kw:Array = (KEYWORDS[k] as String).split(' ') ;
    			var len:uint = kw.length ;
    			for (var i:uint = 0; i < len ; i++ ) 
    			{
	      			if ( kw[i] ) 
      				{ 
	      				keywords[ kw[i] ] = true ; 
      				}
    			}
  			}
		}
		initialize() ;
  		
		/**
		 * The number of characters between tab columns.
		 */
		public static var TAB_WIDTH:uint = 8 ;	
  		
  		/**
  		 * Indicates if the word is a char.
  		 */
		public static function isWordChar( ch:String ):Boolean
		{
  			return (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z');
		}
		
		/** 
		 * A set of tokens that can precede a regular expression literal in javascript.
		 * http://www.mozilla.org/js/language/js20/rationale/syntax.html has the full list, 
		 * but I've removed ones that might be problematic when seen in languages that don't support regular expression literals.
		 * <p>Specifically, I've removed any keywords that can't precede a regexp literal in a syntactically legal javascript program, and I've removed the
		 * "in" keyword since it's not a keyword in many languages, and might be used as a count of inches.
  		 * @private
  		 */
		public static var REGEXP_PRECEDER_PATTERN:RegExp = 
		( 
		
			function ():RegExp 
			{
    		
    			var preceders:Array = 
    			[
	        		"!", "!=", "!==", "#", "%", "%=", "&", "&&", "&&=",
        			"&=", "(", "*", "*=", /* "+", */ "+=", ",", /* "-", */ "-=",
        			"->", /*".", "..", "...", handled below */ "/", "/=", ":", "::", ";",
        			"<", "<<", "<<=", "<=", "=", "==", "===", ">",
        			">=", ">>", ">>=", ">>>", ">>>=", "?", "@", "[",
        			"^", "^=", "^^", "^^=", "{", "|", "|=", "||",
        			"||=", "~", "break", "case", "continue", "delete",
        			"do", "else", "finally", "instanceof",
        			"return", "throw", "try", "typeof"
        		];
   				
   				var pattern:String = '(?:' + 
      				'(?:(?:^|[^0-9\.])\\.{1,3})|' +  // a dot that's not part of a number
      				'(?:(?:^|[^\\+])\\+)|' +  // allow + but not ++
      				'(?:(?:^|[^\\-])-)'  // allow - but not --
      			;
    			
		    	var len:uint = preceders.length ;
				    	
    			for (var i:uint = 0; i < len ; ++i ) 
    			{
      				var preceder:* = preceders[i] ;
      				if ( isWordChar( preceder.charAt(0) ) ) 
      				{
        				pattern += '|\\b' + preceder;
      				} 
      				else 
      				{
       					pattern += '|' + preceder.replace(/([^=<>:&])/g, '\\$1');
      				}
    			}
    			pattern += '|^)\\s*$' ;  // matches at end, and matches empty string
    			return new RegExp(pattern, "");
  			
  			}
  		
  		)();		


	}
	
}
