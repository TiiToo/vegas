/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/
package lunas 
{
    import lunas.layouts.Layout;
    
    import flash.display.DisplayObject;
    import flash.geom.Point;
    
    /**
     * This interface defines all method of the Container components.
     */
    public interface IContainer 
    {
        /**
         * Determinates the layout of this container.
         */
        function get layout():Layout ;
        function set layout( layout:Layout ):void ;
        
        /**
         * Indicates the number of children of this object.
         */
        function get numChildren():int;
        
        /**
         * Adds a child DisplayObject instance to this DisplayObjectContainer instance. 
         * The child is added to the front (top) of all other children in this DisplayObjectContainer instance. 
         * (To add a child to a specific index position, use the addChildAt() method.)
         * If you add a child object that already has a different display object container as a parent, 
         * the object is removed from the child list of the other display object container.
         * @param child The DisplayObject instance to add as a child of this DisplayObjectContainer instance.
         * @throws ArgumentError Throws if the child is the same as the parent. Also throws if the caller is a child (or grandchild etc.) of the child being added.
         * @return The DisplayObject instance that you pass in the child parameter.  
         */
        function addChild( child:DisplayObject):DisplayObject;
        
        /**
         * Adds a child DisplayObject instance to this DisplayObjectContainer instance. The child is added at the index position specified. 
         * An index of 0 represents the back (bottom) of the display list for this DisplayObjectContainer object. 
         * @param child The DisplayObject instance to add as a child of this DisplayObjectContainer instance. 
         * @param index The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list. 
         * @throws RangeError Throws if the index position does not exist in the child list.
         * @throws ArgumentError Throws if the child is the same as the parent. Also throws if the caller is a child (or grandchild etc.) of the child being added.
         * @return The DisplayObject instance that you pass in the child parameter. 
         */
        function addChildAt( child:DisplayObject, index:int ):DisplayObject;
        
        /**
         * Indicates whether the security restrictions would cause any display objects to be omitted from the list returned by calling the DisplayObjectContainer.getObjectsUnderPoint() method with the specified point point. By default, content from one domain cannot access objects from another domain unless they are permitted to do so with a call to the Security.allowDomain() method.
         * @param point The point under which to look.
         * @return true if the point contains child display objects with security restrictions. 
         */
        function areInaccessibleObjectsUnderPoint( point:Point ):Boolean;
        
        /**
         * Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself. 
         * The search includes the entire display list including this DisplayObjectContainer instance. 
         * Grandchildren, great-grandchildren, and so on each return true.
         * @param child The child object to test.
         * @return true if the child object is a child of the DisplayObjectContainer or the container itself; otherwise false. 
         */
        function contains( child:DisplayObject ):Boolean ;
        
        /**
         * Returns <code class="prettyprint">true</code> if a child exist in the display list at the specified index value.
         * @return <code class="prettyprint">true</code> if a child exist in the display list at the specified index value.
         */
        function containsAt( index:int ):Boolean ; 
        
        /**
         * Returns the child display object instance that exists at the specified index.
         * @param index The index position of the child object.  
         * @return The child display object at the specified index position.
         * @throws RangeError Throws if the index does not exist in the child list.
         * @throws SecurityError This child display object belongs to a sandbox to which you do not have access. You can avoid this situation by having the child movie call Security.allowDomain().
         * @see getChildByName() 
         */
        function getChildAt(index : int) : DisplayObject;
        
        /**
         * Returns the child display object that exists with the specified name. 
         * If more that one child display object has the specified name, the method returns the first object in the child list.
         * @param name The name of the child to return. 
         * @throws SecurityError This child display object belongs to a sandbox to which you do not have access. You can avoid this situation by having the child movie call the Security.allowDomain() method. 
         * @return The child display object with the specified name. 
         */
        function getChildByName( name:String ):DisplayObject ;
        
        /**
         * Returns the index position of a child DisplayObject instance.
         * @param child The DisplayObject instance to identify.
         * @return The index position of the child display object to identify.
         */
        function getChildIndex( child:DisplayObject ):int ;
        
        /**
         * Returns an array of objects that lie under the specified point and are children (or grandchildren, and so on) of this DisplayObjectContainer instance. 
         * Any child objects that are inaccessible for security reasons are omitted from the returned array. 
         * To determine whether this security restriction affects the returned array, call the areInaccessibleObjectsUnderPoint() method.
         * @param The point under which to look.
         * @return An array of objects that lie under the specified point and are children (or grandchildren, and so on) of this DisplayObjectContainer instance. 
         */
        function getObjectsUnderPoint( point:Point ):Array ;
        
        /**
         * Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance. 
         * The parent property of the removed child is set to null , and the object is garbage collected if no other references to the child exist. 
         * The index positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
         * @param child The DisplayObject instance to remove.
         * @throws ArgumentError Throws if the child parameter is not a child of this object.
         * @return The DisplayObject instance that you pass in the child parameter.
         */
        function removeChild( child:DisplayObject ):DisplayObject ;
        
        /**
         * Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer. 
         * The parent property of the removed child is set to null, and the object is garbage collected if no other references to the child exist. 
         * The index positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
         * @param index The child index of the DisplayObject to remove.
         * @throws RangeError Throws if the index does not exist in the child list.
         * @throws SecurityError This child display object belongs to a sandbox to which the calling object does not have access. 
         * You can avoid this situation by having the child movie call the Security.allowDomain() method.          
         * @return The DisplayObject instance that was removed.
         */
        function removeChildAt(index : int) : DisplayObject;
        
        /**
         * Removes all childs in the model defined for the first item by the specified index value, 
         * this method remove the first and the <code class="prettyprint">size - 1</code> items.
         * @throws RangeError if the index value is out of the bounds of the container elements.
         */
        function removeChildsAt( index:int, size:Number ):Array ; 
        
        /**
         * Removes a range of childs in the container.
         * @return the array representation of all removed items.
         * @throws RangeError if the index value is out of the bounds of the container elements.
         */
        function removeRange( from:int , to:int ):Array ;
        
        /**
         * Changes the position of an existing child in the display object container. 
         * This affects the layering of child objects.
         * @param child The child DisplayObject instance for which you want to change the index number. 
         * @param index The resulting index number for the child display object. 
         * @throws RangeError Throws if the index does not exist in the child list. 
         * @throws ArgumentError Throws if the child parameter is not a child of this object.
         */
        function setChildIndex(child : DisplayObject, index : int) : void;
        
        /**
         * Swaps the z-order (front-to-back order) of the two specified child objects. 
         * All other child objects in the display object container remain in the same index positions.
         * @param child1 The first child object. 
         * @param child2 The second child object. 
         * @throws ArgumentError Throws if either child parameter is not a child of this object.
         */
        function swapChildren(child1 : DisplayObject, child2 : DisplayObject) : void;
        
        /**
         * Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list. 
         * All other child objects in the display object container remain in the same index positions.
         * @param index1 The index position of the first child object.
         * @param index2 The index position of the second child object.
         * @throws RangeError — If either index does not exist in the child list.
         */
        function swapChildrenAt(index1 : int, index2 : int) : void;
    }
}
