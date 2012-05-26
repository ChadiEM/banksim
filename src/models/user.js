var mongoose = require('mongoose');
var db = require('./db');

var Schema = mongoose.Schema;

// Transaction model
var Transaction = new Schema({
    _id : { type: Number, index: true },
	, amount : Number,
	, date : Date,
	, desc : String
});


// Account model that uses an array of transactions
var Account = new Schema({
    _id : { type: Number, index: true },
	 , type : String
	, curr : String
	, branch : String 
	, avBalance : Number 
	, currBalance: Number
	, transactions: [Transaction]
});

// UserSchema that defines the model of the user. It also includes an array of accounts.
var UserSchema = new Schema({
    _id : { type: Number, index: true }
    , name : String
	 , age : Number
	 , sex : String
	 , accounts: [Account]
});

// Make User be the public variavle available to the world where User is a representation of the UserSchema
var User = db.model('User', UserSchema);
exports.User = User;
