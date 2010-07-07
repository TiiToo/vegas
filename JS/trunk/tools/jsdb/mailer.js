function Mailer()
{
 this.ajax = null;
 this.http = null;
}

Mailer.prototype.home = function (client,data)
{
 client.writeln("HTTP/1.1 200 OK");
 client.writeln("client: close");
 client.writeln("Date: ", client.startTime.toUTCString());
 client.writeln("Expires: ", client.startTime.toUTCString());
 client.writeln("Server: Mailer/0.1");
 client.writeln("Content-type: text/html\n");

 client.writeln("<head><title>Bulk mailer</title></head><body link=blue vlink=blue bgcolor=#ffffc0>");
 client.writeln("<font face=Arial,Helvetica,sans-serif>");
 this.printJS(client);

 if (typeof(data) != 'undefined' && data != null)
 {
  client.writeln("<P>Please check your login settings and verify that the message and address list files exist.");
 }
 else
 {
 if (!data) data = new Record;

 try {
  var file = new Stream('mail.txt','rt');
  data = new Record;
  file.readMIME(data);
  file.close();
  } catch(err) {writeln(err) }
 }

client.writeln("<form method=post action=preview>");
client.writeln(' <table>  ');
client.writeln(' <tr><td>To <td><input name=address value="',data.get("address"),'">');
client.writeln(' <tr><td>Address list<td><input name=addressfile value="',data.get("addressfile"),'">');
client.writeln(' <input type=hidden name=addressfield value="',data.get("addressfield"),'">');
client.writeln(' <tr><td>Subject<td><input name=subject value=',data.get("subject"),'>');
client.writeln(' <tr><td>Text message<td><textarea rows=10 cols=40 name=note>',data.get("note"),'</textarea>');
client.writeln(' <tr><td>Or load the message from a file<td><input name=notefile value="',data.get("notefile"),'">');
client.writeln('<tr><td colspan=2></td>');
client.writeln(' <tr><td>Return address<td><input name=return value="',data.get("return"),'">');
client.writeln('<tr><td colspan=2></td>');
client.writeln(' <tr><td>Mail system<td><select name=method><option value=SMTP ');
if (data.get('method') == 'SMTP') client.writeln('SELECTED');
client.writeln('>Internet</option><option value=MAPI ');
if (data.get('method') == 'MAPI') client.writeln('SELECTED');
client.writeln('>Outlook</option></select>');
client.writeln(' <tr><td>Login<td><input name=name value="',data.get("name"),'">');
client.writeln(' <tr><td>Password<td><input type=password name=password value="',data.get("password"),'">');
client.writeln(' <tr><td>Server<td><input name=server value="',data.get("server"),'">');
client.writeln('<tr><td colspan=2 align=center><input type=submit value=Preview></td>');
client.writeln('</table>');
client.writeln('</form>');
client.writeln("</font>");
}


Mailer.prototype.printJS = function(client)
{
 if (!this.ajax)
  this.ajax = system.resource('ajax.html');
 else
  this.ajax.rewind();

 client.write(this.ajax.readFile());
}

Mailer.prototype.logout =function(client)
{
 client.writeln("HTTP/1.1 200 OK");
 client.writeln("client: close");
 client.writeln("Date: ", client.startTime.toUTCString());
 client.writeln("Expires: ", client.startTime.toUTCString());
 client.writeln("Server: Mailer/0.1");
 client.writeln("Content-type: text/html\n");
 client.writeln("<head><title>Sending</title></head><body link=blue vlink=blue bgcolor=#ffffc0>");
 client.writeln("<script language=JavaScript>\n<!--\n//window.close()\n//--></script>");
 client.writeln("<P align=center>You may close this window<br>");
 client.writeln('<input type=button onClick="window.close()" value=Close>');
}

