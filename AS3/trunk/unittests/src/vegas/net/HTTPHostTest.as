/*

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
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Cloneable;
    import system.Equatable;
    import system.Serializable;
    
    public class HTTPHostTest extends TestCase 
    {
        public function HTTPHostTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var hh:HTTPHost ;
            
            // 01 - with only host argument
            
            hh = new HTTPHost("localhost") ;
            assertNotNull ( hh                              , "01-01 - HTTPHost constructor failed.") ;
            assertEquals  ( hh.host    , "localhost"        , "01-02 - HTTPHost constructor failed.") ;
            assertEquals  ( hh.port    , -1                 , "01-02 - HTTPHost constructor failed.") ;
            assertEquals  ( hh.scheme  , "http"             , "01-03 - HTTPHost constructor failed.") ;
            assertEquals  ( hh.toURI() , "http://localhost" , "01-04 - HTTPHost constructor failed.") ;
            
            // 02 - with port argument
            
            hh = new HTTPHost("localhost", 80) ;
            assertNotNull ( hh                                 , "02-01 - HTTPHost constructor failed.") ;
            assertEquals  ( hh.host    , "localhost"           , "02-02 - HTTPHost constructor failed.") ;
            assertEquals  ( hh.port    , 80                    , "02-02 - HTTPHost constructor failed.") ;
            assertEquals  ( hh.scheme  , "http"                , "02-03 - HTTPHost constructor failed.") ;
            assertEquals  ( hh.toURI() , "http://localhost:80" , "02-04 - HTTPHost constructor failed.") ;
            
            // 03 - with port argument and scheme
            
            hh = new HTTPHost("localhost", 80, "https") ;
            assertNotNull ( hh                                  , "03-01 - HTTPHost constructor failed.") ;
            assertEquals  ( hh.host    , "localhost"            , "03-02 - HTTPHost constructor failed.") ;
            assertEquals  ( hh.port    , 80                     , "03-02 - HTTPHost constructor failed.") ;
            assertEquals  ( hh.scheme  , "https"                , "03-03 - HTTPHost constructor failed.") ;
            assertEquals  ( hh.toURI() , "https://localhost:80" , "03-04 - HTTPHost constructor failed.") ;
            
            // 04 - with a null host name
            
            try
            {
                hh = new HTTPHost( null ) ;
                fail( "04-01 - HTTPHost constructor failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "04-02 - HTTPHost constructor failed." ) ;
                assertEquals( e.message , "HTTPHost failed, host name may not be null." , "04-02 - HTTPHost constructor failed." ) ;
            }
        }
        
        public function testInterface():void
        {
            var hh:HTTPHost = new HTTPHost("localhost") ;
            assertTrue( hh is Cloneable    , "01 - HTTPHost implements the Cloneable interface." ) ;
            assertTrue( hh is Equatable    , "02 - HTTPHost implements the Equatable interface." ) ;
            assertTrue( hh is Serializable , "03 - HTTPHost implements the Equatable interface." ) ;
        }
        
        public function testDEFAULT_SCHEME_NAME():void
        {
            assertEquals( HTTPHost.DEFAULT_SCHEME_NAME  , "http" , "HTTPHost.DEFAULT_SCHEME_NAME failed." ) ;
        }
        
        public function testHost():void
        {
            var hh:HTTPHost = new HTTPHost("localhost") ;
            assertEquals( hh.host , "localhost" , "01 - HTTPHost host failed." )  ;
            
            hh.host = "127.0.0.1" ;
            assertEquals( hh.host , "127.0.0.1" , "02 - HTTPHost host failed." )  ;
            
            hh.host = "LOCALHOST" ;
            assertEquals( hh.host , "localhost" , "03 - HTTPHost host failed." )  ; // lowercase
            try
            {
                hh.host = null ;
                fail( "04-01 - HTTPHost host failed." ) ;
            }
            catch( e:Error )
            {
                assertEquals( e.message , "HTTPHost failed, host name may not be null." , "04-02 - HTTPHost host failed." ) ;
            }
        }
        
        public function testPort():void
        {
            var hh:HTTPHost = new HTTPHost("localhost") ; 
            
            assertEquals( hh.port , -1 , "01 - HTTPHost port failed." )  ;  
            
            hh.port = 80 ;
            assertEquals( hh.port , 80 , "02 - HTTPHost port failed." )  ;
        }
        
        public function testScheme():void
        {
            var hh:HTTPHost = new HTTPHost("localhost") ; 
            
            assertEquals( hh.scheme , "http" , "01-01 - HTTPHost scheme failed." )  ;  
            assertEquals( hh.scheme , HTTPHost.DEFAULT_SCHEME_NAME , "01-02 - HTTPHost scheme failed." )  ;
            
            hh.scheme = "https" ;
            assertEquals( hh.scheme , "https" , "02 - HTTPHost scheme failed." )  ;  
            
            hh.scheme = null ;
            assertEquals( hh.scheme , "http" , "03-01 - HTTPHost scheme failed." )  ;  
            assertEquals( hh.scheme , HTTPHost.DEFAULT_SCHEME_NAME , "03-02 - HTTPHost scheme failed." )  ;
        }
        
        public function testClone():void
        {
            var c:HTTPHost ;
            var h:HTTPHost ;
            
            h = new HTTPHost("localhost") ;
            c = h.clone() as HTTPHost ; 
            
            assertNotNull( c                     , "01 - HTTPHost clone failed.") ;
            assertNotSame( c         , h         , "02 - HTTPHost clone failed.") ;
            assertEquals ( c.host    , h.host    , "03 - HTTPHost clone failed.") ;
            assertEquals ( c.port    , h.port    , "04 - HTTPHost clone failed.") ;
            assertEquals ( c.scheme  , h.scheme  , "05 - HTTPHost clone failed.") ;
            assertEquals ( c.toURI() , h.toURI() , "06 - HTTPHost clone failed.") ;
        }
        
        public function testEquals():void
        {
            var h1:HTTPHost = new HTTPHost("localhost") ;
            var h2:HTTPHost = new HTTPHost("localhost") ;
            var h3:HTTPHost = new HTTPHost("localhost",80,"https") ;
            
            assertTrue  ( h1.equals(h1)      , "01-01 - HTTPHost equals failed.") ;
            assertTrue  ( h1.equals(h2)      , "01-02 - HTTPHost equals failed.") ;
            assertFalse ( h1.equals(h3)      , "01-03 - HTTPHost equals failed.") ;
            assertFalse ( h1.equals(null)    , "01-04 - HTTPHost equals failed.") ;
            assertFalse ( h1.equals("hello") , "01-05 - HTTPHost equals failed.") ;
            
            assertTrue  ( h2.equals(h1) , "02-01 - HTTPHost equals failed.") ;
            assertTrue  ( h2.equals(h2) , "02-02 - HTTPHost equals failed.") ;
            assertFalse ( h2.equals(h3) , "02-03 - HTTPHost equals failed.") ;
            
            assertFalse ( h3.equals(h1) , "03-01 - HTTPHost equals failed.") ;
            assertFalse ( h3.equals(h2) , "03-02 - HTTPHost equals failed.") ;
            assertTrue  ( h3.equals(h3) , "03-03 - HTTPHost equals failed.") ;
        } 
        
        public function testToSource():void
        {
            var h:HTTPHost ;
            
            h = new HTTPHost("localhost") ;
            assertEquals  ( h.toSource(), 'new vegas.net.HTTPHost("localhost",-1,"http")' , "01 - HTTPHost toSource failed.") ;
            
            h = new HTTPHost("localhost", 80) ;
            assertEquals  ( h.toSource(), 'new vegas.net.HTTPHost("localhost",80,"http")'  , "02 - HTTPHost toSource failed.") ;
            
            h = new HTTPHost("localhost", 80, "https") ;
            assertEquals  ( h.toSource(), 'new vegas.net.HTTPHost("localhost",80,"https")'  , "03 - HTTPHost toSource failed.") ;
            
            h = new HTTPHost("localhost", -1, "https") ;
            assertEquals  ( h.toSource(), 'new vegas.net.HTTPHost("localhost",-1,"https")'  , "04 - HTTPHost toSource failed.") ;
        }
        
        public function testToString():void
        {
            var h:HTTPHost = new HTTPHost("localhost") ;
            assertEquals  ( h.toString(), h.toURI()  , "HTTPHost toString failed.") ;
        }
        
        public function testToURI():void
        {
            var h:HTTPHost ;
            h = new HTTPHost("localhost") ;
            assertEquals  ( h.toURI(), "http://localhost"  , "01 - HTTPHost toURI failed.") ;
            
            h = new HTTPHost("localhost", 80) ;
            assertEquals  ( h.toURI(), "http://localhost:80"  , "02 - HTTPHost toURI failed.") ;
            
            h = new HTTPHost("localhost", 80, "https") ;
            assertEquals  ( h.toURI(), "https://localhost:80"  , "03 - HTTPHost toURI failed.") ;
            
            h = new HTTPHost("localhost", -1, "https") ;
            assertEquals  ( h.toURI(), "https://localhost"  , "04 - HTTPHost toURI failed.") ;
        }
    }
}
