t = new Table('fixed.ini')
writeln(t.getRow(1))

if (0)
{
writeln(load('library.js'))
writeln(load('xml.js'))
a = new Record('a=b\nc\nd,b=1\n2\n3\n')
s = new Stream
s.writeMIME(a)
s.rewind()
b = s.readMIME()
writeln(b)

writeln("System functions")
writeln(system.getKey("hkey_classes_root/htmlfile"))
writeln(system.getKey("hkey_classes_root/htmlfile/shell/open/command"))
writeln(system.getKey("hkey_local_machine/software/microsoft/windows/currentversion","ProgramFilesDir"))

var tagname="name"
var attr = "id"
var value = 5
var content = 'Fred'
var x = <base><tag {attr}={value}>{content}</tag></base>;

writeln("Inline XML")
writeln(x.toXMLString())

writeln("Fetch a web page")
s = new Stream('http://www.google.com/');
writeln(s.readMIME())
writeln(s.readFile())

writeln("System functions")
writeln(system.getKey("hkey_local_machine/software/microsoft/windows/currentversion","ProgramFilesDir"))

p = new Process('http://www.google.com/')
i=0;
while (p.active)
{
 write(i++,' ')
 sleep(1000)
}

}
