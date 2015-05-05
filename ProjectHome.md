# VEGAS ActionScript framework #

Vegas is an opensource framework based on ECMAScript and ActionScript.

  * _The latest stable release : **[1.8.5](http://goo.gl/8hcHr)**_

  * _The latest stable nightly build in the SVN : **[1.9.4.2474](http://code.google.com/p/vegas/source/detail?r=2474)**_



&lt;wiki:gadget url="http://vegas.googlecode.com/svn/AS3/trunk/build/google-gadget/vegas\_facebook\_like.xml" width="450" height="80" border="none" /&gt;

If you use the framework please show it :)
&lt;wiki:gadget url="http://www.ohloh.net/projects/vegas/widgets/project\_users.xml" width="80" height="80" border="0"  /&gt;

## Description ##

You can use the same framework in ActionScript 3,2,1 and <b>SSAS</b> to deploy your RIAs.

VEGAS is based on Maashaack

  * http://code.google.com/p/maashaack/ (core/system/graphics packages)

## Licence ##

Version: **MPL 1.1/GPL 2.0/LGPL 2.1**

  * Licence MPL 1.1 :  http://www.mozilla.org/MPL/MPL-1.1.html
  * Licence GPL 2 : http://www.gnu.org/licenses/gpl-2.0.html
  * Licence LGPL 2.1 : http://www.gnu.org/licenses/lgpl-2.1.html

## About ##

  * Author  : ALCARAZ Marc (aka eKameleon)
  * Link : http://www.ekameleon.net/blog
  * Mail : ekameleon@gmail.com

## Install VEGAS ##

  * [Install the SVN VEGAS sources with TortoiseSVN ( AS3 and AS2 )](InstallVEGASwithSVN.md)
  * Download the sources with the top-level SVN repository : http://vegas.googlecode.com/svn

## References ##

  * [Full VEGAS reference](http://www.ekameleon.net/vegas/docs)
  * [VEGAS only reference](http://www.ekameleon.net/vegas-only/docs)
  * [Maashaack only reference](http://www.ekameleon.net/maashaack/docs/)

## Documentation ##

  * [Maashaack documentation](http://code.google.com/p/maashaack/wiki/Documentation)
  * [Tutorials](TutorialsVEGAS.md)

## Examples ##

  * [AS3 examples](http://vegas.googlecode.com/svn/AS3/trunk/examples/)

**NB :** Use your SVN client to update this examples (read the installation tutorial) but you can use the "export" process of your SVN client to manipulate all examples. The examples/ folder use svn:external to centralize all examples of VEGAS and this extensions.

## Thanks ##

  * [PowerFlasher](http://powerflasher.com/) and [FDT](http://fdt.powerflasher.com) OpenSource Licence.

[![](http://vegas.googlecode.com/svn/gfx/FDT_Supported.png)](http://fdt.powerflasher.com/)

&lt;wiki:gadget url="http://www.ohloh.net/projects/vegas/widgets/project\_basic\_stats.xml" width="350" height="220"  border="0" /&gt;
&lt;wiki:gadget url="http://www.ohloh.net/projects/maashaack/widgets/project\_basic\_stats.xml" height="220"  width="350" border="0" /&gt;
&lt;wiki:gadget url="http://www.ohloh.net/p/15413/widgets/project\_cocomo.xml" width="350" height="240" border="0" /&gt;

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

  * AS3 framework
  * JS/SSAS library

  * ADT (Abstract Data Type) libraries (queue, map, collections, stack, bag, iterator, etc.)
  * Advanced events model based on W3C Dom2/3 with bubbling, capturing etc + FrontController pattern.
  * Signals and Receivers implementation
  * IoC container and factory with hollywood principle implementation.
  * Localization and configuration engines
  * Advanced design pattern helpers (MVC, Visitor, Command, Observer, etc.)
  * Advanced logging engine
  * Drawing, colors, geometric tools
  * Advanced task engine (system.process) with Sequencer, Batch, etc.
  * Transition package (tweens, etc.)
  * User Interface tools
  * Advanced network and remoting tools

### MAASHAACK ###

The core libraries of VEGAS with the package core/system/graphics

  * [Maashaack page project (Google Code)](http://code.google.com/p/maashaack/)

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