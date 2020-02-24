const express = require("express");
const router = express.Router();
var user = require("../models/user_team");

// Get all teams
router.get("/getAll", (req, res) => {
    user.getAll(req.query.orderBy).then((result)=>{
        res.json(result);
    });
});

// Get teams of a user
router.get("/getTeamsOfUser/:user_id", (req, res) => {
    user.getTeamsOfUser(req.params.user_id, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

// Get users in a team
router.get("/getUsersInTeam/:team_id", (req, res) => {
    user.getUsersInTeam(req.params.team_id, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

module.exports = router;