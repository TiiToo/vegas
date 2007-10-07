
import andromeda.process.abstract.AbstractActionLoader;

import asgard.config.Config;
import asgard.system.EdenLocalizationLoader;
import asgard.system.Lang;
import asgard.system.Localization;

import vegas.events.Delegate;

/**
 * This control launch the loading of the localization of the current Lang.
 * @author eKameleon
 */
class andromeda.process.application.RunLocalization extends AbstractActionLoader
{
	
	/**
	 * Creates a new RunLocalization instance.
	 * @param prefixName The prefix name of the localization external file (default "locale/").
	 * @param pathName The path name of the localization external file (default "localize_").
	 * @param security The boolean flag to indicates if the eden deserialize is secure or not.
 	 * @param loaderPolicy optional boolean flag to indicates if the loader use the loading view or not (defaut this value is true).
 	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	public function RunLocalization( prefixName:String , pathName:String , security:Boolean , loaderPolicy:Boolean , bGlobal:Boolean, sChannel:String ) 
	{
		
		super( bGlobal , sChannel , loaderPolicy ) ;
		
		if (pathName != null)
		{
			this.pathName = pathName ;
		}

		if (prefixName != null)
		{
			this.prefixName = prefixName ;
		}
		
		if ( security != null )
		{
			this.security = security ;	
		}
		
		var localizer:Localization = Localization.getInstance() ;
		localizer.addEventListener( Localization.CHANGE, new Delegate(this, notifyFinished), false, 1000 ) ;

		localizer.setLoader( new EdenLocalizationLoader() ) ;

		loader = EdenLocalizationLoader(localizer.getLoader()) ;

		registerLoader( loader ) ;
		
	}
	
	/**
	 * The default value of the locale path.
	 */
	public var pathName:String = "locale/" ;
	
	/**
	 * The default value of the locale file prefix ;
	 */
	public var prefixName:String = "localize_" ;
	
	/**
	 * The reference of the EdenLicalizationLoader.
	 */
	public var loader:EdenLocalizationLoader ;

    /**
     * Indicates if use security to load the external config.
     */
    public var security:Boolean = true ;

	/**
	 * Run the process.
	 */
	public function run() 
	{
		
		notifyStarted() ;
		
		var config:Config = getConfig() ;
	
		var currentLang = config.default_lang || Lang.FR ;
		
		getLogger().debug( this + " run process with the current Lang : " + currentLang ) ;
        
        buRRRn.eden.Application._trace = Delegate.create(this , _trace ) ;
        buRRRn.eden.config.security = security ;
        
		loader.prefix = config.localePrefix || prefixName ;
		loader.path   = config.localePath   || pathName   ;
		
		Localization.getInstance().setCurrent( currentLang ) ;
	
	}
	
	/**
	 * Invoqued by the Eden tracer.
	 */
	private function _trace( message:String ):Void
	{
		getLogger().warn( this + " : " + message ) ;
	}

}