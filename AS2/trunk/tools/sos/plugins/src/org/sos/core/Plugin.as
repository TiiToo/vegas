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

import org.sos.core.LogSocket;
import org.sos.core.PluginSocket;

/**
 * superclass for plugins
 * 
 * @author Nico Zimmermann nz@powerflasher.de
 * @version $Id$
 */
class org.sos.core.Plugin {
	
	public static var fSockets : Array = new Array();
	
	/**
	 * Creates a LogSocket and connects
	 * 
	 * @return Instance of LogSocket
	 */
	public function createLogSocket(Void) : LogSocket {
		var socket : LogSocket = new LogSocket();
		socket.connect();
		fSockets.push(socket);
		return socket;
	}

	/**
	 * creates a PluginSocket and connects
	 * 
	 * @return Instance of PluginSocket
	 */
	public function createPluginSocket(Void) : PluginSocket {
		var socket : PluginSocket = new PluginSocket();
		socket.connect();
		fSockets.push(socket);
		return socket;
	}
		
}