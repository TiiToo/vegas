﻿/*  The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at              http://www.mozilla.org/MPL/     Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the License.     The Original Code is Vegas Framework.    The Initial Developer of the Original Code is  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.  Portions created by the Initial Developer are Copyright (C) 2004-2009  the Initial Developer. All Rights Reserved.    Contributor(s) :  */package vegas.display {    import flash.display.DisplayObject;    import flash.geom.Point;    import flash.geom.Rectangle;        /**     * This class defines a layer in the Parallaxe container.     */    internal class ParallaxeLayer    {        /**         * Creates a new ParallaxeLayer instance.         * @param target The DisplayObject reference of the layer.         * @param dimension An optional Rectangle, Dimension or object with the numeric properties "width" and "height" to defines a custom area size of the layer. By default the target parameter is used to defines this property.         * @param offset The optional offset position of the layer (default [0,0]).         * @param scaling Indicates if the layer can be scalled.         */        public function ParallaxeLayer( target:DisplayObject , dimension:* = null , offset:Point = null , scaling:Boolean = false )        {            if ( target == null )            {                throw new ArgumentError( this + " constructor failed, the target DisplayObject parameter not must be null.") ;            }            this.target    = target ;            this.dimension = dimension ? dimension : new Rectangle(0,0,target.width, target.height) ;             this.offset    = offset ? offset : new Point(0,0) ;            this.scaling  = scaling ;        }                /**         * The dimension of the layer.          */        public var dimension:Rectangle ;                /**         * The offset of the layer.         */        public var offset:Point ;                /**         * Indicates if the layer can be zoomed.         */        public var scaling:Boolean ;                /**         * The DisplayObject target reference of the layer.         */        public var target:DisplayObject ;                /**         * The x current delta position of the layer.          */        public var tx:Number = 0 ;                /**         * The y current delta position of the layer.          */        public var ty:Number = 0 ;    }}