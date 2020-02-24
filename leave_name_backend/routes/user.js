const express = require("express");
const router = express.Router();
var user = require("../models/user");

// Get all users
router.get("/getAll", (req, res) => {
    user.getAll(req.query.orderBy).then((result)=>{
        res.json(result);
    });
});

// Get users filtered by attributes
router.get("/getByAttr", (req, res) => {
    user.getByAttr(req.query.attr, req.query.value, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

module.exports = router;