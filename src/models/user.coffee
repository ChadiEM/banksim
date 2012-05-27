mongoose = require("mongoose")
db = require("./db")

Schema = mongoose.Schema
Transaction = new Schema(
  _id: 
    type: Number
    index: true
  amount: Number
  date: Date
  desc: String
)
Account = new Schema(
  _id: 
    type: Number
    index: true
  type: String
  currency: String
  branch: String
  availableBalance: Number
  currentBalance: Number
  transactions: [Transaction]
)
UserSchema = new Schema(
  _id: 
    type: Number
    index: true
  name: String
  age: Number
  sex: String 
  accounts: [Account]
)
User = db.model("User", UserSchema)
exports.User = User
