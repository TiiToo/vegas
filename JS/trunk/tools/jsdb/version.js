a = system.resource('version.txt').readText()
b = new Stream('http://www.jsdb.org/version.txt')
b.readMIME()
b=b.readText()
if (a != b) system.browse('http://www.jsdb.org/update.html')
else writeln('You have the latest version of JSDB.')
