/* 
Basic use of the web server

var server = new HTTPD()  //creates a web server instance
server.run(8080,true)     //runs the server on port 8080, and tries to open a browser to view it

Advanced use

var server = new HTTPD()
server.hosts = ['localhost']     //restrict access
server.handlers["jsp"] = execJSP //enable server-parsed JavaScript pages 
                                 //you can add special handlers for other types, too



*/

/* To do: adjust Expires and If-modified-since to return 304 Not Modified */

function HTTPD()
{
 this.http = null;
 this.running = true; //set this.running = false to exit the server
 this.types = {'html': "text/html; charset=utf-8", 
              'htm': "text/html", 
              'png': "image/png", 
              'gif': "image/gif", 
              'jpeg': "image/jpeg", 
              'jpg': "image/jpeg", 
              'txt': "text/plain",
              'css': "text/css",
              'svg': "image/svg+xml",
              'js': "application/x-javascript",
              '*': "application/x-unknown"}
 this.handlers = {}
 this.functions = {}
 this.hosts = ['localhost']
 this.index = ''
 this.forbidden = ['httpd.js']
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
 client.writeln("Expires: ", 0);
 client.writeln("Server: JSDB/"+system.version);
}

HTTPD.prototype.sendERROR = function(client)
{
 client.writeln("HTTP/1.1 404 NOT FOUND");
 client.writeln("Client: close");
 client.writeln("Date: ", client.startTime.toUTCString());
 client.writeln("Expires: ", 0);
 client.writeln("Server: JSDB/"+system.version);
 client.writeln("Content-type: text/html\n");
 client.writeln("<H2>HTTP/1.1 404 Not Found</H2>");
 client.writeln("<br>URL:",client.uri);
 client.writeln("<br><a href=/>Home</a>");
 client.close();
}

HTTPD.prototype.run = function(port, browser)
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

 this.hosts.push(this.http.hostName)
 
 writeln("Server started on " + this.http.hostName + ":" + this.http.port);
 if (browser) 
 {
  system.browse('http://127.0.0.1:'+ this.http.port + '/' + (typeof browser == "string" ? browser : ""))
  writeln("Browser opened");
 }

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
      
   if (this.hosts.length && this.hosts.indexOf(client.name) == -1)
   {
    if (this.debug) writeln('Rejected ',client.name)
    client.close()
    continue;
   }
   if (this.debug) writeln('Connected ',client.name)
   
   var request = client.readLine().split(/\s+/);
   if (this.debug) writeln(request)

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
   client.page = decodeURI(client.uri.substr(1));
   client.query = ''
   request = client.uri.match(/\/?([^?]*)\?(.*)/);
   if (request != null)
    {
     client.page = request[1];
     client.query = request[2];
    }

   let rawData = null
   client.data = {}
   if (client.method == "GET" && client.query)
    rawData = client.query
   else if (client.method = "POST" && client.header.get('Content-type').replace(/;.*/,'')  == 'application/x-www-form-urlencoded')
    rawData = client.read(client.header.get('Content-length'))

   if (rawData)
   {
    let source = rawData.split(/\&/g)
    for (let x=0; x< source.length; x++)
    {
     let [name,value] = source[x].split('=')
     client.data[decodeURL(name)] = value ? decodeURL(value) : ""
    }
   }
   
   if (client.page == '' && system.exists(this.index))
   {
     client.page = this.index
   }


   if (client.page == 'quit')
   {
     this.running = false;
     client.page = ''
     this.sendOK(client);
     client.writeln("Content-type: text/html")
     client.writeln()
     client.close()
     continue
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

   if (this.functions[client.page]) //special function handler
   {      
      var handler = this.functions[client.page]
      if (this.debug) writeln('executing ',handler.name,' for ',client.page)
      this.sendOK(client);      
      let done = handler(client,client.data)
      
      if (typeof done == "string")
      {
        client.page = done;
      }
      else
      {
        client.close();
        continue;
      }
   }

   if (system.exists(client.page))
   {
     let page = client.page
     //leaves room for a redirection table later
     if (this.debug) writeln(client.name,'\t',page,'\t',client.query,'\t',new Date())
     if (this.debug) writeln(client.header)
     if (this.forbidden.indexOf(client.page) != -1)
       this.sendERROR(client) //forbidded file
       
     var type = page.match(/\.(.+)$/)

     var handler = this.handlers[type[1]]
     if (handler)
     {
      this.sendOK(client);
      if (this.debug) writeln('executing ',handler.name,' for ',client.page)
      handler(this,client,page);
      client.close();
      continue;
     }
     
     if (type) type = this.types[type[1].toLowerCase()]
     if (!type) type = this.types['*']
     
     if (!type)
     {
      this.sendERROR(client) //forbidded file type
      writeln("Unknown MIME type for ",page)
      continue;
     }

     this.sendOK(client);
     
     try
     {
      var src = new Stream("file://" + page,"rb")
      client.writeln("Content-type: ",type);
      client.writeln("Content-length: ",src.size);
      client.writeln();
      client.append(src);
      src.close();
     }
     catch(err)
     {
      writeln(err);
     }
     client.close();
     continue
   }
   writeln("Can't find ",client.page)
   this.sendERROR(client)
   client.close();
 }

 this.http.close();
}

HTTPD.oldprint = print
HTTPD.oldprintln = println

function execJSP(httpd, client, page)
{
if (httpd.debug) 
{
 writeln(page,': ',client.data.toSource())
}
try
 {  
  function include(page) {execJSP(httpd,client,page);}
  print = function () {client.write.apply(client,arguments);}
  println = function () {client.writeln.apply(client,arguments);}
  httpData = function() {return [client.data, 
      {cookie: client.header['Cookie'], hostName: client.name}];}

  var src  = new Stream("file://" +page,'rt')
 
  if (src.read(2) == "#!")
   src.readLine()
  else
   src.rewind()
  client.writeln("Content-type: text/html")
  client.writeln()  
  
  var text = new Stream
  
  var block = 1
  while (!src.eof)
  { 
    src.readUntil("<%",client)
    if (src.eof) break
    text.clear()
    text.write('var [data, cookie, hostName] = httpData(); ')
    src.readUntil("%>",text)
    text.rewind()
    try 
    {
     run(text,page + ":" + (block++))
    }
    catch(x) 
    {
     writeln('Error in ',x.fileName,':',x.lineNumber,' ',x.message)
     throw(x)
    }
  }
  print = HTTPD.oldprint
  println = HTTPD.oldprintln
  src.close()
 }
 catch(err)
 {
   httpd.sendERROR(client)
   writeln("Error: ",err);
   client.writeln("<h1>Error</h1><pre>");
   for (var i in err) client.writeln(i,':',err[i])
   client.writeln("</pre>")
 }
 system.gc()
}

function execCGI(httpd, client, page)
{
    var data = client.data
    if (httpd.debug) writeln(page,' ',data.toSource())
    var cgi = null
    try 
    {
      var cgi;
      if (system.exists('jsdb.exe')) cgi = new Stream('exec://jsdb.exe ' + page);  
      else if (system.exists('jsdb')) cgi = new Stream('exec://./jsdb ' + page);  
      else cgi = new Stream('exec://jsdb ' + page);  

      cgi.writeln(data.toSource())
      if (httpd.debug)
      {
       var result = cgi.readFile()
       write(result)
       client.write(result)
      }
      else
       client.append(cgi)
      if (httpd.debug) writeln('exited')
    } 
    catch(err)
    {
     writeln("Error: ",err);
     client.writeln("Error: ",err);     
    } 
    if (cgi) cgi.close()
}