Mailer.prototype.preview = function(client,data)
{
 var addressfile = null;
 var notefile = null;
try {
 var mail = new Mail(data.get('method'),data.get('name'),data.get('password'),data.get('server'),'','',data.get('return'));
 if (data.get('addressfile'))
   addressfile = new Stream(data.get('addressfile'),'rt');
 if (data.get('notefile'))
   notefile = new Stream(data.get('notefile'),'rb');
 } catch (err)
 {
  return this.home(client,data);
 }

 client.writeln("HTTP/1.1 200 OK");
 client.writeln("client: close");
 client.writeln("Date: ", client.startTime.toUTCString());
 client.writeln("Expires: ", client.startTime.toUTCString());
 client.writeln("Server: Mailer/0.1");
 client.writeln("Content-type: text/html\n");

 client.writeln("<head><title>Sending</title></head><body link=blue vlink=blue bgcolor=#ffffc0>");
 this.printJS(client);

 client.writeln("<form method=post action=send>");

 var subject = data.get('subject');
 client.writeln('<table>  ');
 client.writeln('<tr><td>To:<td>',data.get("address"));
 if (addressfile)
 {
  var firstline = addressfile.readLine();
  var fields = firstline.split('\t');
  if (fields.length == 1) fields = firstline.split(',');
  if (fields.length == 1) // just a list of addresses
    {
     client.writeln(firstline,",",addressfile.readLine(),"...");
    }
  else
    {
     if (!data.get('addressfield')) data.set('addressfield','EMAIL');

     client.writeln('<select name=addressfield>');
     for (var i in fields)
     {
    client.writeln('<option name="',fields[i],'"');
       if (fields[i] == data.get('addressfield')) client.writeln(" SELECTED");
       client.writeln('>',fields[i],'</option>');
     }
     client.writeln("</select>");
    }
 }

 if (addressfile)
    addressfile.close();

 client.writeln('<tr><td>Subject:<td>',subject  );


 var note = data.get('note');
 if (addressfile)
   {
     var r = new Record;
     var t = new Table(data.get('addressfile'));
     t.getRow(1,r);
     n = new Stream;
     n.format(note,r);
     if (notefile)
     {
      n.writeln("\r\n");
      n.format(notefile,r);
     }
     note = n;
   }
 else if (notefile)
  {
   note += '\r\n' + notefile.readText();
  }

 client.writeln('<tr><td>Note:<td><pre>',note.toString() ,'</pre>');
 client.writeln(' <tr><td>Return address<td>',data.get("return"));
 client.writeln('</table>');


 data.unSet("addressfield");

 for (var i=0; i<data.count; i++)
  client.writeln('<input type=hidden name="',data.name(i),'" value="',data.value(i),'">');

 client.writeln('<input type=button onClick="history.back();" value=Back>');
 client.writeln('<input type=submit value=Send>');
 client.writeln('</form><hr>')
 client.writeln("<form action=logout><input type=submit value=Exit></form>");

 if (notefile) notefile.close();
 if (addressfile) addressfile.close();
 }

Mailer.prototype.ping=function (client,data)
{
 client.writeln("HTTP/1.1 200 OK");
 client.writeln("client: close");
 client.writeln("Date: ", client.startTime.toUTCString());
 client.writeln("Expires: ", client.startTime.toUTCString());
 client.writeln("Server: Mailer/0.1");
 client.writeln("Content-type: text/html");
 client.writeln('');
 client.writeln("ok");
}

Mailer.prototype.send =function (client,data)
{
 client.writeln("HTTP/1.1 200 OK");
 client.writeln("client: close");
 client.writeln("Date: ", client.startTime.toUTCString());
 client.writeln("Expires: ", client.startTime.toUTCString());
 client.writeln("Server: Mailer/0.1");
 client.writeln("Content-type: text/html");
 client.writeln('');
 this.printJS(client);
 client.writeln("<head><title>Sending</title></head><body link=blue vlink=blue bgcolor=#ffffc0>");
 client.writeln("<font face=Arial,Helvetica,sans-serif>");

 client.writeln("<H3>Starting the mail service</H3>")
 client.writeln("<pre>",data,"</pre><br>")
 client.writeln("Logging into ",data.get('server'),' as ',data.get('name'),"<br>");

// writeln(data.toString());
 if (data.get('METHOD') == '') data.set('METHOD','SMTP');
 var addressfile = null;
 var notefile = null;
try {
 var mail = new Mail(data.get('method'),data.get('name'),data.get('password'),data.get('server'),'','',data.get('return'));
 if (data.get('addressfile'))
   addressfile = new Stream(data.get('addressfile'),'rt');
 if (data.get('notefile'))
   notefile = new Stream(data.get('notefile'),'rb');
 } catch (err)
 {
  return this.home(client,data);
 }
 var note = data.get('note');
 if (notefile) note += '\r\n' + notefile.readText();

 var subject = data.get('subject');
 var address = data.get('address');

  try {
  var file = new Stream('mail.txt','wt');
  data.unSet('note');
  file.writeMIME(data);
  file.close();
  delete file;
  } catch(err)
  {
  writeln(err)
  }


 var trouble = new Array;
 var success = new Array;

 client.writeln("<H3>Sending</h3>");
 if (address)
 {
  client.writeln('<br><tt><a href=mailto:"',address,'">',address,'</a></tt> ');
  try {
   if (mail.send(address,subject,note))
    {
     client.writeln("<tt>OK</tt>");
     success.push(address);
    }
   else
    {
     trouble.push({name:address, why: ''});
    }
  } catch(err)
  {
   client.writeln('<tt><font color=red>',err,'</font></tt>');
   trouble.push(address);
  }
 }

 if (data.get('addressfield')) /* mailmerge */
 {
  var t = new Table(data.get('addressfile'));
  for (var i=1; i <= t.count; i++)
  {
   var address = t.get(i,data.get('addressfield'));
   client.writeln('<br><tt><a href=mailto:"',address,'">',address,'</a></tt> ');
   var n = new Stream;
   n.format(note,t.getRow(i));
   client.writeln('<pre>',n.toString(),'</pre>');
   try 
   {
    if (mail.send(address,subject,n.toString()))
    {
     client.writeln("<tt>OK</tt>");
     success.push(address);
    }
    else
    {
     trouble.push({name:address,value:mail.error});
    }
   } catch(err)
   {
    client.writeln('<tt><font color=red>',err,'</font></tt>');
    trouble.push({name:address,value:err});
   }
  }
 }
 else if (addressfile) while (!addressfile.eof)
 {
  var address = addressfile.readLine();
  client.writeln('<br><tt><a href=mailto:"',address,'">',address,'</a></tt> ');
  try {
   if (mail.send(address,subject,note))
    {
     client.writeln("<tt>OK</tt>");
     success.push(address);
    }
   else
    {
     trouble.push({name: address, value:mail.error});
    }
  } catch(err)
  {
   client.writeln('<tt><font color=red>',err,'</font></tt>');
   trouble.push({name: address, value:err});
  }
 }

 client.writeln("<H3>Done sending</H3>")
 if (success.length)
 {
  client.writeln("<P>Your message was sent to these addresses");
  for(var i in success)
    client.writeln("<br><tt>",success[i]);
  }

 if (trouble.length)
 {
 client.writeln("<P>I was unable to send mail to these addresses");
 for(var i in trouble)
   client.writeln("<br><tt>",trouble[i].name,": ",trouble[i].value,"</tt> ");
 }

 client.writeln("<form action=logout><input type=submit value=Done></form>");
 client.writeln("<form action=home><input type=submit value=Restart></form>");
}

