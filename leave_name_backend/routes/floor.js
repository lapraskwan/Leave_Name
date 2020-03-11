const express = require("express");
const router = express.Router();
var floor = require("../models/floor");

// Get all floors
router.get("/getAll", (req, res) => {
    floor.getAll(req.query.orderBy).then((result)=>{
        res.json(result);
    });
});

// Get floors filtered by attributes
router.get("/getByAttr", (req, res) => {
    floor.getByAttr(req.query.attr, req.query.value, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

module.exports = router;