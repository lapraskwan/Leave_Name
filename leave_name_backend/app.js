var express = require('express');
var app = express();

require('dotenv').config();

var usersRoute = require("./routes/user");
app.use('/user', usersRoute);

var teamsRoute = require("./routes/team");
app.use('/team', teamsRoute);

var user_teamRoute = require("./routes/user_team");
app.use('/user_team', user_teamRoute);

app.get('/', function (req, res) {
  res.send('僕は任天堂スイッチのサーバー。\n僕は強い！！！');
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});