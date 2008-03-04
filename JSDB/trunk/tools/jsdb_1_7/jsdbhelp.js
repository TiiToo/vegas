load('xml.js');

function makehelp(infile,outfile,sidebarfile,title,target,about)
{
if (sidebarfile)
{
var sidebar = new Stream(sidebarfile,'w');
sidebar.writeln("<HTML><HEAD><TITLE>",title,"</TITLE><base target=",target," />");
sidebar.writeln("<STYLE>");
sidebar.writeln(".treebranch {list-style-image: url(http://www.jsdb.org/plus.gif);}");
sidebar.writeln(".treeleaf {list-style-image: url(http://www.jsdb.org/solid.gif);cursor: default;}");
sidebar.writeln(".list {display: none;}");
sidebar.writeln("A {text-decoration: none; cursor:hand;color: blue}");
sidebar.writeln("A.prop {color: purple}");
sidebar.writeln("A.func {color: green}");
sidebar.writeln("P {margin-left: 2px; padding=0px; margin-top=0px; font:10pt/12pt Helvetica,Arial,sans-serif}");
sidebar.writeln("LI {margin-left: 2px; padding=0px; margin-top=0px; font:10pt/12pt Helvetica,Arial,sans-serif}");
sidebar.writeln("UL {margin-left: 16px; margin-top: 0px; padding-left:0px; padding-top: 0px;border-left:0px;font:10pt/12pt Helvetica,Arial,sans-serif}");
sidebar.writeln("</STYLE>");
sidebar.writeln("<SCRIPT>");
sidebar.writeln("function getList (li) {");
sidebar.writeln("  var list = null;");
sidebar.writeln("  for (var c = 0; c < li.childNodes.length; c++)");
sidebar.writeln("    if (li.childNodes[c].nodeName == 'UL') {");
sidebar.writeln("      list = li.childNodes[c];");
sidebar.writeln("      break;");
sidebar.writeln("    }");
sidebar.writeln("  return list;");
sidebar.writeln("}");
sidebar.writeln("function onClickHandler (evt) {");
sidebar.writeln("  var target = evt ? evt.target : event.srcElement;");
sidebar.writeln("  if (target.className == 'treebranch') {");
sidebar.writeln("    if (target.expanded) {");
sidebar.writeln("      target.style.listStyleImage = 'url(http://www.jsdb.org/plus.gif)';");
sidebar.writeln("      getList(target).style.display = 'none';");
sidebar.writeln("      target.expanded = false;");
sidebar.writeln("    }");
sidebar.writeln("    else {");
sidebar.writeln("      target.style.listStyleImage = 'url(http://www.jsdb.org/minus.gif)';");
sidebar.writeln("      getList(target).style.display = 'block';");
sidebar.writeln("      target.expanded = true;");
sidebar.writeln("    }");
sidebar.writeln("  }");
sidebar.writeln("  return true;");
sidebar.writeln("}");
sidebar.writeln("document.onclick = onClickHandler;");
sidebar.writeln("");
sidebar.writeln("</SCRIPT>");
sidebar.writeln("</HEAD><BODY>");
sidebar.writeln(about);
}

if (outfile)
{
  var out = new Stream(outfile,'w');
  out.writeln("<HTML><HEAD><TITLE>",title,"</TITLE>");
  out.writeln("<style type=text/css>\n<!--\n");
  out.writeln("P {margin-left=2px; margin-top=0px; font:10pt/12pt Helvetica,Arial,sans-serif}");
  out.writeln("TD {margin-left=10px; margin-top=0px; margin-bottom=3px; font:10pt/12pt Helvetica,Arial,sans-serif}");
  out.writeln("DT {margin-left=10px; margin-top=2px; font:10pt/12pt Helvetica,Arial,sans-serif}");
  out.writeln("DD {margin-left=10px; margin-top=0px; font:10pt/12pt Helvetica,Arial,sans-serif}");
  out.writeln("H2 {margin-left=0px; margin-top=5px; padding: 3px; background-color: rgb(255,255,192); border-top: thin solid #000000; font-weight: bold; font:14pt/14pt Helvetica,Arial,sans-serif}");
  out.writeln("H3 {margin-left=5px; font-weight: bold; font:12pt/14pt Helvetica,Arial,sans-serif}");
  out.writeln("tt {font:10pt/12pt Courier,monospace}");
  out.writeln("\n-->\n</style></head>");
  out.writeln("</head><body>");
}

if (typeof (infile) == "string") {infile = [infile];}

for (var i1 in infile)
{
  writeln(infile[i1])
  if (typeof(infile[i1]) == "string")
    file = readXML(new Stream(infile[i1]),"classref,class,property,parameter,function,comment");
  else
    file = readXML(infile[i1],"classref,class,property,parameter,function,comment");

  file.sort('name');
  var c = file.find('class');

sidebar.writeln("<ul>");

for (var x in c) /* write the class info */
 {
  var cname = c[x].get('name');
  writeln('  ',cname)
  sidebar.writeln("<li class=treebranch><a href=",outfile,"#",cname,">",cname,"</a>");
  sidebar.writeln("<ul class=list>");
  c[x].sort('name');
  var list = c[x].find('property');
  for (var i in list)
  {
    sidebar.writeln("<li class=treeleaf><a class=prop href=",outfile,"#",cname,"_",list[i].get('name'),">",list[i].get('name'),"</a>");
  }
  var list = c[x].find('function');
  for (var i in list)
  {
    sidebar.writeln("<li class=treeleaf><a class=func href=",outfile,"#",cname,"_",list[i].get('name'),">",list[i].get('name'),"</a>");
  }
  sidebar.writeln("</ul>");
 }
 sidebar.writeln("</ul><hr>");

if (outfile)
{
for (var x in c) /* write the class info */
 {
  var cname = c[x].get('name');
  c[x].sort('name');
  out.writeln("<H2><a name=",cname,"><b>",cname,"</b></H2>");
  var module = c[x].get('module');
  if (module != '')
   {
    out.write("<tt>include('",module.fontcolor('darkgreen'),"')</tt><br>");
   }
  var comment = c[x].find('comment');
  for (var i in comment) out.writeln("<P>",comment[i].cdata,"<br>");

  var p = c[x].find('property');
  if (p.length)
  {
   out.writeln("<H3><b>Properties</b></H3>");
   out.writeln("<TABLE>");
   for(var i in p)
    {
     var pname = p[i].get('name')
     out.write("<TR><TD width=2% NOWRAP valign=top><A NAME=",cname,"_",pname,"></A>");
     out.writeln(pname.fontcolor('purple'),"<TD valign=top>",p[i].get('type').fontcolor('navy'),'</td>');
     out.writeln("<TD valign=top width=98%>",p[i].cdata);
    }
   out.writeln("</TABLE>");
  }

  f = c[x].find('function');
  if (f.length)
  {
   out.writeln("<H3><b>Functions</b></H3><DL>");
   for(var i in f)
    {
     var fname = f[i].get('name')
     var p = f[i].find('parameter');

     out.writeln("<DT><A NAME=",cname,"_",fname,"></A>");
     out.writeln(fname.fontcolor('green'),"(");

      for (var j in p)
       {
        if (j > 0) out.write(", ");
        out.write(p[j].get('name').fontcolor('purple')," ",p[j].get('type').fontcolor('navy'));
        if (f[i].get('optional') != '') out.write("[optional]");
       }

     out.writeln(")");
     if (f[i].get('type'))
       out.writeln(" returns ",f[i].get('type').fontcolor('navy'));
     out.writeln("<dd><TABLE>");

     for (var j in p)
       {
       if (p[j].cdata.length == 0) continue;
        out.writeln("<TR><TD width=2% NOWRAP valign=top>",p[j].get('name').fontcolor('purple'));
        out.writeln("<TD valign=top>",p[j].cdata);
       }


     out.writeln("<tr><Td colspan=2>");
     out.writeln(f[i].cdata);
     out.writeln("</TABLE>");

    }
   out.writeln("</DL>")
  }
 }
}
}
if (sidebarfile)
{
sidebar.writeln('<li><a')
sidebar.writeln('href="http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array"')
sidebar.writeln('title="Core JavaScript 1.5 Reference:Global Objects:Array">Array</a>')
sidebar.writeln('</li>')
sidebar.writeln('<li><a')
sidebar.writeln('href="http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Boolean"')
sidebar.writeln('title="Core JavaScript 1.5 Reference:Global Objects:Boolean">Boolean</a>')
sidebar.writeln('</li>')
sidebar.writeln('<li><a')
sidebar.writeln('href="http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Date"')
sidebar.writeln('title="Core JavaScript 1.5 Reference:Global Objects:Date">Date</a>')
sidebar.writeln('</li>')
sidebar.writeln('<li><a')
sidebar.writeln('href="http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Function"')
sidebar.writeln('title="Core JavaScript 1.5 Reference:Global Objects:Function">Function</a>')
sidebar.writeln('</li>')
sidebar.writeln('<li><a')
sidebar.writeln('href="http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Math"')
sidebar.writeln('title="Core JavaScript 1.5 Reference:Global Objects:Math">Math</a>')
sidebar.writeln('</li>')
sidebar.writeln('<li><a')
sidebar.writeln('href="http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Number"')
sidebar.writeln('title="Core JavaScript 1.5 Reference:Global Objects:Number">Number</a>')
sidebar.writeln('</li>')
sidebar.writeln('<li><a')
sidebar.writeln('href="http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Object"')
sidebar.writeln('title="Core JavaScript 1.5 Reference:Global Objects:Object">Object</a>')
sidebar.writeln('</li>')
sidebar.writeln('<li><a')
sidebar.writeln('href="http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:RegExp"')
sidebar.writeln('title="Core JavaScript 1.5 Reference:Global Objects:RegExp">RegExp</a>')
sidebar.writeln('</li>')
sidebar.writeln('<li><a')
sidebar.writeln('href="http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:String"')
sidebar.writeln('title="Core JavaScript 1.5 Reference:Global Objects:String">String</a>')
sidebar.writeln('</li>')
sidebar.writeln('</ul>')
sidebar.writeln("</BODY></HTML>")
}
}

makehelp(['jsdbhelp.xml'],'jsdbhelp.html','jsdbbar.html',"JSDB Reference","_content","<P><a href=http://www.jsdb.org/>About JSDB<sub>&reg;</sub></a>");
makehelp(['jsdbhelp.xml'],'jsdbhelp.html','jsdbmenu.html',"JSDB Reference","body","<P><a target=\"_parent\" href=http://www.jsdb.org/>About JSDB<sub>&reg;</sub></a><br><A href=tutorial.html>Tutorial</a><br><A href=cookbook.html>Cookbook</a>");

