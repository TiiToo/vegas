/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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

package vegas.ui 
{
    /**
     * The MouseWheelInspector Javascript script.
     */
    public const MouseWheelScript:XML =
    <script><![CDATA[
        function ()
        {
            if ( window.MouseWheelInspector ) 
            {
                return;
            }
            
            var win = window    ;
            var doc = document  ;
            var nav = navigator ;
            
            /**
             * Creates a new MouseWheelInspector instance.
             * @param id The id of the SWF object in the html page.
             */
            var MouseWheelInspector = window.MouseWheelInspector = function ( id )
            {
                this.initialize( id ) ;
                if (MouseWheelInspector.browser.msie)
                {
                    this.bind4msie() ;
                }
                else
                {
                    this.bind() ;
                }
            };
            
            var p = MouseWheelInspector.prototype ;
            
            ////// public methods
            
            p.bind = function ()
            {
                this.target.addEventListener
                ( 
                    this.eventType , 
                    function ( e )
                    {
                        var target ;
                        var name   ;
                        
                        var delta = 0 ;
                        
                        // retrieve real node from XPCNativeWrapper.
                        
                        if ( /XPCNativeWrapper/.test(e.toString()) )
                        {
                            // FIXME: embed element has no id attributes on `AC_RunContent`.
                            var k = e.target.getAttribute('id') || e.target.getAttribute('name');
                            if (!k) 
                            {
                                return ;
                            }
                            target = MouseWheelInspector.retrieveObject(k);
                        }
                        else
                        {
                            target = e.target;
                        }
                        
                        name = target.nodeName.toLowerCase();
                        
                        // check target node.
                        if (name != 'object' && name != 'embed') return;
                        
                        // kill process.
                        
                        if ( !target.checkScrolling() )
                        {
                            e.preventDefault();
                            e.returnValue = false;
                        }
                        
                        // execute wheel event if exists.
                        
                        if ( !target.onMouseEvent )
                        {
                             return ;
                        }
                        
                        switch (true)
                        {
                            case MouseWheelInspector.browser.mozilla :
                            {
                                delta = -e.detail;
                                break;
                            }
                            case MouseWheelInspector.browser.opera :
                            {
                                delta = e.wheelDelta / 40;
                                break;
                            }
                            default : //  safari, stainless, opera and chrome.
                            {
                                delta = e.wheelDelta / 80 ;
                                break;
                            }
                        }
                        target.onMouseEvent( delta ) ;
                    }
                    , 
                    false
                );
            };
            
            p.bind4msie = function ()
            {
                var _wheel  ;
                var _unload ;
                var target = this.target;
                
                _wheel = function ()
                {
                    var e     = win.event ;
                    var delta = 0 ;
                    var name  = e.srcElement.nodeName.toLowerCase() ;
                    
                    if (name != 'object' && name != 'embed') 
                    {
                        return;
                    }
                    if ( !target.checkScrolling() )
                    {
                        e.returnValue = false;
                    }
                    //  will trigger when wmode is `opaque` or `transparent`.
                    if ( !target.onMouseEvent ) 
                    {
                        return;
                    }
                    delta = e.wheelDelta / 40;
                    target.onMouseEvent(delta);
                };
                
                _unload = function ()
                {
                    target.detachEvent( "onmousewheel" , _wheel ) ;
                    win.detachEvent( "onunload" , _unload ) ;
                };
                
                target.attachEvent( "onmousewheel" , _wheel) ;
                win.attachEvent( "onunload" , _unload ) ;
            };
            
            p.initialize = function ( id )
            {
                var element = MouseWheelInspector.retrieveObject(id) ;
                if (element.nodeName.toLowerCase() == 'embed' || MouseWheelInspector.browser.safari)
                {
                    element = element.parentNode;
                }
                this.target    = element ;
                this.eventType = MouseWheelInspector.browser.mozilla ? "DOMMouseScroll" : "mousewheel" ;
            };
            
            ////// static
            
            MouseWheelInspector.browser = (function ( ua )
            {
                return {
                    version: (ua.match(/.+(?:rv|it|ra|ie)[\/:\\s]([\\d.]+)/)||[0,'0'])[1],
                    chrome: /chrome/.test(ua),
                    stainless: /stainless/.test(ua),
                    safari: /webkit/.test(ua) && !/(chrome|stainless)/.test(ua),
                    opera: /opera/.test(ua),
                    msie: /msie/.test(ua) && !/opera/.test(ua),
                    mozilla: /mozilla/.test(ua) && !/(compatible|webkit)/.test(ua)
                }
            })( nav.userAgent.toLowerCase() ) ;
            
            MouseWheelInspector.force = function (id)
            {
                if ( MouseWheelInspector.browser.safari || MouseWheelInspector.browser.stainless ) 
                {
                    return true ;
                }
                
                var element = MouseWheelInspector.retrieveObject(id) ;
                
                var name = element.nodeName.toLowerCase();
                
                if (name == 'object')
                {
                    var k ;
                    var v ;
                    var param ;
                    var params = element.getElementsByTagName('param') ;
                    
                    var len = params.length ;
                    
                    for ( var i = 0 ; i < len ; i++ )
                    {
                        param = params[i];
                        //  FIXME: getElementsByTagName is broken on IE?
                        if ( param.parentNode != element ) 
                        {
                            continue;
                        }
                        k = param.getAttribute('name') ;
                        v = param.getAttribute('value') || '' ;
                        if ( /wmode/i.test(k) && /(opaque|transparent)/i.test(v) ) 
                        {
                            return true ;
                        }
                    }
                }
                else if (name == 'embed')
                {
                    return /(opaque|transparent)/i.test(element.getAttribute("wmode"));
                }
                return false;
            };
            
            MouseWheelInspector.retrieveObject = function( id )
            {
                var element = doc.getElementById( id ) ;
                //  FIXME: fallback for `AC_FL_RunContent`.
                if ( !element )
                {
                    var nodes = doc.getElementsByTagName('embed') ;
                    var len   = nodes.length ;
                    for ( var i = 0; i < len ; i++ )
                    {
                        if ( nodes[i].getAttribute('name') == id )
                        {
                            element = nodes[i];
                            break;
                        }
                    }
                }
                return element ;
            };
            
            MouseWheelInspector.run = function ( id )
            {
                var t ;
                t = setInterval
                ( 
                    function ()
                    {
                        if ( MouseWheelInspector.retrieveObject( id ) )
                        {
                            clearInterval(t);
                            new MouseWheelInspector(id);
                        }
                    }
                    , 
                    1
                );
            };
        }
    ]]></script>; 
}
