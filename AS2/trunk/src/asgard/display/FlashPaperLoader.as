/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** FlashPaperLoader

	AUTHOR

		Name : FlashPaperLoader
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-03-31
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	EVENT SUMMARY
	
		FlashPaperLoaderEvent

	EVENT TYPE SUMMARY

		- const COMPLETE:String
		
		- const ENABLE_SCROLL:String
		
		- const FINISH:String
		
		- const INIT:String
		
		- const IO_ERROR:String
		
		- const PAGE_CHANGE:String
		
		- const PROGRESS:String
		
		- const RELEASE:String
				
		- const START:String
		
		- const STOP:String
		
		- const TIMEOUT:String
		
		- const TOOL_CHANGE:String
		
		- const ZOOM_CHANGE:String
		
		- const VISIBLE_AREA_CHANGE:String

	SEE ALSO
	
		FlashPaperTool
		FlashPaperUIElement

*/

// TODO il faut fixer le bug du focus !

import asgard.display.DisplayLoader;
import asgard.events.FlashPaperLoaderEvent;
import asgard.events.FlashPaperLoaderEventType;
import asgard.geom.Point;

/**
 * @author eKameleon
 * @version 1.0.0.0
 * @date 2006-03-31
 */
class asgard.display.FlashPaperLoader extends DisplayLoader {
	
	// ----o Constructor
	
	function FlashPaperLoader( mcTarget:MovieClip, nDepth:Number, bAutoShow:Boolean  ) {
		
		super(mcTarget, nDepth, bAutoShow) ;
	
		_eEnableScroll = new FlashPaperLoaderEvent( FlashPaperLoaderEventType.ENABLE_SCROLL , this ) ;
		
		_ePageChange = new FlashPaperLoaderEvent( FlashPaperLoaderEventType.PAGE_CHANGE , this )  ;
		
		_eToolChange = new FlashPaperLoaderEvent( FlashPaperLoaderEventType.TOOL_CHANGE , this )  ;
		
		_eAreaChange = new FlashPaperLoaderEvent (FlashPaperLoaderEventType.VISIBLE_AREA_CHANGE , this) ;
		
		_eZoomChange = new FlashPaperLoaderEvent (FlashPaperLoaderEventType.ZOOM_CHANGE, this) ;
		
	}
	
	// ----o Public Methods

	/**
	 * Used to prevent the user from scrolling the document.
	 */
	public function enableScrolling(b:Boolean):Void {
		if(_fp) _fp.enableScrolling(b) ;
		_isEnableScrolling = b ;
	}
	
	/**
	 * Searches for the text in the Find text box.
	 * The search begins from the end of the current selection.
	 * To start from the beginning of the document, call setSelectionRange(null) first.
	 * If text is found, the specific range can be found by calling getTextSelectionRange().
	 * @Returns true if text is found, false if not.
	 */
	public function findNext():Boolean {
		return _fp.findNext() ;	
	}

	/**
	 * 	Returns the current page number (as displayed in the toolbar). The first page is page 1.
	 */
	public function getCurrentPage():Number {
		return _fp.getCurrentPage() ;
	}
	
	/**
	 * Returns the currently active tool. If no tool is active, an empty string is returned.
	 *
	 * The following are currently supported values :
	 *	   - "" (no tool)
	 *     - "pan" (hand tool)
	 *     - "select" (text selection tool)
	 */
	public function getCurrentTool():String {
		return _fp.getCurrentTool() ;	
	}
			
	/**
	 * Returns the current zoom level.
	 */
	public function getCurrentZoom():Number {
		return _fp.getCurrentZoom() ;
	}
	
	/**
	 * Returns any text in the Find text box as a Unicode string.
	 */
	public function getFindText():String {
		return _fp.getFindText() ;	
	}

	/**
	 * Returns true if the loaded document is a FlashPaper.
	 */
	public function getIsFlashPaperDocument():Boolean {
		return ( getContent().isFlashPaperDocument() == true ) ;
	}

	/**
	 * Returns the total number of pages loaded
	 */
	public function getLoadedPages():Number {
		return _fp.getLoadedPages ;
	}
			
	/**
	 * Returns the total number of pages in the document.
	 */
	public function getNumberOfPages():Number { 
		return _fp.getNumberOfPages() ;		
	}
	
	/**
	 * Returns the selected text as a Unicode string. If no text is selected, an empty string is returned.
	 */
	public function getSelectedText():String {
		return _fp.getSelectedText() ;
	}

	/**
	 * Returns the width of the sidebar. A document with no outline always returns zero.
	 */
	public function getSidebarWidth():Number {
		return _fp.getSidebarWidth() ;	
	}

	/**
	 * Returns an object describing the current text selection. If no text is selected, this function returns null.
	 */
	public function getTextSelectionRange() {
		return _fp.getTextSelectionRange() ;
	}

