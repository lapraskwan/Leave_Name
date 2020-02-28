var express = require('express');
var app = express();

// To use the environment variables
require('dotenv').config();

/* -------------- Requiring the routes ----------------- */
var userRoute = require("./routes/user");
app.use('/user', userRoute);

var teamRoute = require("./routes/team");
app.use('/team', teamRoute);

var eventRoute = require("./routes/event");
app.use('/event', eventRoute);

/* ----------------------------------------------------- */

app.get('/', function (req, res) {
  res.send('僕は任天堂スイッチのサーバー。\n僕は強い！！！');
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});