// Generated from JASS.g4 by ANTLR 4.7
// jshint ignore: start
var antlr4 = require('antlr4/index'),
    JASSLexer = require('../antlr/JASSLexer'),
    JASSParser = require('../antlr/JASSParser'),
    JASSListener = require('../antlr/JASSListener').JASSListener;

// This class defines a complete listener for a parse tree produced by JASSParser.
function MergeListener(output) {
    this.output = output;
	antlr4.tree.ParseTreeListener.call(this);
	return this;
}

MergeListener.prototype = Object.create(JASSListener.prototype);
MergeListener.prototype.constructor = JASSListener;

// Listeners
MergeListener.prototype.enterGlobalBlock = function(ctx) {
    console.log('Global', ctx.getText());
    this.output.globals.push(ctx.getText());
}

MergeListener.prototype.enterFn = function(ctx) {
    console.log('Function');
    this.output.functions.push(ctx.getText());
}

exports.MergeListener = MergeListener;