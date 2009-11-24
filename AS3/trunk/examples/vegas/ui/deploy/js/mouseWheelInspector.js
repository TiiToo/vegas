/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
(function ()
{
if ( window.MouseWheelInspector ) 
{
    return;
}

var doc = document  ;
var nav = navigator ;
var win = window    ;

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
        var len    = params.length ;
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
})();