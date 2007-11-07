/*

The contents of this file are subject to the Mozilla Public License Version
1.1 (the "License"); you may not use this file except in compliance with
the License. You may obtain a copy of the License at 
  
http://www.mozilla.org/MPL/ 
  
Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
for the specific language governing rights and limitations under the License. 
  
The Original Code is PEGAS Framework.
  
The Initial Developer of the Original Code is
ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
Portions created by the Initial Developer are Copyright (C) 2004-2008
the Initial Developer. All Rights Reserved.
  
Contributor(s) :
  
 */import pegas.colors.ColorSVG;
import pegas.draw.Canvas;

import vegas.util.StringUtil;

/**
 * This Canvas can draw a SVG shape with a SVG XML DOM object.
 * @author eKameleon
 */
class pegas.draw.SVGCanvas extends Canvas 
{

	/**
	 * Creates a new SVGCanvas instance.
	 * @param target the movieclip reference.
	 * @param data the model of this canvas.
	 * @param isNew this argument flag defines if the shape is draw in a new subcontainer in the target reference.
	 */
	public function SVGCanvas(target:MovieClip, data:Array, isNew:Boolean)
	{
		super( target, data, isNew );
	}

	/**
	 * The 'fill' attribute name.
	 */
	public static var FILL:String = "fill" ;

	/**
	 * The 'rotate' attribut name.
	 */
	public static var ROTATE:String = "rotate" ;

	/**
	 * The 'stroke' attribute name.
	 */
	public static var STROKE:String = "stroke" ;

	/**
	 * The 'stroke_width' attribute name.
	 */
	public static var STROKE_WIDTH:String = "stroke_width" ;

	/**
	 * The 'transform' attribute name.
	 */
	public static var TRANSFORM:String = "transform" ;

	 /**
	  * Sets the array representation of the model of this canvas.
	  */
	public function parseSVG( x:XMLNode ):Void 
	{
		setData( svgToData( parse(x) ) ) ;
	}

	/**
	 * @private
	 */
	private var fill:Object ;

	/**
	 * @private
	 */
	private var stroke:Object;

