/**
 * ExpressInstall class v0.91 - http://blog.deconcept.com/flashobject/
 * 
 * 08-12-2005 (c) 2005 Geoff Stearns and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Use this class to invoke the Macromedia Flash Player Express Install functionality
 * This file is intended for use with the FlashObject embed script. You can download FlashObject 
 * and this class here: http://blog.deconcept.com/flashobject/
 *
 * Usage: Place this file in your AS2 class path.
 *        on the first frame of your Flash movie, place this line of code:
 *        
 *        ExpressInstall.init() ;
 *        
 *        You should not place any other code on the first frame of your movie, as the first frame
 *        needs to be playable in the Flash player v. 6.0.65.
 *
 */

class asgard.net.ExpressInstall 
{

	// ----o Constructor
	
	public function ExpressInstall() 
	{
		//
	}

	// ----o Public Methods

	static public function getInstance():ExpressInstall 
	{
		if (_instance == null) _instance = new ExpressInstall() ;
		return _instance ;
	}

	static public function init():Boolean 
	{
		// if MMplayerType is not set, the var was not passed in
		// from the FlashObject embed, so the upgrade is not needed
		if (_root.MMplayerType == undefined) return false ;
		ExpressInstall.getInstance()._loadUpdater() ;
		return true ;
	}

	public function loadInit():Void 
	{
      _hold.redirectURL = _root.MMredirectURL ;
      _hold.MMplayerType = _root.MMplayerType ;
      _hold.MMdoctitle = _root.MMdoctitle ;
      _hold.startUpdate() ;
   }

   public function installStatus(statusValue):Void 
   {
		switch(statusValue) {
			
			case "Download.Complete" :
				// Installation is complete. In most cases the browser window that this SWF 
				// is hosted in will be closed by the installer or manually by the end user
				getURL("javascript:window.opener=self;self.close()");
				break ;
			
			case "Download.Cancelled" :
				// The end user chose "NO" when prompted to install the new player
				// by default no User Interface is presented in this case. It is left up to 
				// the developer to provide an alternate experience in this case
				// feel free to change this to whatever you want, js errors are sufficient for this example
				getURL("javascript:alert('This content requires a more recent version of the Macromedia Flash Player.')") ;
				break ;
			
			case "Download.Failed" :
				// The end user failed to download the installer due to a network failure
				// by default no User Interface is presented in this case. It is left up to 
				// the developer to provide an alternate experience in this case
				// feel free to change this to whatever you want, js errors are sufficient for this example
				getURL("javascript:alert('There was an error in downloading the Flash Player update. Please try again later, or visit macrmedia.com to download the latest version of the Flash plugin.')");
				break ;
			
			default :
				
				//
      }
   }

	// ----o Private Properties
   
	private var _updater:MovieClip ;
	private var _hold:MovieClip ;
	private static var _instance:ExpressInstall ;

	// ----o Private Methods
	
	private function _loadUpdater():Void 
	{
      
		System.security.allowDomain("fpdownload.macromedia.com") ;
		
		_updater = _root.createEmptyMovieClip("expressInstallHolder", 10000000);
		
		// register the callback so we know if they cancel or there is an error
		_updater.installStatus = this.installStatus ;
		
		_hold = _updater.createEmptyMovieClip("hold", 1) ;
		
		_updater.onEnterFrame = function() 
		{
			if (typeof ( this.hold.startUpdate ) == 'function') 
			{
				ExpressInstall.getInstance().loadInit() ;
				delete this.onEnterFrame ;
			}
		} ;
		
		var cache:Number = Math.random() ;
		
		_hold.loadMovie("http://fpdownload.macromedia.com/pub/flashplayer/update/current/swf/autoUpdater.swf?" + cache ) ;
	
	}

}