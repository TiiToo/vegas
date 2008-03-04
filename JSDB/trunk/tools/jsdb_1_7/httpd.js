function HTTPD()
{
 this.ajax = null;
 this.http = null;
 this.running = true; //set this.running = false to exit the server
 this.types = {'html': "text/html", 
              'htm': "text/html", 
              'png': "image/png", 
              'txt': "text/plain",
              'css': "text/css",
              'svg': "image/svg+xml",
              'js': "application/x-javascript"}
}

HTTPD.prototype.home = function(client,data)
{
 client.writeln("Content-type: text/html");
 client.writeln();
 
 client.writeln("<html><body><p>Hello, world!</p>")

 client.writeln("HTTP headers\n<pre>"); 
 if (client.header)
 client.writeln(client.header.toString())
 client.writeln("</pre>")

 client.writeln("Form fields\n<pre>");
 if (data)
 client.writeln(data.toString())
 client.writeln("</pre>")

 client.writeln("</body></html>");
}

HTTPD.prototype.sendOK = function(client)
{
 client.writeln("HTTP/1.1 200 OK");
 client.writeln("Client: close");
 client.writeln("Date: ", client.startTime.toUTCString());
 client.writeln("Expires: ", client.startTime.toUTCString());
 client.writeln("Server: JSDB/"+system.version);
}

HTTPD.prototype.sendERROR= function(client)
{
 client.writeln("HTTP/1.1 404 NOT FOUND");
 client.writeln("Client: close");
 client.writeln("Date: ", client.startTime.toUTCString());
 client.writeln("Expires: ", client.startTime.toUTCString());
 client.writeln("Server: JSDB/"+system.version);
 client.writeln("Content-type: text/html\n");
 client.writeln("<H2>HTTP/1.1 404 Not Found</H2>");
 client.writeln("<br>URL:",client.uri);
 client.writeln("<br><a href=/>Home</a>");
 client.close();
}

HTTPD.prototype.run = function(port)
{
 if (!port) port = 8080
 if (this.http != null) return;

 this.http = null;
 for (; this.http == null && port < 8180; port++)
  {
  try {
   this.http = new Server(port);
   } catch(err)
   {
    writeln('Port ', port,' appears to be in use');
   }
  }

 system.execute('http://127.0.0.1:'+ this.http.port + '/')
 writeln("Server started on port " + this.http.port);

 this.running = true
 while (this.running && !system.kbhit())
 {
   system.gc()
   now = new Date;
   if (!this.http.anyoneWaiting)
    {
     sleep(100);
     continue;
    }

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
   client.page = client.uri.substr(1);
   client.query = ''
   request = client.uri.match(/\/?([^?]*)\?(.*)/);
   if (request != null)
    {
     client.page = request[1];
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

   if (client.page == '')
   {
    try 
    {
     this.sendOK(client);
     this.home(client);
    } 
    catch(err)
    {
     writeln("Error: ",err);
     client.writeln("Error: ",err);
    }
    client.close();
    continue;
   }

   // filter the file names. No URLs, wildcards, or path changes
   if (client.page.search(/(\\|\/|\*)/) != -1)
   {
    client.close()
    continue;
   }

   if (system.exists(client.page))
   {
   writeln(client.page)
     this.sendOK(client);
     var type = client.page.match(/\.(.+)$/)
     writeln(type.toSource())
     if (type) type = this.types[type[1]]
     if (!type) type = "application/x-unknown"

    try
    {
     var src = new Stream(client.page,"rb")
     client.writeln("Content-type: ",type);
     client.writeln("Content-length: ",src.size);
     client.writeln();
     client.append(src);
     src.close()
    }
    catch(err)
    {
     writeln(err)
    }
    client.close();
    continue;
   }
   
   this.sendERROR(client)
   client.close();

 }

 this.http.close();
}

var server = new HTTPD();
server.run();
delete server;
