VEGAS AS3 - version 1.9.0.2380

LICENCE
 
    Version: MPL 1.1/GPL 2.0/LGPL 2.1
    
        > Licence MPL 1.1  http://www.mozilla.org/MPL/MPL-1.1.html
        > Licence GPL 2    http://www.gnu.org/licenses/gpl-2.0.html
        > Licence LGPL 2.1 http://www.gnu.org/licenses/lgpl-2.1.html
   
PROJECT PAGES

    http://code.google.com/p/vegas/
    
ABOUT AUTHOR
    
    Author : ALCARAZ Marc (eKameleon)
    Link   : http://www.ekameleon.net/blog
    Mail   : ekameleon@gmail.com

DEPENDENCIES

    Use the AS3/trunk/dependencies folder to target the important dependencies libraries (maashaack) and extensions (lunas, calista) of VEGAS.

LIBRARIES

    You can use different libraries to compile with VEGAS in your project.
    
    - maashaack.swc : "full" contains all the maashaack packages (core, system, graphics, etc.)
    - maashaack modules
       * core.swc : the core package only
       * eden.swc : the library.eden package only
       * system.swc : the system package only
       * graphics.swc : the graphics package only
    
    either you want to keep the modularity of the packagesd and you use : core.swc, system.swc, graphics.swc or you want all the packages in one swc and you use only maashaack.swc
    
    In the AS3/trunk/libs directory you can find the libraries :
    
    - vegas-only.swc : contains only the vegas package.
    - vegas-sa.swc : "standalone" contains the vegas package and all this dependencies (core, system, graphics)
    - vegas.swc : "full" contains the vegas package, its dependencies ant all the vegas extensions (lunas, calista, etc)
    
    Note : The core packages (core, system and graphics) of VEGAS is based on Maashaack, more informations about this opensource framework :
    
     * http://code.google.com/p/maashaack/

A PROBLEM ?

    Don't forget to use the Google Code Issues List of the project if you find a bug and to use the Groups of VEGAS to ask all your question about it.

GET THE CODE WITH GCLIENT

    You will need the gclient tool.
    
    If you want to work with all the projects fused in a src folder
    
    1 - Creates a folder in your hard-disk to work : /opensource/gclient-vegas/
    
    2 - With the Terminal you target the new folder :
    
     cd /opensource/gclient-vegas
    
    3 - Initialize the gclient project :
    
     gclient config http://vegas.googlecode.com/svn/AS3/trunk/configs/vegas
     gclient update
    
    4 - Update the project when you want :
    
     gclient update
    
    To install gclient see the documentation page in the Maashaack wiki :
       * http://code.google.com/p/maashaack/wiki/gclient

DOCUMENTATION & CO

    http://code.google.com/p/vegas/ (tutorials and install)
    http://code.google.com/p/vegas/issues/list (issues)
    http://www.ekameleon.net/vegas/docs
    
    http://www.ekameleon.net/blog/ (french blog)
    
NOTES

    The swc target now the FlashPlayer 10.3 and build with the Flex SDK 4.5.1