/*
 * Copyright (C) 2004 Powerflasher GmbH. This program is free software; you can
 * redistribute it and/or modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version. This program is distributed
 * in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even
 * the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details. You should have received
 * a copy of the GNU General Public License along with this program; if not,
 * write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA 02111-1307, USA. Email to Powerflasher SOS :sos@powerflasher.de
 */
import org.sos.core.Plugin;
import org.sos.core.LogSocket;
import org.sos.core.PluginSocket;

/**
 * FCAdmin Plugin for SOS
 * 
 * @author Nico Zimmermann nz@powerflasher.de
 * @author Martin Fleck mf@powerflasher.de
 */
class org.sos.plugins.FCAdmin extends Plugin {
	
	//name of the plugin
	private static var PLUGIN_NAME : String = "FCAdmin";
	
	//instance of this plugin
	private static var instance : FCAdmin;
	
	private static var UNLOAD_COMMAND : String = "<sendApp><![CDATA[<unload/>]]></sendApp>";
	
	//logSocket
	private static var logSocket : LogSocket;
	
	//pluginSocket
	private static var pluginSocket : PluginSocket;
	
	//fc connection
	private static var connection : NetConnection;

	//netStream
	private static var stream;
	
	//name of the fc instance
	private var FCinst : String;
	
	private function FCAdmin() {
	}

	/*
	 * send the login form to sos <br> grap userdata from LSO
	 */
	private function sendLoginForm() {
		
		//get LSO Data
		var data : Object = SharedObject.getLocal ("FCAdmin").data;
		var host : String = data.host == null ? "" : data.host;
		var port : String = data.port == null ? "" : data.port;
		var username : String = data.username == null ? "" : data.username;
		var password : String = data.password == null ? "" : data.password;
		
		//send login form
		pluginSocket.send("" +
			"<showDialog>" +
			"	<title>FCAdmin - Login</title>" +
			"	<description>Please enter your Server and Login.</description>" +
			"	<component>" +
			"		<input name='Host' param='$host' value='"+host+"' />" +
			"		<input name='Port' param='$port' value='"+port+"' />" +
			"		<input name='Username' param='$username' value='"+username+"' />" +
			"		<inputPassword name='Password' param='$password' value='"+password+"' />" +
			"	</component>" +
			"	<execute>" +
			"		<sendApp><![CDATA[<login host='$host' port='$port' username='$username' password='$password'/>]]></sendApp>" +
			"	</execute>" +
			"</showDialog>\n");
	};
	
	/*
	 * create connection to FC and SOS LogPort
	 */
	private function createAdminConnection (host, port, username, password) {

		connection = new NetConnection();		
		if (host.indexOf (".") >= 0) {
			var connectHost = "rtmp://" + host;
		} else {
			var connectHost = "rtmp:/" + host;
		}
		connection.connect (connectHost + ":" + port + "/admin", username, password);
		
		var plugin : FCAdmin = this;
		connection.onStatus = function (info) {
			if (info.code == "NetConnection.Connect.Success") {
				plugin.onConnectFC();
			} else {
				FCAdmin.pluginSocket.send('<removeCommand menu="FCAdmin" item="Select new Instance"/>\n');
				FCAdmin.pluginSocket.send('<removeCommand menu="FCAdmin" item="Restart Instance"/>\n');
				plugin.sendError ("FCAdmin", info.code);
			}
		};
	};	

	public function sendError(title : String, message : String) {
		pluginSocket.send("<showError><title>" + title + "</title><message>" + message + "</message></showError>\n");
	}
	
	public function onConnectFC() {
		refreshAndSendInstances();
	}
	
	private function refreshAndSendInstances() {
		pluginSocket.send('<addCommand menu="FCAdmin" item="Select new Instance" mask="0" key="118"><sendApp><![CDATA[<reselectInstance />]]></sendApp></addCommand>\n');
		
		var reply = new Object();
		reply.parent = this;
		reply.onResult = function (instances) {
			var items = "";
			for (var i = 0; i<instances.data.length;i++) {
				items+='<item name="'+instances.data[i]+'"/>';
			};
			FCAdmin.pluginSocket.send('<showDialog><title>FCAdmin - Select Instance</title><description>Please select a FlashCom Instance</description><component><comboBox name="Instance" param="$inst">'+items+'</comboBox></component><execute><sendApp name="FCAdmin"><![CDATA[<selectInstance inst="$inst"/>]]></sendApp></execute></showDialog>\n');
			
		};
		connection.call ("getActiveInstances", reply);
	};	
	
