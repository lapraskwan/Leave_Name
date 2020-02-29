const express = require("express");
const router = express.Router();
var treat = require("../models/treat");

// Get all treats
router.get("/getAll", (req, res) => {
    treat.getAll(req.query.orderBy).then((result)=>{
        res.json(result);
    });
});

// Get treats filtered by attribute
router.get("/getByAttr", (req, res) => {
    treat.getByAttr(req.query.attr, req.query.value, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

module.exports = router;