	/**
	 * Convert SVG array representation in actionscript canvas data object.
	 */
	private function svgToData( arSVG:Array ) 
	{
		var data:Array = [] ;
		var ii ;
		var j:Number = 0;
		var qc:Array;
		var firstP:Object;
		var lastP:Object;
		var lastC:Object;
		var cmd:String;
		
		do 
		{
		
			cmd = arSVG[j++];
			switch (cmd) 
			{
			
				case "M" :
					// moveTo point
					firstP = lastP = {x:Number(arSVG[j]), y:Number(arSVG[j+1])};
					data.push(['F', [fill.color, fill.alpha]]);
					data.push(['S', [stroke.width, stroke.color, stroke.alpha]]);
					data.push(['M', [firstP.x, firstP.y]]);
					j += 2;
					if (j < arSVG.length && !isNaN(Number(arSVG[j]))) 
					{  
						do 
						{
							// if multiple points listed, add the rest as lineTo points
							lastP = {x:Number(arSVG[j]), y:Number(arSVG[j+1])};
							data.push(['L', [lastP.x, lastP.y]]);
							firstP = lastP;
							j += 2;
						} 
						while (j < arSVG.length && !isNaN(Number(arSVG[j]))) ;
					}
					break ;
				
				case "l" :
				{
					do 
					{
						lastP = {x:lastP.x+Number(arSVG[j]), y:lastP.y+Number(arSVG[j+1])};
						data.push(['L', [lastP.x, lastP.y]]);
						firstP = lastP;
						j += 2;
					} 
					while (j < arSVG.length && !isNaN(Number(arSVG[j])));
					break ;
				}
			case "L" :
				do {
					lastP = {x:Number(arSVG[j]), y:Number(arSVG[j+1])};
					data.push(['L', [lastP.x, lastP.y]]);					
					firstP = lastP;
					j += 2;
				} while (j < arSVG.length && !isNaN(Number(arSVG[j])));
				break;
				
			case "h" :
				do {
					lastP = {x:lastP.x+Number(arSVG[j]), y:lastP.y};
					data.push(['L', [lastP.x, lastP.y]]);
					firstP = lastP;
					j += 1;
				} while (j < arSVG.length && !isNaN(Number(arSVG[j])));
				break;
				
			case "H" :
				do {
					lastP = {x:Number(arSVG[j]), y:lastP.y};
					data.push(['L', [lastP.x, lastP.y]]);
					firstP = lastP;
					j += 1;
				} while (j < arSVG.length && !isNaN(Number(arSVG[j])));
				break;
				
			case "v" :
				do {
					lastP = {x:lastP.x, y:lastP.y+Number(arSVG[j])};
					data.push(['L', [lastP.x, lastP.y]]);
					firstP = lastP;
					j += 1;
				} while (j < arSVG.length && !isNaN(Number(arSVG[j])));
				break;
				
			case "V" :
				do {
					lastP = {x:lastP.x, y:Number(arSVG[j])};
					data.push(['L', [lastP.x, lastP.y]]);
					firstP = lastP;
					j += 1;
				} while (j < arSVG.length && !isNaN(Number(arSVG[j])));
				break;
	
			case "q" :
				do {
					// control is relative to lastP, not lastC
					lastC = {x:lastP.x+Number(arSVG[j]), y:lastP.y+Number(arSVG[j+1])};
					lastP = {x:lastP.x+Number(arSVG[j+2]), y:lastP.y+Number(arSVG[j+3])};
					data.push(['C', [lastC.x, lastC.y, lastP.x, lastP.y]]);
					firstP = lastP;
					j += 4;
				} while (j < arSVG.length && !isNaN(Number(arSVG[j])));
				break;
				
			case "Q" :
				do {
					lastC = {x:Number(arSVG[j]), y:Number(arSVG[j+1])};					
					lastP = {x:Number(arSVG[j+2]), y:Number(arSVG[j+3])};
					data.push(['C', [lastC.x, lastC.y, lastP.x, lastP.y]]);
					firstP = lastP;
					j += 4;
				} while (j < arSVG.length && !isNaN(Number(arSVG[j])));
				break;
				
			case "c" :
				do {
				// don't save if c1.x=c1.y=c2.x=c2.y=0 
					if (!Number(arSVG[j]) && !Number(arSVG[j+1]) && !Number(arSVG[j+2]) && !Number(arSVG[j+3])) {
					} else {
						qc = [];
						getQuadBez_RP(
							{x:lastP.x, y:lastP.y},   
							{x:lastP.x+Number(arSVG[j]), y:lastP.y+Number(arSVG[j+1])},
							{x:lastP.x+Number(arSVG[j+2]), y:lastP.y+Number(arSVG[j+3])},
							{x:lastP.x+Number(arSVG[j+4]), y:lastP.y+Number(arSVG[j+5])},
						    1, qc
						   );
						for ( ii =0 ; ii < qc.length ; ii++ ) 
						{
							data.push(['C', [qc[ii].cx, qc[ii].cy, qc[ii].p2x, qc[ii].p2y]]);
						}
						lastC = {x:lastP.x+Number(arSVG[j+2]), y:lastP.y+Number(arSVG[j+3])} ;
						lastP = {x:lastP.x+Number(arSVG[j+4]), y:lastP.y+Number(arSVG[j+5])} ;
						firstP = lastP;
					}
					j += 6;
				} while (j < arSVG.length && !isNaN(Number(arSVG[j])));
				break;
	
			case "C" :
			{
				do 
				{
					// don't save if c1.x=c1.y=c2.x=c2.y=0 
					if (!Number(arSVG[j]) && !Number(arSVG[j+1]) && !Number(arSVG[j+2]) && !Number(arSVG[j+3])) 
					{
					
					} 
					else 
					{
						qc = [];
						getQuadBez_RP(
							{x:firstP.x, y:firstP.y},   
							{x:Number(arSVG[j]), y:Number(arSVG[j+1])},
							{x:Number(arSVG[j+2]), y:Number(arSVG[j+3])},
							{x:Number(arSVG[j+4]), y:Number(arSVG[j+5])},
							1, qc);
						for ( ii = 0 ; ii<qc.length; ii++) 
						{
							data.push(['C', [qc[ii].cx, qc[ii].cy, qc[ii].p2x, qc[ii].p2y]]);
						}


						lastC = {x:Number(arSVG[j+2]), y:Number(arSVG[j+3])} ;
						lastP = {x:Number(arSVG[j+4]), y:Number(arSVG[j+5])} ;
						firstP = lastP;
					}
					j += 6;
				} while (j < arSVG.length && !isNaN(Number(arSVG[j])));
				break;
			}	
			case "s" :
				do {
				// don't save if c1.x=c1.y=c2.x=c2.y=0 
					if (!Number(arSVG[j]) && !Number(arSVG[j+1]) && !Number(arSVG[j+2]) && !Number(arSVG[j+3])) {
					} else {
						qc = [];
						getQuadBez_RP(
							{x:firstP.x, y:firstP.y},   
							{x:lastP.x + (lastP.x - lastC.x), y:lastP.y + (lastP.y - lastC.y)},
							{x:lastP.x+Number(arSVG[j]), y:lastP.y+Number(arSVG[j+1])},
							{x:lastP.x+Number(arSVG[j+2]), y:lastP.y+Number(arSVG[j+3])},
							1, qc);
						for ( ii = 0 ; ii <qc.length ; ii++) 
						{
							data.push(['C', [qc[ii].cx, qc[ii].cy, qc[ii].p2x, qc[ii].p2y]]);
						}

						lastC = {x:lastP.x+Number(arSVG[j]), y:lastP.y+Number(arSVG[j+1])};
						lastP = {x:lastP.x+Number(arSVG[j+2]), y:lastP.y+Number(arSVG[j+3])};
						firstP = lastP;
					}
					j += 4;
				} while (j < arSVG.length && !isNaN(Number(arSVG[j])));
				break;
				
			case "S" :
				
				do 
				{
				// don't save if c1.x=c1.y=c2.x=c2.y=0 
					if (!Number(arSVG[j]) && !Number(arSVG[j+1]) && !Number(arSVG[j+2]) && !Number(arSVG[j+3])) 
					{
					
					} 
					else 
					{
						qc = [];
						getQuadBez_RP(
							{x:firstP.x, y:firstP.y},   
							{x:lastP.x + (lastP.x - lastC.x), y:lastP.y + (lastP.y - lastC.y)},
							{x:Number(arSVG[j]), y:Number(arSVG[j+1])},
							{x:Number(arSVG[j+2]), y:Number(arSVG[j+3])}, 
							1, qc);
						for ( ii = 0 ; ii < qc.length ; ii++ ) 
						{
							data.push(['C', [qc[ii].cx, qc[ii].cy, qc[ii].p2x, qc[ii].p2y]]);
						}

						lastC = {x:Number(arSVG[j]), y:Number(arSVG[j+1])};
						lastP = {x:Number(arSVG[j+2]), y:Number(arSVG[j+3])};
						firstP = lastP;
					}
					j += 4;
				} 
				while (j < arSVG.length && !isNaN(Number(arSVG[j])));
				
				break;
				
				case "z" :
				case "Z" :
				{
					if (firstP.x != lastP.x || firstP.y != lastP.y) 
					{
						data.push(['L', [firstP.x, firstP.y]]);
					}
					j++;
					break;		
				}	
			}
		}  
		while ( j < arSVG.length ) ;
		
		return data ;
	}

