const express = require("express");
const router = express.Router();
var team = require("../models/team");

// Get all teams
router.get("/getAll", (req, res) => {
    team.getAll(req.query.orderBy).then((result)=>{
        res.json(result);
    });
});

// Get teams filtered by attribute
router.get("/getByAttr", (req, res) => {
    team.getByAttr(req.query.attr, req.query.value, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

// Get all users and teams relationship
router.get("/getAllUserTeam", (req, res) => {
    team.getAllUserTeam(req.query.orderBy).then((result) => {
        res.json(result);
    });
});

// Get all teams of a user
router.get("/getTeamsOfUser/:user_id", (req, res) => {
    team.getTeamsOfUser(req.params.user_id, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

// Get all users in a team
router.get("/getUsersInTeam/:team_id", (req, res) => {
    team.getUsersInTeam(req.params.team_id, req.query.orderBy).then((result) => {
        res.json(result);
    }); 
});

module.exports = router;