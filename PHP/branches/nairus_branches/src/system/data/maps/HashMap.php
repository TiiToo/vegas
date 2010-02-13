<?php

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
         SURIAN Nicolas (aka NairuS) <me@nairus.fr>
        
    */

    require_once( realpath( dirname( __FILE__ ) . "/../Map.php" ) ) ;
    require_once( realpath( dirname( __FILE__ ) . "/../Iterator.php" ) ) ;

    /**
     * Hash table based implementation of the Map interface.
     * <p><b>Example :</b></p>
     * <code>
     * $map = new HashMap() ;
     *
     * $map->put("key1", "value1") ;
     * $map->put("key2", "value2") ;
     * $map->put("key3", "value3") ;
     *
     * echo ("map size : " + $map->size() . "<br>" ) ;
     * print_r( $map->getKeys() ) ;
     *
     * echo("<br>") ;
     *
     * print_r( $map->getValues()) ;
     *
     * echo("<br>") ;
     *
     * $map->clear() ;
     *
     * echo ("map size : " + $map->size() . "<br>" ) ;
     * </code>
     * @author eKameleon
     * @author NairuS
     */
    class HashMap implements Map
    {
        
        /**
         * Creates a new HashMap instance.
         */
        public function HashMap() 
        {
            $this->clear() ;
        }
        
        /** 
         * Removes all mappings from this map.
         */
        public function clear()
        {
            $this->_keys   = array() ;
            $this->_values = array() ;
        }
        
        /**
         * Returns a shallow copy of this HashMap instance: the keys and values themselves are not cloned.
         */
        public function copy() 
        {
            $m = new HashMap() ;
            $m = clone $this ;
            return $m ;
        }
        
        /** 
         * Returns 'true' if the map contains the key.
         */
        public function containsKey( $key ) /*Boolean*/
        {
            return $this->indexOfKey( $key ) > -1 ;
        }
        
        /**
         * Returns 'true' if the map contains the value.
         */
        public function containsValue( $value ) /*Boolean*/ 
        {
            return $this->indexOfValue( $value ) > -1 ;
        }
        
        /**
         * Returns the value to which this map maps the specified key.
         */
        public function get( $key ) 
        {
            return $this->_values[ $this->indexOfKey($key) ] ;
        }
        
        public function getKeys() /*Array*/
        {
            return $this->_keys ;
        }
        
        public function getValues() /*Array*/ 
        {
            return $this->_values ;
        }
        
        public function indexOfKey( $key ) /*Number*/
        {
            $l /*Number*/ = count( $this->_keys ) ;
            while ( --$l > -1 ) 
            {
                if ( $this->_keys[$l] == $key ) 
                {
                    return $l ;
                }
            }
            return -1 ;
        }
        
        public function indexOfValue( $value ) /*Number*/
        {
            $l /*Number*/ = count( $this->_values ) ;
            while ( $this->_values[--$l] != $value && $l > -1 ) 
            {
                return $l ;
            }
        }
        
        /**
         * Returns true if this map contains no key-value mappings.
         */
        function isEmpty() /*Boolean*/
        {
            $size = $this->size() ;
            return ( $size < 1 || $size == null ) ;
        }
        
        /*
        function iterator():Iterator 
        {
            return new MapIterator( this ) ;
        }
        */
        
        /*
        function keyIterator():Iterator 
        {
            return new ArrayIterator( $this->_keys ) ;
        }
        */
        
        /**
         * Associates the specified value with the specified key in this map.
         */
        function put( $key, $value ) 
        {
            $r ;
            $i /*Number*/ = $this->indexOfKey( $key ) ;
            if ( $i < 0 ) 
            {
                array_push( $this->_keys   , $key   ) ;
                array_push( $this->_values , $value ) ;
                return null ;
            } 
            else 
            {
                $r = $this->_values[ $i ] ;
                $this->_values[$i] = $value ;
                return $r ;
            }
        }
        
        /**
         * Copies all of the mappings from the specified map to this one.
         */
        function putAll( $m /*Map*/ ) /*void*/
        {
            $aV /*Array*/ = $m.getValues() ;
            $aK /*Array*/ = $m.getKeys() ;
            $l  /*Number*/ = count($aK) ;
            for ( $i /*Number*/ = 0 ; $i < $l ; $i = $i - (-1) ) 
            {
                $this->put( $aK[ $i ], $aV[ $i ] ) ;
            }
        }
    
        function remove( $key ) 
        {
            $r = null ;
            $i /*Number*/ = $this->indexOfKey( $key ) ;
            if ( $i > -1 ) 
            {
                $r = $this->_values[ $i ] ;
                array_splice( $this->_values , $i , 1 ) ;
                array_splice( $this->_keys   , $i , 1 ) ;
            }
            return $r ;
        }
        
        /**
         * Returns the number of key-value mappings in this map.
         */
        function size() /*Number*/
        {
            return count( $this->_keys ) ;
        }
        
        /**
         * The array of keys
         */
        private $_keys /*Array*/ ;
        
        /**
         * The array of values
         */
        private $_values /*Array*/ ;
        
    }
?>