	/**
	 * Returns a string describing the type of user interface that is included in the document.
	 * The standard Macromedia FlashPaper viewer always returns the string 'Macromedia FlashPaper Default Viewer'.
	 */
	public function getViewerType():String {
		return _fp.getViewerType() ;	
	}
	
	/**
	 * Returns an integer indicating the version of the user interface code in this particular document.
	 */
	public function getViewerVersion():Number {
		return _fp.getViewerVersion() ;	
	}
	
	/**
	 * Returns an object describing the current visible area of the document.
	 */
	public function getVisibleArea() {
		return _fp.getVisibleArea() ;
	}

	/**
	 * Handles an anchor or URL link request.
	 */
	public function goToLinkTarget(linktarget:String, window ):Void {
		_fp.goToLinkTarget(linktarget, window) ;
	}

	/**
	 * Hide the FlashPaper Official Logo.
	 */
	public function hideLogo():Void {
		_isLogoVisible = false ;
		getContent().toolbar_mc.brandClip_mc._visible = false ;	
	}

	/**
	 * Hide the tool bar's background.
	 */
	public function hideToolBarBackground():Void {
		getContent().toolbar_mc.toolbarBg_mc._visible = false ;
		_isToolBarBackgroundVisible = false ;
	}
	
	/**
	 * Init Event Class use in the loader.
	 */
	public function initEvent():Void {
		_e = new FlashPaperLoaderEvent(null, this) ;	
	}

	/**
	 * Returns true if the official FlashPaper logo is visible.
	 */
	public function isLogoVisible():Boolean {
		return _isLogoVisible ;	
	}
	
	/**
	 * Returns true if the tool bar's background is visible.
	 */
	public function isToolBarBackgroundVisible():Boolean {
		return _isToolBarBackgroundVisible ;	
	}

	/*override*/ public function onLoadInit():Void {

		var c:MovieClip = getContent() ;
		
		var b:Boolean = c.isFlashPaperDocument() ;
		
		_fixSelectionManagement(c) ;
		
		_fp = c.getIFlashPaper() ;
		_fp.addListener(this) ;
		
		_default_h = c._height ;
		_default_w = c._width ;
		
		update() ;
	
		super.onLoadInit() ;
		
	}

	/**
	 * 	Simulates a user clicking the Print button.
	 * 	The document must be fully loaded before you call this function.
	 * 	This function returns false if the document is not fully loaded.
	 */
	public function printTheDocument():Boolean {
		return _fp.printTheDocument() ;	
	}

	public function release():Void {
		_fp = null ;
		super.release() ;	
	}

	/**
	 * Sets the current page. The view scrolls as necessary to ensure the page is visible, but does not adjust zoom.
	 */
	public function setCurrentPage(pageNumber:Number):Void {
		_fp.setCurrentPage(pageNumber) ;
	}
			
	/**
	 * 	Sets the current zoom level.
	 * 	You can pass a number indicating a zoom percentage (for example, 100 for a 100% view).
	 * 	You can also pass the string width to zoom to the current fit-to-width magnification for this document, or pass the string page for the fit-to-page magnification.
	 */
	public function setCurrentZoom(percent:Number):Void {
		_fp.setCurrentZoom(percent) ;	
	}
		
	/**
	 * Makes the given tool the active tool. This function returns false if the argument is invalid or the given tool is disabled.
	 *	The following are currently supported values :
	 *		- "" : no tool.
	 *		- "pan" : hand tool.
	 *		- "select" : text selection tool. 
	 *	@see FlashPaperTool
	 */
	public function setCurrentTool(tool:String):Boolean {
		return _fp.setCurrentTool(tool) ;
	}

	/**
	 * Sets the text in the Find text box to a Unicode string value.
	 * This call does not perform a find operation or alter the current selection.
	 */
	public function setFindText(s:String):Void {
		_fp.setFindText(s) ;	
	}
		
	/**
	 * Sets the width of the sidebar. Pass zero to hide the sidebar completely.
	 * A document with no outline ignores this call.
	 */
	public function setSidebarWidth(w:Number):Void {
		_fp.setSidebarWidth(w) ;
	}

	/**
	 * Sets the display size of the document, in pixels.
	 */
	public function setSize(nW:Number, nH:Number, noRender:Boolean):Void {
		_w = isNaN(nW) ? null : nW ;	
		_h = isNaN(nW) ? null : nH ;
		if (!noRender) update() ;
	}

	/**
	 * Selects the given range of text.
	 * You may pass null to deselect all text.
	 * Invalid ranges are clipped to document ranges 
	 * (this allows you to set a range that begins with zero and ends with a large number,
	 *  such as 999999, to select the entire document).
	 */
	public function setTextSelectionRange( selection /*SelectionRange*/ , skipBroadcast:Boolean):Void {
		_fp.setTextSelectionRange( selection, skipBroadcast ) ;
	}

