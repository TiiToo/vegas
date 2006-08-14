package asgard.process
{
	
	import vegas.core.ICloneable;
	import vegas.core.IRunnable;

	public interface IAction extends ICloneable, IRunnable
	{
		
		function notifyFinished():void ;
	
		function notifyStarted():void ;
		
	}
	
}