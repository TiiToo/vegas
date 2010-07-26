﻿/*

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

package vegas.ioc.factory
{
    import buRRRn.ASTUce.framework.TestCase;

    import vegas.ioc.TypeAliases;
    import vegas.ioc.TypeExpression;
    import vegas.ioc.TypePolicy;
    import vegas.ioc.evaluators.ConfigEvaluator;
    import vegas.ioc.evaluators.LocaleEvaluator;
    import vegas.ioc.evaluators.ReferenceEvaluator;
    import vegas.ioc.evaluators.TypeEvaluator;

    public class ObjectConfigTest extends TestCase 
    {
        public function ObjectConfigTest(name:String = "")
        {
            super(name);
        }
        
        public var config:ObjectConfig ;
        
        public function setUp():void
        {
            config = new ObjectConfig() ;
        }
        
        public function tearDown():void
        {
            config = null;
        }
        
        public function testConstructor():void
        {
            assertNotNull( config ) ;
            
            assertEquals( TypePolicy.NONE , config.typePolicy ) ;
            
            assertNotNull( config.config ) ;
            assertNotNull( config.locale ) ;
            
            assertNotNull( config.configEvaluator    as ConfigEvaluator ) ;
            assertNotNull( config.localeEvaluator    as LocaleEvaluator ) ;
            assertNotNull( config.referenceEvaluator as ReferenceEvaluator ) ;
            assertNotNull( config.typeAliases        as TypeAliases ) ;
            assertNotNull( config.typeEvaluator      as TypeEvaluator ) ;
            assertNotNull( config.typeExpression     as TypeExpression ) ;
            
            assertNull( config.defaultDestroyMethod ) ;
            assertNull( config.defaultInitMethod    ) ;
            assertNull( config.flashVars            ) ;
            assertNull( config.root                 ) ;
            assertNull( config.stage                ) ;
            
            assertTrue( config.throwError ) ;
            assertTrue( config.useLogger ) ;
            
            assertFalse( config.identify ) ;
            assertFalse( config.lock     ) ;
        }
        
        public function testDefaultDestroyMethod():void
        {
            config = new ObjectConfig( { defaultDestroyMethod:"destroyer" } ) ;
            assertEquals( "destroyer" , config.defaultDestroyMethod ) ;
        }
        
        public function testDefaultInitMethod():void
        {
            config = new ObjectConfig( { defaultInitMethod:"initialize" } ) ;
            assertEquals( "initialize" , config.defaultInitMethod ) ;
        }
    }
}
