mongoose = require("mongoose")
db = require("./db")

Schema = mongoose.Schema
Transaction = new Schema(
  amount: Number
  date: Date
  desc: String
)
Account = new Schema(
  type: 
    type: String
    default: "perosnal"
  currency: 
    type: String
    default: "$"
  branch: 
    type: String
    default: "AUB"
  availableBalance: 
    type: Number
    default: 0
  currentBalance: 
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
