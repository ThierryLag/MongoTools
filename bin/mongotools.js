#!/usr/bin/env node

/*
 * MongoTools
 *
 * Copyright (c) 2014 Thierry 'Akarun' Lagasse for KRKN
 * Unlicensed.
*/

"use strict";

var settings = require( '../package.json' ).mongotools;
var program = require( 'commander' );

program
    .version( settings.version )
    .option( '-i, --input [path]', 'Import datas from this folder.', './' )
    .option( '-o, --output [path]', 'Output folder where export datas.', './' )
    .option( '-d, --db [connection]', 'DB connexion parameters.', '' )
    .parse( process.argv );

// ----------------------------------------------------------------------------

if ( !program.args.length ) {
    program.help();
}

// ----------------------------------------------------------------------------

var performedActions = 0;
for ( var i=0; i < program.args.length; i++ ) {
    var action = program.args[i].toLowerCase()

    switch( action )
    {
        case "export":
            console.log( 'Export to "%s"', program.output );
            performedActions++;
            break;

        case "import":
            console.log( 'Import from "%s"', program.input );
            performedActions++;
            break;

        case "clear":
            console.log( 'Clear documents' );
            performedActions++;
            break;
    }
}
console.log( "Finish %d actions from %s", performedActions, process.cwd() );