	/*
	 * incoming <pre> <reselectInstance inst="name"/> </pre>
	 */
	private function selectInstance(args) {
		pluginSocket.send('<addCommand menu="FCAdmin" item="Restart Instance" mask="0" key="119"><sendApp><![CDATA[<restartInstance/>]]></sendApp></addCommand>\n');
		
		FCinst = args.inst;
		stream = new NetStream (connection);
		
		if (logSocket == null) {
			logSocket = createLogSocket();
			logSocket.appName("FCAdmin Log");
			logSocket.appDescription("FCAdmin Log");
			logSocket.send("!SOS<setKey ifNotDef='true'><name>FCAdmin Log</name><color>" + 0xeeeeff + "</color></setKey>\n");
		}
		
		stream.onLog = function (info) {
			//FCAdmin.logSocket.send(info.description+"\n");
			FCAdmin.logSocket.showMessage("<![CDATA["+info.description+"]]>","FCAdmin Log");
		};
		stream.play ("logs/application/" +FCinst, -1);
		pluginSocket.showMessage("Play Logs from Instance: " + FCinst, PLUGIN_NAME);	
	};	
	
	/*
	 * incoming <pre> <reselectInstance /> </pre>
	 */
	private function reselectInstance() {
		refreshAndSendInstances();	
	};
	
	/*
	 * incoming <pre> <restartInstance /> </pre>
	 */
	private function restartInstance() {
		pluginSocket.showMessage("Restart Instance: " + FCinst, PLUGIN_NAME);
		connection.call("reloadApp", null, FCinst);
	}
	
	/*
	 * incoming login <pre> <login host="111" port="222" username="333"
	 * password="444"/> </pre>
	 */
	private function login(args) {
		pluginSocket.send("<showFoldMessage key='FCAdmin'><title>Login...</title><message>" +
				"Host:     " + args.host +
				"\nPort:     " + args.port +
				"\nUsername: " + args.username +
				"</message></showFoldMessage>\n");	
		
		var data = SharedObject.getLocal ("FCAdmin").data;
		data.host = args.host;
		data.port = args.port;
		data.username = args.username;
		data.password = args.password;
		createAdminConnection(args.host, args.port, args.username, args.password);
	};
	
	/*
	 * incoming relogin <pre> <relogin/> </pre>
	 */
	private function relogin() {
		sendLoginForm();
	}
	/*
	 * incomming unload <pre> <unload/> </pre>
	 */
	private function unload(Void) : Void {
		pluginSocket.showMessage("Bye bye !", PLUGIN_NAME);
		
		//remove from command menu
		pluginSocket.send('<removeCommand menu="FCAdmin"/>\n');
		
		//close connections
		pluginSocket.close();
		logSocket.close();
		connection.close();
		stream.close();

		//make development easier ...
		_global.org.sos.plugins.FCAdmin = null;
		
		//delete instance to make sure it can be reinstanced
		delete instance;
	}
	
	private function initialize() {
		pluginSocket = createPluginSocket();
		
		var plugin = this;
		pluginSocket.onXML = function (mXML : XML) {
			var nodeName = mXML.firstChild.nodeName;
			plugin[nodeName](mXML.firstChild.attributes);
		};
		
		pluginSocket.appName(PLUGIN_NAME);
		pluginSocket.appDescription("FCAdmin V1.2");
		pluginSocket.send("<setKey ifNotDef='true'><name>" + PLUGIN_NAME + "</name><color>" + 0xffeeee + "</color></setKey>\n");	
		pluginSocket.addCommand("<sendApp><![CDATA[<relogin />]]></sendApp>", PLUGIN_NAME, "Login", 0, 116);	
		pluginSocket.addCommand("<sendApp><![CDATA[<unload />]]></sendApp>", PLUGIN_NAME, "Unload");
		pluginSocket.showMessage("FCAdmin loaded...", PLUGIN_NAME);
		//sendLoginForm();
	}
	
	/**
	 * starts the plugin
	 */
	public static function main(Void) : Void {
		if (instance == null) {
			instance = new FCAdmin();
			instance.initialize();
		} else {
			pluginSocket.showMessage("FCAdmin already loaded...", PLUGIN_NAME);
		}
	}
	
}