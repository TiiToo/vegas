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

import org.sos.core.Env;

/**
 * Abstact XMLSocket extension for SOS <br>
 * Not all commands of SOS are supported here! <br>
 * Methode sendCommand is implemented by LogSocket and PluginSocket <br>
 * 
 * @author Nico Zimmermann nz@powerflasher.de
 * @version $Id$
 */
class org.sos.core.AbstractSocket extends XMLSocket {
	
	/**
	 * terminator for each message
	 */
	public static var TERMINATOR : String = "\n";
		
	/**
	 * sets the name for this connection
	 * 
	 * @param name
	 *            Name of the connection
	 */
	public function appName(name : String) : Void {
		sendCommand("<appName>" + name + "</appName>" + TERMINATOR);
	}

	/**
	 * sets the color for this connection
	 * 
	 * @param name
	 *            Displayed Color of the connection
	 */
	public function appColor(colorInt : Number) : Void {
		sendCommand("<appColor>" + colorInt + "</appColor>" + TERMINATOR);
	}
	
	/**
	 * sets the description for this connection <br>
	 * The description is no functional element of SOS. It may provide some
	 * information about the plugin or log connection.
	 * 
	 * @param name
	 *            Description
	 */
	public function appDescription(description : String) : Void {
		sendCommand("<appDescription>" + description + "</appDescription>" + TERMINATOR);
	}
		
	/**
	 * debug feature or simply nice <br>
	 * let SOS confirm this connection in the SOS Console
	 */
	public function identify(Void) : Void {
		sendCommand("<identify/>" + TERMINATOR);
	}
	
	/**
	 * Adds a menu to the SOS command Menu
	 * 
	 * @param command
	 *            Command to be executed
	 * @param menuName
	 *            <i>optional: </i> Name of the Menu <br>
	 *            This is optional. If Menuname is null, the Item will be placed
	 *            in the Root of the Command-Menu
	 * @param itemName
	 *            Name of the Menuitem
	 * @param keyMask
	 *            <i>optional: </i> keyMask for shortkey <br>
	 *            Please refer Java Help
	 * @param key
	 *            <i>optional: </i> Short key for this Menuitem <br>
	 *            Please refer Java Help
	 */
	public function addCommand(command : String, menuName : String, itemName : String, keyMask : Number, key : Number) : Void {
		if (menuName == null)
			menuName = "root";
		if (key == null) {
			sendCommand('<addCommand menu="' + menuName + '" item="' + itemName + '">' + command + '</addCommand>' + TERMINATOR);
		} else {
			if (keyMask == null) {
				keyMask = 0;
			}
			sendCommand('<addCommand menu="' + menuName + '" item="' + itemName + '" mask="' + keyMask + '" key="' + key + '">' + command + '</addCommand>' + TERMINATOR);
		}
	}
	
	/**
	 * Simply show a message in the console
	 * 
	 * @param message
	 *            The message to be send
	 * @param key
	 *            The key used to display the message
	 */
	public function showMessage(message : String, key : String) : Void {
		if (key == null)
			sendCommand('<showMessage>' + message + '</showMessage>' + TERMINATOR);
		else
			sendCommand('<showMessage key="' + key + '">' + message + '</showMessage>' + TERMINATOR);
	}
	
	/**
	 * needs to be implemented by child class
	 * 
	 * @param command
	 *            Command to send to SOS
	 */
	public function sendCommand(command : String) : Void {
	}
}