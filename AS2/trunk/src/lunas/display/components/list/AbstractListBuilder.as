/** AbstractBuilder

	AUTHOR
		
		Name : AbstractListBuilder
		Package : lunas.display.components.list
		Version : 1.0.0.0
		Date :  2006-04-19
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		private

	PROPERTY SUMMARY
	
		- target:MovieClip

	METHOD SUMMARY
	
		- clear():Void
		
		- getContainerRenderer():Function
		
			override this method if you want use a specific container Function !
		
		- run():Void
		
			override this method but use super._createContainer !
		
		- toString():String
		
		- update():Void

			override this method but use super._createContainer !

	PROTECTED METHOD SUMMARY
	
		- _createContainer():Void
		
			override this method but use super._createContainer !
		
		- _refreshContainer():Void
		
			override this method.

	INHERIT
	
		CoreObject
			|
			AbstractBuilder
				|
				AbstractListBuilder

**/

import lunas.display.components.AbstractBuilder;
import lunas.display.components.container.ListContainer;

/**
 * AbstractListBuilder
 * @author eKameleon
 * @version 1.0.0.0
 * @date 2006-04-19
 */
class lunas.display.components.list.AbstractListBuilder extends AbstractBuilder {
	
	// ----o Constructor
	
	private function AbstractListBuilder(mc : MovieClip) {
		super(mc) ;
	}
	
	// ----o Public Properties

	public var container:MovieClip ;
	
	// ----o Public Methods
	
	public function clear():Void {
		container.clear() ;
		container.removeMovieClip() ;
	}

	public function getContainerRenderer():Function {
		return ListContainer ;
	}

	public function run():Void {
		_createContainer() ;
	}
	
	public function update():Void {
		_refreshContainer() ;
	}

	// ----o Private Methods
	
	/*protected*/ private function _createContainer():Void {
		container = target.createChild( getContainerRenderer(), "container", 50) ;
	}

	/*protected*/ private function _refreshContainer():Void {
		// override this protected method
	}

}