	/**
	 * Parses the specified path node and convert to array of SVG drawing commands and data.
	 */
	private function parse( node:XMLNode ):Array 
	{
		
		var startColor:Number ;
		var thisColor:Number  ;
		var rotation:Number ;
		
		var hasFill:Boolean = false ;
		var hasTransform:Boolean = false ;
		var hasStroke:Boolean = false ;
		var hasStrokeWidth:Boolean = false ;
		var hasRotate:Boolean = false ;
		var dstring:String = "" ;

		var attributes:Object = node.attributes ;
		
		for ( var a:String in attributes ) 
		{
			if ( a == FILL ) 
			{
				hasFill = true ;
			} 
			else if (a == TRANSFORM ) 
			{
				hasTransform = true;
			} 
			else if (a == STROKE ) 
			{
				hasStroke = true;
			} 
			else if (a == STROKE_WIDTH ) 
			{
				hasStrokeWidth = true;
			}
		}
		
		if ( hasFill ) 
		{
			startColor = attributes[FILL].indexOf( "#" ) + 1 ;
			if (startColor == 0)
			{  
				thisColor = ColorSVG.get( attributes[FILL] );
				fill = (thisColor == null) ? {color:0, alpha:0} : { color:thisColor.valueOf( ), alpha:100} ;
			}
			else 
			{
				fill = { color : parseInt( attributes[FILL].substr( startColor, 6 ), 16 ), alpha : 100 } ;
			}
		} 
		else 
		{
			fill = { color:0xFFFFFF, alpha:100 } ;
		} 
		
		if ( hasStroke ) 
		{
			startColor = node.attributes.stroke.indexOf( "#" ) + 1;		
			if ( startColor == 0 ) 
			{
				thisColor = ColorSVG.get( attributes[FILL] );
				stroke = (thisColor == null) ? {color:0, width:0, alpha:0} : {color:thisColor.valueOf( ), width:0, alpha:100} ;
			} 
			else 
			{
				stroke = {color:parseInt( node.attributes.stroke.substr( startColor, 6 ), 16 ), width:0, alpha:100};
			}
		} 
		else 
		{
			stroke = {color:0, width:0, alpha:0};
		}
		
		if ( hasStrokeWidth ) 
		{
			stroke.width = Number( attributes[STROKE_WIDTH] ) ;
		}
	
		if ( !hasFill && !hasStroke ) 
		{
			fill = { color : 0, alpha : 100 } ; // if stroke and fill are both undefined, set fill to black
		}
		
		// transform
				
		rotation  = 0 ; 
		if ( hasTransform ) 
		{
			var t:String = attributes[TRANSFORM] ;
			hasRotate = attributes[TRANSFORM].indexOf( ROTATE ) ;
			
			if (hasRotate > -1) 
			{
				var startRotate:Number = t.indexOf( "(" );
				var endRotate:Number   = t.indexOf( ")" );
				rotation               = parseInt( t.substr( startRotate + 1 , endRotate - startRotate ) ) ;
			} 
		
		}
		
		var d:String = attributes.d ;
		
		
		if ( d.indexOf( "," ) > -1 ) // if commas included, is it Adobe Illustrator (no spaces) or SVG Factory/other? 
		{  
			dstring = ( d.indexOf( " " ) > -1 ) ? StringUtil.replace( d, " ", "," ) : d ; // yes, has spaces and change spaces to commas, then deal as for Illustrator
		} 
		else // no commas get rid of extra spaces and change rest to commas 
		{  
			dstring = d ;
			dstring = shrinkSequencesOf( dstring, " " ) ;
			dstring = StringUtil.replace( d , " ", "," ) ;
		}		

		dstring = StringUtil.replace( dstring, "c", ",c," );
		dstring = StringUtil.replace( dstring, "C", ",C," );
		dstring = StringUtil.replace( dstring, "S", ",S," );
		dstring = StringUtil.replace( dstring, "s", ",s," );
		// separate the z from the last element
		dstring = StringUtil.replace( dstring, "z", ",z" );
		// change the following if M can be mid-path
		dstring = StringUtil.replace( dstring, "M", "M," );
		dstring = StringUtil.replace( dstring, "L", ",L," );
		dstring = StringUtil.replace( dstring, "l", ",l," );
		dstring = StringUtil.replace( dstring, "H", ",H," );
		dstring = StringUtil.replace( dstring, "h", ",h," );
		dstring = StringUtil.replace( dstring, "V", ",V," );
		dstring = StringUtil.replace( dstring, "v", ",v," );
		dstring = StringUtil.replace( dstring, "Q", ",Q," );
		dstring = StringUtil.replace( dstring, "q", ",q," );
		dstring = StringUtil.replace( dstring, "T", ",T," );
		dstring = StringUtil.replace( dstring, "t", ",t," );
		// Adobe includes no delimiter before negative numbers
		dstring = StringUtil.replace( dstring, "-", ",-" );
		// get rid of any dup commas we might have introduced
		dstring = StringUtil.replace( dstring, ",,", "," );
		// get rid of spaces
		// (cr/lf's have to be removed before the xml object can be created,
		//  so that is done in xml.onData method)
		dstring = StringUtil.replace( dstring, " ", "" );
		dstring = StringUtil.replace( dstring, "\t", "" );

		return dstring.split( "," );	
	}
	