	/**
	 * Adjusts the currently visible page/zoom/scroll to match the visible area described by the area object.
	 */
	public function setVisibleArea(area, skipBroadcast:Boolean):Void {
		_fp.setVisibleArea(area, skipBroadcast) ;
	}

	/**
	 * The official FlashPaper logo is visible.
	 */
	public function showLogo():Void {
		getContent().toolbar_mc.brandClip_mc._visible = true ;
		_isLogoVisible = true ;
	}

	/**
	 * The Toolbar Background is visible.
	 */
	public function showToolBarBackground():Void {
		getContent().toolbar_mc.toolbarBg_mc._visible = true ;
		_isToolBarBackgroundVisible = true ;
	}
	
	/**
	 * Hides or displays part of the user interface in the FlashPaper document.
	 * The currently supported, case-sensitive values for part are the following :
	 *    - "PrevNext" : The Previous Page and Next Page toolbar buttons are hidden or shown.
	 *    - "Print" The Print toolbar button is hidden or shown.
	 *    - "Tool" All tool selection buttons on the toolbar are hidden or shown.
	 *    - "Zoom" All zoom-related controls on the toolbar are hidden or shown.
	 *    - "Find" All text-search-related controls on the toolbar are hidden or shown.
	 *    - "Pop" The Open Document in New Browser Window toolbar button is hidden or shown.
	 *    - "Sidebar" The sidebar (displaying the document outline) is hidden or shown.
	 *    - "Page" The Current Page and Number of Pages fields in the toolbar are hidden or shown.
	 *    - "Overflow" The Overflow menu on the toolbar is hidden or shown.
	 *    - "ZoomKeys" This value doesn't affect the user interface ;
	 *    	it is used to enable or disable various keys used to zoom in or out of the document (for example, +, -, p, w).
	 */
	public function showUIElement(part:String, flag:Boolean):Void {
		_fp.showUIElement(part, flag) ;
	}
	
	/**
	 * Refresh the view.
	 */
	public function update():Void {
		if (getIsFlashPaperDocument()) {
			var w:Number = isNaN(_w) ? _default_w : _w ; 
			var h:Number = isNaN(_h)? _default_h : _h ;
			enableScrolling(_isEnableScrolling) ;
			_fp.setSize(w, h) ;
			if (!isLogoVisible()) hideLogo() ;
			if (!isToolBarBackgroundVisible()) hideToolBarBackground() ;
		}
	}
	
	// ----o Private Properties

	private var _default_h:Number ;
	private var _default_w:Number ;

	private var _eAreaChange   : FlashPaperLoaderEvent ;
	private var _eEnableScroll : FlashPaperLoaderEvent ; 
	private var _ePageChange   : FlashPaperLoaderEvent ;
	private var _eToolChange   : FlashPaperLoaderEvent ;
	private var _eZoomChange   : FlashPaperLoaderEvent ;
	
	private var _fp /*IFlashPaper*/ = null ; 
	private var _h:Number = null ;
	private var _isEnableScrolling:Boolean = true ;
	private var _isLogoVisible:Boolean = true ;
	private var _isToolBarBackgroundVisible:Boolean = true ;
	private var _w:Number = null ;	
		
	// ----o Private Methods
	
	static private function _fixSelectionManagement(mc:MovieClip):Void {
		var main:MovieClip = mc.gMainView.m_mainMC ;
		if (typeof (main.onMouseDown) == "function" && main.hasSafeSelectionManagement === undefined) {
      		main.onMouseDown = function() {
         		var fpfocus:MovieClip = _global.FPUI.Component.focusedComponent;
         		if (fpfocus != null) {
		            var hitFocused:Boolean = false;
            		if (fpfocus._visible) {
	               		var p:Point = new Point(_root._xmouse, _root._ymouse);
	               		_root.localToGlobal(p) ;
	               		hitFocused = fpfocus.hitTest(p.x, p.y, true);
            		}
            		if (hitFocused == false) {
						// Selection.setFocus(null) ;
						if (typeof (fpfocus.onComponentKillFocus) == "function") {
                  			fpfocus.onComponentKillFocus();
               			}
            		}
         		}
      		} ;
   		}
	}	
	
	private function onPageChanged(newPageNumber:Number):Void {
		_ePageChange.newPageNumber = newPageNumber ;
		dispatchEvent( _ePageChange ) ;
	}

	private function onToolChanged(newTool:String):Void {
		dispatchEvent( _eToolChange ) ;
	}

	private function onEnableScrolling(b:Boolean):Void {
		_eEnableScroll.isEnabledScrolling = b ;
		dispatchEvent( _eEnableScroll ) ;
	}
	
	private function onZoomChanged(percent:Number):Void {
		_eZoomChange.currentZoom = percent ;
		dispatchEvent( _eZoomChange ) ;
	}

	private function onVisibleAreaChanged():Void {
		_eAreaChange.newVisibleArea = _fp.getVisibleArea() ;
		dispatchEvent( _eAreaChange ) ;
	}
	
}