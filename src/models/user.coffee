mongoose = require("mongoose")
db = require("./db")

Schema = mongoose.Schema
Transaction = new Schema(
  amount: Number
  type: String
  date: 
    type: Date
    default: Date.now
)
Account = new Schema(
  type: 
    type: String
    default: "personal"
  currency: 
    type: String
    default: "$"
  branch: 
    type: String
    default: "AUB"
  balance: 
    type: Number
    default: 0
  transactions: [Transaction]
)
UserSchema = new Schema(
  name: String
  email: String
  pass: String
  gender: String
  accounts: [Account]
)
User = db.model("User", UserSchema)
exports.User = User
