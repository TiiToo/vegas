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

/**
 * IMPORTANT ! While running this Plugin in SOS and not from the Flash IDE this
 * Class will never be used. The SOSUtil Class from the SOSUtil.exe will provide
 * the real currently used SOS ports while running in SOS Enviroment.
 */
class org.sos.core.SOSUtil {
	
	private static var pluginPort : Number = 4445;
	private static var logPort : Number = 4444;
	
	/**
	 * @return SOS PluginPort or static pluginPort if running without SOS
	 */
	public static function getPluginPort(Void) : Number {
		return pluginPort;
	}
	
	/**
	 * @return SOS LogPort or static logPort if running without SOS
	 */
	public static function getLogPort(Void) : Number {
		return logPort;
	}
}