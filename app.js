require('coffee-script');
require('coffee-script/register');

var debug = require('debug')('www');
var app = require('./app.coffee');

var port = app.get('port');
if (typeof port === "undefined" || port === null) {
   app.set('port', process.env.PORT || 3000);
}

var server = app.listen(app.get('port'), function() {
  debug('Express server listening on port ' + server.address().port);
});