	// TODO must refactoring this next methods and use tools in pegas.geom and pegas.maths package !!!
	
	private static function shrinkSequencesOf(s:String, ch:String):String 
	{
		
		var len:Number = s.length;
		var idx:Number = 0  ;
		var idx2:Number = 0 ;
		var rs:String = ""  ;
		s = new String( s ) ;
		
		while ((idx2 = s.indexOf( ch, idx ) + 1) != 0) 
		{
			// include string up to first character in sequence
			rs += s.substring( idx, idx2 );
			idx = idx2;
			
			// remove all subsequent characters in sequence
			while ((s.charAt( idx ) == ch) && (idx < len)) idx++;
		}
		return rs + s.substring( idx, len );	
	}

	public static function midPt(p1x, p1y, p2x, p2y) {
		return {x:(p1x + p2x)/2, y:(p1y + p2y)/2};
	}

	public static function bezierSplit(p1x, p1y, c1x, c1y, c2x, c2y, p2x, p2y):Object {
	    var m = midPt;
		var p1:Object = {x:p1x, y:p1y};
		var p2:Object = {x:p2x, y:p2y};
	    var p01:Object = m (p1x, p1y, c1x, c1y);
	    var p12:Object = m (c1x, c1y, c2x, c2y);
	    var p23:Object = m (c2x, c2y, p2x, p2y);
	    var p02:Object = m (p01.x, p01.y, p12.x, p12.y);
	    var p13:Object = m (p12.x, p12.y, p23.x, p23.y);
	    var p03:Object = m (p02.x, p02.y, p13.x, p13.y);

		/*
        b0:{a:p0,  b:p01, c:p02, d:p03},
        b1:{a:p03, b:p13, c:p23, d:p3 }  
		*/

		return { b0:{p1:p1, c1:p01, c2:p02, p2:p03}, b1:{p1:p03, c1:p13, c2:p23, p2:p2} };
	}

