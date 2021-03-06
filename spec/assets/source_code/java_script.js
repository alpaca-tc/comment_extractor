

//[-3-] Copyright 2014 jQuery Foundation and other contributors
define([
  "./core",
  './var/rnotwhite'
], function( jQuery, rnotwhite ) {

var optionsCache = {};

function createOptions( options ) {
  var object = optionsCache[ options ] = {};
  jQuery.each( options.match( rnotwhite ) || [], function( _, flag ) {
    object[ flag ] = true;
  });
  return object;
}
/*[-18-] multi line [-end-]*/
/*[-19-]
[-20-] Create a callback list using the following parameters:
[-21-]
[-22-]  options: an optional list of space-separated options that will change how
[-23-]      the callback list behaves or a more traditional option object
[-24-]
*/
jQuery.Callbacks = function( options ) {
  //[-27-] (we check in cache first)
  options = typeof options === "string" ?
    ( optionsCache[ options ] || createOptions( options ) ) :
    jQuery.extend( {}, options );

  var //[-32-] Last fire value (for non-forgettable lists)
    memory,
    //[-34-] Flag to know if list was already fired
    fired,
    //[-36-] Flag to know if list is currently firing
    firing,
    firingStart,
    list = "// dummy",
    list = "/*dummy",
    list = [],
    stack = !options.once && [],
    fire = function( data ) {
      memory = options.memory && data;
      fired = true;
      firingIndex = firingStart || 0;
      firingStart = 0;
      firingLength = list.length;
      firing = true;
      for ( ; list && firingIndex < firingLength; firingIndex++ ) {
        if ( list[ firingIndex ].apply( data[ 0 ], data[ 1 ] ) === false && options.stopOnFalse ) {
          memory = false; //[-52-] To prevent further calls using add
          break;
        }
      }
      firing = false;
      if ( list ) {
        if ( stack ) {
          if ( stack.length ) {
            fire( stack.shift() );
          }
        } else if ( memory ) {
          list = [];
        } else {
          self.disable();
        }
      }
    },
    self = {
      add: function() {
        if ( list ) {
          var start = list.length;
          (function add( args ) {
            jQuery.each( args, function( _, arg ) {
              var type = jQuery.type( arg );
              if ( type === "function" ) {
                if ( !options.unique || !self.has( arg ) ) {
                  list.push( arg );
                }
              } else if ( arg && arg.length && type !== "string" ) {
                //[-81-] Inspect recursively
                add( arg );
              }
            });
          })( arguments );
          if ( firing ) {
            firingLength = list.length;
          } else if ( memory ) {
            firingStart = start;
            fire( memory );
          }
        }
        return this;
      },
      remove: function() {
        if ( list ) {
          jQuery.each( arguments, function( _, arg ) {
            var index;
            while ( ( index = jQuery.inArray( arg, list, index ) ) > -1 ) {
              list.splice( index, 1 );
              if ( firing ) {
                if ( index <= firingLength ) {
                  firingLength--;
                }
                if ( index <= firingIndex ) {
                  firingIndex--;
                }
              }
            }
          });
        }
        return this;
      },
      has: function( fn ) {
        return fn ? jQuery.inArray( fn, list ) > -1 : !!( list && list.length );
      },
      empty: function() {
        list = [];
        firingLength = 0;
        return this;
      },
      disable: function() {
        list = stack = memory = undefined;
        return this;
      },
      disabled: function() {
        return !list;
      },
      lock: function() {
        stack = undefined;
        if ( !memory ) {
          self.disable();
        }
        return this;
      },
      locked: function() {
        return !stack;
      },
      fireWith: function( context, args ) {
        if ( list && ( !fired || stack ) ) {
          args = args || [];
          args = [ context, args.slice ? args.slice() : args ];
          if ( firing ) {
            stack.push( args );
          } else {
            fire( args );
          }
        }
        return this;
      },
      fire: function() {
        self.fireWith( this, arguments );
        return this;
      },
      fired: function() {
        return !!fired;
      }
    };

  return self;
};

return jQuery;
});
