﻿/*  The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at              http://www.mozilla.org/MPL/     Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the License.     The Original Code is Vegas Framework.    The Initial Developer of the Original Code is  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.  Portions created by the Initial Developer are Copyright (C) 2004-2009  the Initial Developer. All Rights Reserved.    Contributor(s) :  */package vegas.ioc {    /**     * Enumeration of all "magic reference patterns" id can be use in the object definition to create a dependency with special object reference in the factory.     */    public class MagicReference     {        /**         * The reference pattern who represents the current config reference of the application defines in the config object in the factory.         */        public static var CONFIG:String = "#config" ;                /**         * The reference pattern who represents the current flashVars reference of the application defines in the config object in the factory.         */        public static var FLASH_VARS:String = "#flashvars" ;                /**         * The reference pattern who represents the current locale reference of the application defines in the config object in the factory.         */        public static var LOCALE:String = "#locale" ;                /**         * The reference pattern who represents the current root reference of the application defines in the config object in the factory.         */        public static var ROOT:String = "#root" ;                /**         * The reference pattern who represents the current stage reference of the application defines in the config object in the factory.         */        public static var STAGE:String = "#stage" ;                /**         * The reference pattern who represents the current factory.         */        public static var THIS:String = "#this" ;    }}