Mailer.prototype.run = function()
{
 if (this.http != null) return;

 this.http = null;
 for (var port = 8080; this.http == null && port < 8180; port++)
  {
  try {
   this.http = new Server(port);
   } catch(err)
   {
    writeln('Port ', port,' appears to be in use');
   }
  }

 var ie = system.getKey('hkey_classes_root/htmlfile/shell/open/command',"");
 var now = new Date;
 var timeout = Number(now) + 1000;
 
 system.execute('http://127.0.0.1:'+ this.http.port + '/')

 while (!jsShouldStop() ) /* invokes garbage collection, and may stall */
 {
   now = new Date;
   if (!this.http.anyoneWaiting)
    {
     if (Number(now) > timeout)
     {
        break;
     }
     sleep(100);
     continue;
    }

   timeout = Number(now) + 1000;
   var client = this.http.accept();
   if (client == null)
    continue;

   var request = client.readLine().split(/\s+/);

   client.method = request[0];
   client.uri = request[1];
   if (client.uri == null || client.uri == '') client.uri = '/';
   client.version = request[2];
   //this.page() should give enough time for the header packet to arrive
   if (client.canRead)
   {
    client.startTime = new Date();
    client.header = new Record;
    client.readMIME(client.header);
   }
   client.appname = client.uri.substr(1);
   client.query = ''
   request = client.uri.match(/\/?([^?]*)\?(.*)/);
   if (request != null)
    {
     client.appname = request[1];
     client.query = request[2];
    }

   if (client.method == "GET" && client.query)
    client.data = new Record(client.query,'&');
   else if (client.method = "POST" && client.header.get('Content-type') == 'application/x-www-form-urlencoded')
    client.data = new Record(client.read(client.header.get('Content-length')),'&');

   if (client.data)
   {
    for(x=0; x<client.data.length; x++)
      client.data.set(x, decodeURL(client.data.value(x)));
   }

   if (client.appname == '' || client.appname == 'home')
   {
   try {
    this.home(client);
    } catch(err)
     {
      writeln("Error: ",err);
      client.writeln("Error: ",err);
     }
    client.close();
    continue;
   }

   if (client.appname == 'ping')
   {
    this.ping(client);
    client.close();
    continue;
   }

   if (client.appname == 'send')
   {
    try{
    this.send(client,client.data);
     } catch(err)
         {
          writeln("Error: ",err);
          client.writeln("Error: ",err);
     }
    client.close();
    continue;
   }

   if (client.appname == 'preview')
   {
    try{
    this.preview(client,client.data);
     } catch(err)
         {
          writeln("Error: ",err);
          client.writeln("Error: ",err);
     }
    client.close();
    continue;
   }

   if (client.appname == 'logout' || client.appname == 'logout')
      {
       try{
       this.logout(client,client.data);
        } catch(err)
            {
             writeln("Error: ",err);
             client.writeln("Error: ",err);
        }
       client.close();
       break;
   }
   writeln('unknown page ',client.appname)

   client.writeln("HTTP/1.1 404 NOT FOUND");
   client.writeln("Date: ", client.startTime.toUTCString());
   client.writeln("Expires: ", client.startTime.toUTCString());
   client.writeln("Server: Mailer/0.1");
   client.writeln("Content-type: text/html\n");
   client.writeln("<H2>HTTP/1.1 404 Not Found</H2>");
   client.writeln("<br>URL:",client.uri);
   client.writeln("<br><a href=/>Home</a>");
   client.close();
 }

 this.http.close();
}


var server = new Mailer();
server.run();
delete server;