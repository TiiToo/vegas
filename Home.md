# VEGAS version 1.8 #

Vegas is an opensource framework based on ECMAScript and ActionScript.

  * _The latest stable release : **[1.8.0.1997](http://code.google.com/p/vegas/downloads/detail?name=version%201.8.0.1997.zip)**_

## Description ##

You can use the same framework in ActionScript 3,2,1 and <b>SSAS</b> to deploy your RIAs.

VEGAS is based on Maashaack

  * http://code.google.com/p/maashaack/

|&lt;wiki:gadget url="http://www.ohloh.net/projects/vegas/widgets/project\_basic\_stats.xml" height="220"  border="0" /&gt;|&lt;wiki:gadget url="http://www.ohloh.net/projects/maashaack/widgets/project\_basic\_stats.xml" height="220"  border="0" /&gt;|
|:-------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------|

If you use the framework please show it :)

&lt;wiki:gadget url="http://www.ohloh.net/projects/vegas/widgets/project\_users.xml" height="100" border="0" /&gt;

## Install VEGAS ##

  * [Install the SVN VEGAS sources with TortoiseSVN ( AS3 and AS2 )](InstallVEGASwithSVN.md)
  * Download the sources with the top-level SVN repository : http://vegas.googlecode.com/svn

## Documentation ##

  * [Tutorials](TutorialsVEGAS.md)
  * [Documentation online](http://www.ekameleon.net/vegas/docs/)
  * [French tutorials](http://wiki.mediabox.fr/tutoriaux/vegas)

## Examples ##

  * [AS3 Flash CS3 examples](http://vegas.googlecode.com/svn/AS3/trunk/examples/)

**NB :** Use your SVN client to update this examples (read the installation tutorial) but you can use the "export" process of your SVN client to manipulate all examples. The examples/ folder use svn:external to centralize all examples of VEGAS and this extensions.

## Licence ##

  * [Mozilla Public License 1.1 (MPL1.1)](http://www.opensource.org/licenses/mozilla1.1.php)

## About ##

  * Author  : ALCARAZ Marc (aka eKameleon)
  * Link : http://www.ekameleon.net/blog
  * Mail : ekameleon@gmail.com

## Thanks ##

  * [PowerFlasher](http://powerflasher.com/) and [FDT](http://fdt.powerflasher.com) OpenSource Licence.

[![](http://vegas.googlecode.com/svn/gfx/FDT_Supported.png)](http://fdt.powerflasher.com/)

## Requirements ##

You can use my library in your projects with :

  * AS3 : [Eclipse](http://www.eclipse.org/) and [FDT](http://fdt.powerflasher.com/)
  * AS3 : [Flex SDK](http://www.adobe.com/products/flex/sdk/).

  * AS2 : Flash MX2004 or Flash8 or Flash CS3/CS4.
  * AS2 : [MTASC](http://www.mtasc.org/)
  * AS2 : [Eclipse](http://www.eclipse.org/) and [FDT](http://fdt.powerflasher.com/)

  * SSAS : **FC 1.5** or **Flash Media Server 2** or **Flash Media Server 3**
  * SSAS : [FMS Eclipse](http://fczone.com/eclipse/)
  * SSAS : [JSEclipse](http://labs.adobe.com/technologies/jseclipse/)

## FEATURES LIST ##

### VEGAS ###

  * AS3, SSAS and AS2 Frameworks.
  * SSAS library based on Core2 and EDEN.
  * ADT (Abstract Data Type) libraries (queue, map, collections, stack, bag, iterator, etc.)
  * Advanced events model based on W3C Dom2/3 with bubbling, capturing etc + FrontController pattern.
  * IoC container and factory with hollywood principle implementation.
  * Localization and configuration engines
  * Advanced design pattern helpers (MVC, Visitor, Command, Observer, etc.)
  * Advanced logging engine
  * Drawing, colors, geometric tools
  * Advanced task engine (system.process) with Sequencer, Batch, etc.
  * Transition package (tweens, etc.)
  * User Interface tools
  * Advanced network and remoting tools

In the SSAS(Server Side ActionScript) version for Flash Media Server :

  * The same Remoting class like AS2 and AS3 libraries.
  * asgard.server.Application class to creates your FMS application based on VEGAS.
  * asgard.server.Gateway class to creates a Gateway based on the FrontController of Vegas (used AS2 Event in the client application and send this events with the NetConnection.call method directly in the server side FrontController.

### LunAS ###

This library based VEGAS to create components. It's not library of components (like in Flash or in the Flex SDK) but a framework to build dynamic or visual components.

  * [LunAS page project (Google Code)](http://code.google.com/p/lun-as/)

Features :

  * Progressbar, Scrollbar
  * Full Button implementations
  * Container implementations : SimpleContainer, ListContainer, ScrollContainer, AutoScrollContainer, MatrixContainer, CircleContainer
  * Label package : Label, IconLabel, PaginationLabel
  * TextInput : SimpleTextInput, VisualTextInput

### CalistA ###

  * [CalistA page project (Google Code)](http://code.google.com/p/calista/)

CalistA is a little cryptography library written in Actionscript include in the VEGAS framework with

  * hash : Adler32, CRC32, Blowfish, RXOR, SHA1, SHA256, MD5, TEA, Vigenère
  * utils : LZW, Base64, Base8

### AST'r ###

ActionScript Template application framework based on VEGAS. This opensource library contains a skeletal to implement rich application with VEGAS and this extensions. For the moment this library is an experimental laboratory to implements a concrete example with VEGAS.

  * Download the sources of this project in the Google Code page : http://code.google.com/p/astr/

### NinjAS ###

Full AS3 projects based on VEGAS (coverflow, video player, minifier, swc helper, etc.)

  * [NinjAS page project (Google Code)](http://code.google.com/p/ninjas/)