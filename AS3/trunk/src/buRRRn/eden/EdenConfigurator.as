
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [eden: ECMASCript data exchange notation for AS3]. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package buRRRn.eden
    {
    import system.Configurator;
    
    public class EdenConfigurator extends Configurator
        {
        
        public function EdenConfigurator( config:Object )
            {
            super( config );
            }
        
        /* Property: compress
           Parameter to remove (true) or add (false) all unecessary spaces,
           tabs, carriages returns, lines feeds etc.
           to optimize (more or less) packets of datas when they are transfered.
           
           note:
           use "compress = false" when you want
           to have a better view or debug packets of datas.
           
           note2:
           this property is in sync with eden.prettyPrint
        */
        public function get compress():Boolean
            {
            return _config.compress;
            }
        
        public function set compress( value:Boolean ):void
            {
            _config.compress = value;
            eden.prettyPrinting = value;
            }
        
        /* Property: copyObjectByValue
           Parameter allowing to copy objects by value
           if true or by reference if false.
           
           exemple:
           (code)
           foo = {a:1, b:2, c:3};
           bar = foo;
           (end)
           
           in this case with copyObjectByValue = false
           bar will be a reference to the foo object
           but if copyObjectByValue = true
           bar will be an exact copy of foo object
        */
        public function get copyObjectByValue():Boolean
            {
            return _config.copyObjectByValue;
            }
        
        public function set copyObjectByValue( value:Boolean ):void
            {
            _config.copyObjectByValue = value;
            }
        
        /* Property: strictMode
           Allows to define the case-sensitivy of the parsers.
           If true, variable names that differ only in case are
           considered different.
        */
        public function get strictMode():Boolean
            {
            return _config.strictMode;
            }
        
        public function set strictMode( value:Boolean ):void
            {
            _config.strictMode = value;
            }
        
        /* Property: undefineable
           Value assigned to a variable
           when this one is not found or not authorized.
           
           note:
           Depending on your environment you can
           override it with a more suitable one
           for exemple on C# you could set it
           to null.
        */
        public function get undefineable():*
            {
            return _config.undefineable;
            }
        
        public function set undefineable( value:* ):void
            {
            _config.undefineable = value;
            }
        
        /* Property: verbose
           Parameter allowing to trace messages
           in the console if the environment permit it.
        */
        public function get verbose():Boolean
            {
            return _config.verbose;
            }
        
        public function set verbose( value:Boolean ):void
            {
            _config.verbose = value;
            }
        
        /* Property: security
           Parameter setting on (true) or off (false) the security.
           If true, all object path, function or constructor will
           be scanned at interpretation time against the
           authorized list (see: buRRRn.eden.config.authorized).
        */
        public function get security():Boolean
            {
            return _config.security;
            }
        
        public function set security( value:Boolean ):void
            {
            _config.security = value;
            }
        
        /* Property: authorized
           List of authorized keywords, objects path and constructors
           that the parser is allowed to interpret.
           
           note:
           you can add full path
           ex: "blah.foobar"
           and/or starting path
           ex: "toto.titi.*"
           
           the difference is
           with a full path you can only
           create/use/define/assign value to this exact path
           and
           with a starting path you can
           create/use/define/assign value to this path and its child paths
           
           attention:
           special values as
           NaN, true, false, null, undefined
           are always authorized
        */
        public function get authorized():Array
            {
            return _config.authorized;
            }
        
        public function set authorized( value:Array ):void
            {
            _config.authorized = value;
            }
        
        /* Property: allowFunctionCall
           Allows to execute function call.
           if set to false it blocks any functrion call and return undefined.
           
           exemple:
           (code)
           "titi = \"hello world\";
            toto = titi.toUpperCase();"
           
           //allowFunctionCall= true
           toto = "HELLO WORLD"
           
           //allowFunctionCall = false
           toto = undefined
           (end)
        */
        public function get allowFunctionCall():Boolean
            {
            return _config.allowFunctionCall;
            }
        
        public function set allowFunctionCall( value:Boolean ):void
            {
            _config.allowFunctionCall = value;
            }
        
        /* Property: autoAddScopePath
        */
        public function get autoAddScopePath():Boolean
            {
            return _config.autoAddScopePath;
            }
        
        public function set autoAddScopePath( value:Boolean ):void
            {
            _config.autoAddScopePath = value;
            }
        
        /* Property: arrayIndexAsBracket
           When set to false array index are evaluated without bracket
           eval( test.0 )
           for Flash ActionScript
           
           When set to true array index are evaluated with bracket
           eval( test[0] )
           for JavaScript, JScript, JSDB etc.
           
           TODO:
           may become obsolete for AS3/ES4
           but let's keep it for now for configuration file bacward compatibility
        */
        public function get arrayIndexAsBracket():Boolean
            {
            return _config.arrayIndexAsBracket;
            }
        
        public function set arrayIndexAsBracket( value:Boolean ):void
            {
            _config.arrayIndexAsBracket = value;
            }
        
        }
    
    }
