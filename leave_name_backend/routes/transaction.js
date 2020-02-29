const express = require("express");
const router = express.Router();
var transaction = require("../models/transaction");

// Get all transactions
router.get("/getAll", (req, res) => {
    transaction.getAll(req.query.orderBy).then((result)=>{
        res.json(result);
    });
});

// Get teams filtered by attributes
router.get("/getByAttr", (req, res) => {
    transaction.getByAttr(req.query.attr, req.query.value, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

// Get all debts in a floor or a team, summing up and group by users
router.get("/getAllUsersDebt", (req, res) => {
    transaction.getAllUsersDebt(req.query.attr, req.query.value, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

// Get all debts of a user in a floor or team
router.get("/getUserDebtDetail/:user_id", (req, res) => {
    transaction.getUserDebtDetail(req.query.attr, req.query.value, req.params.user_id, req.query.orderBy).then((result) => {
        res.json(result);
    });
});

module.exports = router;