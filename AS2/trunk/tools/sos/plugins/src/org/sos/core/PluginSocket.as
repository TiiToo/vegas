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
import org.sos.core.AbstractSocket;

/**
 * XMLSocket extension for SOS PluginClients
 * 
 * @author Nico Zimmermann nz@powerflasher.de
 * @version $Id$
 */
class org.sos.core.PluginSocket extends AbstractSocket {

	/**
	 * Connects to SOS Logport. <br>
	 * The Sockethost is 'localhost', the port ist set by Env.getPluginPort
	 * overrides XMLSocket
	 * 
	 * @see org.sos.core.Env
	 */
	public function connect(Void) : Void {
		super.connect("localhost", Env.getPluginPort());
	}
	
	/**
	 * overrides AbstractSocket
	 */
	public function sendCommand(command : String) : Void {
		send(command);
	}
	
}