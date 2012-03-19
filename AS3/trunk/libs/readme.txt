VEGAS AS3 - version 1.9.4.2463

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
    
LIBRARIES

    The swc libraries in this folder target the FlashPlayer 11.1 / AIR 3.1 and build with the Flex SDK 4.6
    
    You can use different libraries to compile with VEGAS in your project.
    
    VEGAS is based on Maashaack, you can find the sources of maashaack in the maashaack directory or in the site of the project : 
    
        http://code.google.com/p/maashaack/
    
        |_ maashaack
            |_ maashaack.swc : contains all the maashaack packages and libraries (core, system, graphics, eden, etc.)
    
    In the AS3/trunk/libs directory you can find the libraries :
    
        |_ vegas-only.swc : contains only the vegas package.
        |_ vegas-sa.swc : "standalone" contains the vegas package and all this dependencies (core, system, graphics)
        |_ vegas.swc : "full" contains the vegas package, its dependencies ant all the vegas extensions (lunas, calista, etc)
    
    More information about NinjAS :
     
        http://code.google.com/p/ninjas/
        
        |_ ninjas
            |_ ninpo.swc : contains only the ninjas.ninpo package.

DOCUMENTATION & CO

    http://www.ekameleon.net/vegas/docs
    http://www.ekameleon.net/vegas-only/docs
    http://www.ekameleon.net/maashaack/docs
    
    http://code.google.com/p/vegas/wiki/InstallVEGASwithSVN (install)
    
    http://code.google.com/p/maashaack/
    http://code.google.com/p/ninjas/
    http://code.google.com/p/astr/

A PROBLEM ?

    Don't forget to ask your questions in :
      |_ the Google Code Issues List : http://code.google.com/p/vegas/issues/list
      |_ the Google Groups VEGASOS : http://groups.google.com/group/vegasos

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
