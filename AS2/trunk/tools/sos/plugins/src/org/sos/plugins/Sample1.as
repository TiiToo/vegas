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
 * Sample Plugin for SOS
 */
class org.sos.plugins.Sample1 extends Plugin {
	
	//name of the plugin
	private static var PLUGIN_NAME = "SamplePlugin";
	private static var LOG_NAME = "SamplePlugin Log";
	
	//instance of this plugin
	private static var instance : Sample1;
	
	private static var SAMPLE_COMMAND_1 =
		"<commands>" +
		"<clear/>" +
		"<showMessage>Plugin cleared the Console and send this message.</showMessage>" +
		"</commands>";

	private static var SAMPLE_COMMAND_2 = 
		"<showError>" +
		"<title>Sample Plugin</title>" +
		"<message>Hello World !</message>" +
		"</showError>";

	private static var SAMPLE_COMMAND_3 = 
		"<showDialog>" +
		"	<title>Sample1 Dialog</title>" +
		"	<description>Enter a message and a repeatition.There is also a Password Textfield.</description>" +
		"	<component>" +
		"		<input name='Enter Some Message' param='$message' value='Initial Text' />" +
		"		<comboBox name='Repeatition' param='$repeatition'>" +
		"			<item name='1'/>" +
		"			<item name='10'/>" +
		"			<item name='100'/>" +
		"			<item name='1000'/>" +
		"		</comboBox>" + 
		"		<comboBox name='MessageType' param='$type'>" +
		"			<item name='All Lines in one Message'/>" +
		"			<item name='All Lines in a Fold Message'/>" +
		"			<item name='One Message each Line'/>" +
		"		</comboBox>" + 
		"		<inputPassword name='Some Password' param='$password' value='Initial Pass' />" +
		"	</component>" +
		"	<execute>" +
		"		<sendApp><![CDATA[<feedback message='$message' repeatition='$repeatition' password='$password' type='$type'/>]]></sendApp>" +
		"	</execute>" +
		"</showDialog>"; 
	
	private static var UNLOAD_COMMAND = 
		"<sendApp><![CDATA[<unload/>]]></sendApp>";
	
	//logSocket
	private static var logSocket : LogSocket;
	
	//pluginSocket
	private static var pluginSocket : PluginSocket;
	
	private function Sample1() {
	}

	private function initialize() {
		//create a socket to SOS Plugin port
		pluginSocket = createPluginSocket();
		
		var plugin = this;
		pluginSocket.onXML = function(myXML : XML) {
			plugin.onXML(myXML);
		};
		pluginSocket.appName(PLUGIN_NAME);
		pluginSocket.appColor(0xffdddd);
		pluginSocket.appDescription("This is a simple SOS Plugin");
		pluginSocket.send("<setKey ifNotDef='true'><name>" + PLUGIN_NAME + "</name><color>" + 0xccccff + "</color></setKey>\n");	
		pluginSocket.addCommand(SAMPLE_COMMAND_1, "Sample1Menu", "Sample1Action");
		pluginSocket.addCommand(SAMPLE_COMMAND_2, "Sample1Menu", "Sample2Action");
		pluginSocket.addCommand(SAMPLE_COMMAND_3, "Sample1Menu", "Sample3Action(message feedback)");
		pluginSocket.addCommand(UNLOAD_COMMAND, "Sample1Menu", "Unload");
		pluginSocket.showMessage("Sample Plugin loaded.\nCheck the Menu \"Command\" for the new Entries...\nThis Plugin has the key\"" + PLUGIN_NAME + "\".\nWith this Key you can hide the messages of this Plugin or give it other colors.\nTherefore see ContextMenu - Keys and KeyConfig.\nThe Connectioncolor is overriden by Keycolor.", PLUGIN_NAME);
	}
	
	/*
	 * handles incoming socket messages
	 */
	private function onXML(myXML : XML) {
		var element = myXML.firstChild;
		
		if (element.nodeName == "feedback") {
			var att = element.attributes;
			createFeedback(att.message, new Number(att.repeatition), att.password, att.type);
		}
		
		if (element.nodeName == "unload") {
			unload();
		}
	}
	
	/*
	 * send password and message to sos as a client <br> Called on incoming
	 * <pre> <feedback message='' repeatition='' password='' type=''/> </pre>
	 */
	private function createFeedback(message : String,
			repeatition : Number,
			password : String,
			type : String) : Void {
		
		//lazy constuct logSocket
		if (logSocket == null) {
			logSocket = createLogSocket();
			logSocket.send("!SOS<setKey ifNotDef='true'><name>" + LOG_NAME + "</name><color>" + 0xeeeeff + "</color></setKey>\n");			
		}

		pluginSocket.showMessage("Prepare and show Message over LogPort...", PLUGIN_NAME);
		logSocket.showMessage("Password was:" + password, LOG_NAME);	
		
		switch (type) {
			case "All Lines in one Message":
				
				var messageOut : Array = new Array();
				for (var i = 0; i < repeatition; i++) 
					messageOut.push((i + 1) + ". Message:" + message);			
				logSocket.showMessage(messageOut.join("\n") , LOG_NAME);
				
				break;
				
			case "All Lines in a Fold Message":
				var messageOut : Array = new Array();
				for (var i = 0; i < repeatition; i++) 
					messageOut.push((i + 1) + ". Message:" + message);
				logSocket.send("!SOS<showFoldMessage key=\"" + LOG_NAME + "\"><title>This is the Foldmessage</title><message>" + messageOut.join("\n") + "</message></showFoldMessage>\n");
				
				break;
				
			case "One Message each Line":
				var messageOut : String = "";
				for (var i = 0; i < repeatition; i++)
					logSocket.showMessage(((i + 1) + ". Message:" + message), LOG_NAME);
				
		}
		
	}
	
	/*
	 * Unload this plugin. It is not nessary to unload the SWF. But if you like
	 * u can unloadMovie this SWF. <br> Called on incoming <pre> <unload/>
	 * </pre>
	 */
	private function unload(Void) : Void {
		pluginSocket.showMessage("Bye bye !");
		
		//remove from command menu
		pluginSocket.send('<removeCommand menu="Sample1Menu"/>\n');
		
		//close sockets
		pluginSocket.close();
		logSocket.close();
		
		//make development easier. Allow reload of this plugin with new class
		_global.org.sos.plugins.Sample1 = null;
		
		//delete instance to make sure it can be reinstanced
		delete instance;
	}
	
	/**
	 * starts the plugin
	 */
	public static function main(Void) : Void {
		if (instance == null) {
			instance = new Sample1();
			instance.initialize();
		} else {
			pluginSocket.showMessage("I am already loaded...");
		}
	}
	
}