	public static function intersect2Lines (p1, p2, p3, p4):Object {
		var x1 = p1.x; var y1 = p1.y;
		var x4 = p4.x; var y4 = p4.y;
	    var dx1 = p2.x - x1;
	    var dx2 = p3.x - x4;

	   if (!(dx1 || dx2)) return NaN;
	   var m1 = (p2.y - y1) / dx1;
	   var m2 = (p3.y - y4) / dx2;
	   if (!dx1) {
	      return { x:x1, y:m2 * (x1 - x4) + y4 };
	   } else if (!dx2) {
	      return { x:x4, y:m1 * (x4 - x1) + y1 };
	   }
	   var xInt = (-m2 * x4 + y4 + m1 * x1 - y1) / (m1 - m2);
	   var yInt = m1 * (xInt - x1) + y1;
	   return { x:xInt,y:yInt };
	}
	
	public static function getQuadBez_RP(p1, c1, c2, p2, k, qcurves) {
		// find intersection between bezier arms
		var s:Object = intersect2Lines (p1, c1, c2, p2);
		// find distance between the midpoints
		var dx = (p1.x + p2.x + s.x * 4 - (c1.x + c2.x) * 3) * .125;
		var dy = (p1.y + p2.y + s.y * 4 - (c1.y + c2.y) * 3) * .125;
		// split curve if the quadratic isn't close enough
		if (dx*dx + dy*dy > k) {
			var halves = bezierSplit (p1.x, p1.y, c1.x, c1.y, c2.x, c2.y, p2.x, p2.y);
			var b0 = halves.b0; var b1 = halves.b1;
			// recursive call to subdivide curve
			getQuadBez_RP (p1,     b0.c1, b0.c2, b0.p2, k, qcurves);
			getQuadBez_RP (b1.p1,  b1.c1, b1.c2, p2,    k, qcurves);
		} else {
			// end recursion by saving points
			qcurves.push({p1x:p1.x, p1y:p1.y, cx:s.x, cy:s.y, p2x:p2.x, p2y:p2.y});
		}
	}	

	
}
