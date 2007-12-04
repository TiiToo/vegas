﻿/*

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
  
*/
package pegas.draw 
{
	import flash.display.Graphics;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import pegas.draw.IPen;
	
	import vegas.util.ClassUtil;	

	/**
	 * The Pen class use composition to control a Graphics reference and draw custom vector graphic shapes.
	 * @author eKameleon
	 */
	dynamic public class Pen extends Proxy implements IPen 
	{
		
		/**
		 * Creates a new Pen instance.
		 */
		public function Pen( graphic:Graphics )
		{
			this.graphics = graphic ;
		}

		/**
		 * Specifies the Graphics object belonging to this Shape object, where vector drawing commands can occur.
		 */
		public function get graphics():Graphics
		{
			return _graphics ;
		}
		
		/**
		 * @private
		 */
		public function set graphics(graphic:Graphics):void
		{
			if ( _graphics != null )
			{
				_graphics.clear() ;	
			}
			_graphics = graphic ;
		}
		
	    /**
         * Overrides the behavior of an object property that can be called as a function. 
         * When a method of the object is invoked, this method is called. 
         * While some objects can be called as functions, some object properties can also be called as functions. 
         */
        flash_proxy override function callProperty( methodName:*  , ...rest:Array ):* 
        {

            var res:* = null ;
        	if ( _graphics != null )
        	{
        		methodName = methodName.toString() ;
        		if ( _graphics.hasOwnProperty( methodName ) )
        		{
					res = _graphics[methodName].apply(_graphics, rest);
                }
            }
            return res ;
        }

		/**
		 * Defines a shortcut reference to used the {@code beginBitmapFill} method.
		 */
		public function BF( ...arguments:Array ):void
		{
			_graphics.beginBitmapFill.apply( _graphics, arguments ) ;
		}

		/**
		 * Defines a shortcut reference to used the {@code curveTo} method.
		 */
		public function C( ...arguments:Array ):void
		{
			_graphics.curveTo.apply( _graphics, arguments ) ;
		}

		/**
		 * Defines a shortcut reference to used the {@code clear} method.
		 */
		public function CL():void
		{
			_graphics.clear() ;
		}

		/**
		 * Defines a shortcut reference to used the {@code endFill} method.
	 	 */
		public function EF():void
		{
			_graphics.endFill() ;
		}

		/**
	 	 * Defines a shortcut reference to used the {@code beginFill} method.
	 	 */
		public function F( ...arguments:Array ):void
		{
			_graphics.beginFill.apply( _graphics, arguments ) ;
		}

		/**
		 * Defines a shortcut reference to used the {@code beginGradientFill} method.
	 	 */
		public function GF( ...arguments:Array ):void
		{
			_graphics.beginGradientFill.apply( _graphics, arguments ) ;
		}
		
		/**
	 	 * Defines a shortcut reference to used the {@code lineGradientStyle} method.
	 	 */
		public function GS( ...arguments:Array ):void
		{
			_graphics.lineGradientStyle.apply( _graphics, arguments ) ;
		}
		
		/**
		 * Defines a shortcut reference to used the {@code lineTo} method.
		 */
		public function L( ...arguments:Array ):void
		{
			_graphics.lineTo.apply( _graphics, arguments ) ;
		}
		
		/**
		 * Defines a shortcut reference to used the {@code moveTo} method.
		 */
		public function M( ...arguments:Array ):void
		{
			_graphics.moveTo.apply( _graphics, arguments ) ;
		}
	
		/**
		 * Defines a shortcut reference to used the {@code lineStyle} method.
		 */
		public function S( ...arguments:Array ):void
		{
			_graphics.lineStyle.apply( _graphics, arguments ) ;
		}

		/**
	 	 * Draws the vector graphic shape.
	 	 */
		public function draw(...arguments:Array):void
		{
			// override this method.
		}
		
		/**
		 * Returns the string representation of this object.
		 * @return the string representation of this object.
		 */
		public function toString():String 
		{
			return "[" + ClassUtil.getName(this) + "]" ;
		}

		/**
		 * @private
		 */
		private var _graphics:Graphics ;
	
	}

}