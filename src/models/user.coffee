mongoose = require("mongoose")
db = require("./db")

Schema = mongoose.Schema
Transaction = new Schema(
  amount: Number
  date: Date
  desc: String
)
Account = new Schema(
  type: String
  currency: String
  branch: String
  availableBalance: Number
  currentBalance: Number
  transactions: [Transaction]
)
UserSchema = new Schema(
  name: String
  email: String
  pass: String
  gender: String
  age: Number
  sex: String 
  accounts: [Account]
)
User = db.model("User", UserSchema)
exports.User = User
