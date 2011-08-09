VEGAS AS3 - version 1.9.0.2269

This directory use svn externals to centralize all sources.

    - core http://maashaack.googlecode.com/svn/packages/core/trunk/src/core/
    - system http://maashaack.googlecode.com/svn/branches/maashaack_ekameleon/trunk/src/system/
    - graphics http://maashaack.googlecode.com/svn/packages/graphics/trunk/src/graphics/
    - vegas http://vegas.googlecode.com/svn/AS3/trunk/sources/vegas/
    - lunas http://lun-as.googlecode.com/svn/trunk/AS3/trunk/src/lunas
    - calista http://calista.googlecode.com/svn/trunk/AS3/src/calista
    
Note :

    Use the vegas.swc library in trunk/libs to compile your application.

    If you want use the src/ folder to compile you must use the CC (Conditional Compilation) 
    definitions in your compiler command lines :
       
       -define+=CONFIG::release,false
       -define+=CONFIG::debugging,false
       -define+=API::FLASH,true
       -define+=API::REDTAMARIN,false
       
    More Informations about conditional compilation :
    http://code.google.com/p/maashaack/wiki/ConditionalCompilation  

LICENCE 
   
    Version: MPL 1.1/GPL 2.0/LGPL 2.1
   
PROJECT PAGES
    
    * http://code.google.com/p/vegas/
    
DOCUMENTATION & CO
    
    * http://code.google.com/p/vegas/ (tutorials and install)
    * http://code.google.com/p/vegas/issues/list (issues)
    * http://www.ekameleon.net/vegas/docs
    
    * http://www.ekameleon.net/blog/ (french blog)
    
ABOUT AUTHOR
    
    * Author : ALCARAZ Marc (eKameleon)
    * Link   : http://www.ekameleon.net/
    * Mail   : ekameleon@gmail.com