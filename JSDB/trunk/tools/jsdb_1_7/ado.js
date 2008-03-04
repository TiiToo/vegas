conn = new ActiveX("ADODB.Connection");
conn.Open("DSN=MYSQL"); //edit this line to point to your database
cmd = new ActiveX("ADODB.Command")
cmd.set("ActiveConnection",conn)

jsOptions("warn")
var result;

cmd.set("CommandText","select * from test2")
try {
result = cmd.Execute();
}
catch(x)
{
  writeln(x)
  result = false
}
if (!result)
{//create the database
   writeln("creating a database");
  cmd = new ActiveX("ADODB.Command")
  cmd.set("ActiveConnection",conn)
  cmd.set("CommandText","create table test2 (`name` varchar(32), `phone` varchar(32))");
  cmd.Execute();
  
  cmd = new ActiveX("ADODB.Command")
  cmd.set("ActiveConnection",conn)
  cmd.set("CommandText","insert into test2 (`name`,`phone`) values ('Raosoft','2065254025')")
  cmd.Execute();
  
  cmd = new ActiveX("ADODB.Command")
  cmd.set("ActiveConnection",conn)
  cmd.set("CommandText","insert into test2 (`name`,`phone`) values ('Shanti','6263549919')")
  cmd.Execute();
  for (i=0;i<10;i++)
  {
  cmd = new ActiveX("ADODB.Command")
  cmd.set("ActiveConnection",conn)
  cmd.set("CommandText","insert into test2 (`name`,`phone`) values ('Rao"+i+"','2065254025')")
  cmd.Execute();
  }
  
  for (i=0;i<10;i++)
  {
  cmd = new ActiveX("ADODB.Command")
  cmd.set("ActiveConnection",conn)
  cmd.set("CommandText","insert into test2 (`name`,`phone`) values ('jsdb"+i+"','1234567890')")
  cmd.Execute();
  }

  cmd = new ActiveX("ADODB.Command")
  cmd.set("ActiveConnection",conn)
  cmd.set("CommandText","commit")
  cmd.Execute();
  
  cmd = new ActiveX("ADODB.Command")
  cmd.set("ActiveConnection",conn)
  cmd.set("CommandText","select * from test2")
  result = cmd.Execute(); 
}
   
writeln("Records: ",result.get("RecordCount")); // -1 means "don't know how many"

name = result.get("Fields","name"); //returns ActiveX objects with Name and Value parameters.
phone = result.get("Fields","phone");

writeln(name.get("Name"),"\t",phone.get("Name")); 
writeln(name.get("Value"),"\t",phone.get("Value")); 

writeln(name.get("Value"),"\t",phone.get("Value")); //retrieve values with toString()
result.Move(1) // next

writeln(result.get("Fields","name").get("Value"),"\t",result.get("Fields","phone").get("Value")) //fetch from the Fields collection by name
result.Move(1) // next

writeln(result.get(0,0).get("Value"),"\t",result.get(0,1).get("Value")) //use an array accessor to get field values. get(0,index)
result.Move(1) // next

write(result.GetString(2,1,"\t","\n","(empty)")); // write two records as text

result.Move(2) // forward 2

while (!result.get("EOF"))
{
 writeln(result.get(0,0).get("Value"),"\t",result.get(0,1).get("Value")) //use an array accessor to get field values. get(0,index)
 result.MoveNext(); 
}
