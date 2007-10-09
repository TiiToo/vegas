
import andromeda.model.SimpleValueObject;

import vegas.util.ConstructorUtil;

/**
 * This value object contains information sending by a server.
 * @author eKameleon
 */
class andromeda.vo.NetServerInfoVO extends SimpleValueObject 
{
    
    /**
     * Creates a new NetServerInfoVO instance.
     * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored
     */
    public function NetServerInfoVO( init ) 
    {
        super( init );
    }

    /**
     * The code of the error.
     */
    public var code:String = null ;
    
    /**
     * The default description of the error.
     */
    public var description:String = null  ;

    /**
     * The level of this information object.
     */
    public var level:String = null ;  
    
    /**
     *  The line number of the error.
     */
    public var line:Number = null ;
    
    /**
     * The name of the method called.
     */
    public var methodName:String = null  ;
    
    /**
     * The name of the service used.
     */
    public var serviceName:String  = null ;

    /**
     * Register the class to AMF communication.
     */
    public static function register( id:String ):Boolean
    {
        return Object.registerClass( id || "NetServerInfoVO" , NetServerInfoVO ) ;
    }
    
    /**
     * Returns the {@code String} representation of this object.
     * @return the {@code String} representation of this object.
     */
    public function toString():String
    {
        var str:String = "[" + ConstructorUtil.getName(this) ;
        if (code != null && code.length > 0)
        {
            str += " code:" + code ;
        }
        if (level != null && level.length > 0)
        {
            str += " level:" + level;
        }
        if (description != null && description.length > 0)
        {
            str += " description:" + description;
        }
        if ( !isNaN(line) && line.toString().length > 0)
        {
            str += " line:" + line;
        }
        str += "]" ;
        return str ;
    }
    

}