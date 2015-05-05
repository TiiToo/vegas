# Install VEGAS with SVN #

VEGAS is an opensource project with a top-level SVN repository :

  * http://vegas.googlecode.com/svn

You can access the different source pages of this project :

  * [Checkout](http://code.google.com/p/vegas/source/checkout)
  * [Browse](http://code.google.com/p/vegas/source/browse)
  * [Changes](http://code.google.com/p/vegas/source/list)

or continue to read this tutorial.

# Installation of the sources with the SVN (subversion) repository #

## With SVN command line (Mac OSX) ##

Use the readonly SVN repository of VEGAS to download the last sources

1 - Creates a new folder in your hard disk, example : /opensource/vegas

2 - Open a command line terminal and write inside :

```
svn checkout http://vegas.googlecode.com/svn /opensource/vegas
```

3 - To update your local SVN repository you can write in your terminal :

```
svn update /opensource/vegas
```

## With TortoiseSVN (Windows) ##

**Tortoise SVN** is a powerfull **SVN** client to manager all your opensource or your private Surversion projects.

1 - Download the last version of **Tortoise SVN** : http://tortoisesvn.net/downloads

2 - Creates a SVN directory in your hard disk, for example : c:\opensource\vegas

3 - Right-click over the directory in Windows and select the **SVN checkout** item.

4 - Use the SVN link http://vegas.googlecode.com/svn and validate.

5 - All files are installed in your hard disk.. you can now use the right-click the **"update"** of the tortoiseSVN context menu to update **VEGAS**.

**Note :** If you want install only AS3 or AS2 sources in your disk you can target a specific branches in the top-level repository :

  * **AS3 version**  : http://vegas.googlecode.com/svn/AS3/trunk (The last stable nightly build)
  * **AS3 version**  : http://vegas.googlecode.com/svn/AS3/tags (The last stable versions)

  * **Javascript version**  : http://vegas.googlecode.com/svn/JS
  * **AS2 version**  : http://vegas.googlecode.com/svn/AS2
  * **SSAS version** : http://vegas.googlecode.com/svn/SSAS

## Other systems ##

In **Mac OSX** you can use [scplugin](http://scplugin.tigris.org/) or [SvnX](http://www.apple.com/downloads/macosx/development_tools/svnx.html) or [RapidSVN](http://rapidsvn.tigris.org/) to install the Vegas sources and examples.

This project's Subversion repository may be accessed using many [different client programs and plug-ins](http://subversion.tigris.org/links.html#clients). See your client's documentation for more information.

# Use VEGAS in Flash #

## AS3 project ##

Install the VEGAS library in Flash.

1 - Open Flash :)

2 - Select **Edit > Preferences (Windows)** or **Flash > Preferences (Macintosh)** to open the Preferences dialog box.

![http://vegas.googlecode.com/files/vegas_flash_classpath_01.jpg](http://vegas.googlecode.com/files/vegas_flash_classpath_01.jpg)

3 - Click the **ActionScript** in the left column, and then click the **ActionScript 3.0 Settings** button.

4 - Add a new library path in your ActionScript 3.0 panel and target the VEGAS library : **AS3/trunk/libs/vegas.swc** in your VEGAS project repository.

5 - click **OK**

6 - In flash creates a new AS3 document and in an ActionScript layer write :

```
import core.dump ;
trace( dump( { prop1 : "hello" , prop2 : true } ) ;
```

or

```
import graphics.FillStyle;
import graphics.display.Background;
 
var background:Background = new Background() ;

background.fill = new FillStyle(0xFF0000) ;
background.w    = 100 ;
background.h    = 100 ;
background.x    = 5 ;
background.y    = 5 ;

addChild( background ) ;
```

# VEGAS modularity #

You can use different libraries to compile with VEGAS in your project.

  * **maashaack.swc** : contains all the maashaack packages : core, system, graphics, etc.

In the [AS3/trunk/libs](http://vegas.googlecode.com/svn/AS3/trunk/libs/) directory you can find the libraries :

  * **vegas-only.swc** : contains only the **vegas** package.
  * **vegas-sa.swc** : "standalone" contains the **vegas** package and all its dependencies (**core**, **system**, **graphics**)
  * **vegas.swc** : "full" contains the **vegas** package, its dependencies ant all the vegas extensions (**lunas**, **calista**, etc)

**Note :**
The core packages (core, system and graphics) of **VEGAS** is based on Maashaack, more informations about this opensource framework :
  * http://code.google.com/p/maashaack/

# A problem ? #

Read the VEGAS references :

  * Full Reference : http://ekameleon.net/vegas/docs/
  * VEGAS only reference : http://ekameleon.net/vegas-only/docs/
  * Maashaack only : http://ekameleon.net/maashaack/docs/

Don't forget to use the [Google Code Issues List](http://code.google.com/p/vegas/issues/list) of the project if you find a bug and to use the [Groups of VEGAS](http://groups.google.com/group/vegasos|Google) to ask all your question about it.

# Get the code with gclient (contributors) #

Contributors or experts ? You will need the gclient tool.

If you want to work with all the projects fused in a src folder

1 - Creates a folder in your hard-disk to work : /opensource/gclient-vegas/

2 - With the Terminal you target the new folder :

```
cd /opensource/gclient-vegas
```

3 - Initialize the gclient project :

```
gclient config https://vegas.googlecode.com/svn/AS3/trunk/configs/vegas
gclient update
```

4 - Update the project when you want :

```
gclient update
```

To install gclient see the documentation page in the Maashaack wiki :
  * http://code.google.com/p/maashaack/wiki/gclient