const express = require("express");
const router = express.Router();
var user = require("../models/team");

// Get all teams
router.get("/getAll", (req, res) => {
    user.getAll(req.query.orderBy).then((result)=>{
        res.json(result);
    });
});

// Get teams filtered by attribute
router.get("/getByAttr", (req, res) => {
    user.getByAttr(req.query.attr, req.query.value, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

module.exports = router;