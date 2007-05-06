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

import org.sos.core.SOSUtil;

/**
 * This class provides environment settings of SOS.
 * 
 * @author Nico Zimmermann nz@powerflasher.de
 * @version $Id$
 */
class org.sos.core.Env {
	
	/**
	 * @return currently used plugin port of SOS
	 */
	public static function getPluginPort(Void) : Number {
		return SOSUtil.getPluginPort();
	}

	/**
	 * @return currently used log port of SOS
	 */
	public static function getLogPort(Void) : Number {
		return SOSUtil.getLogPort();
	}
	
}