mongoose = require 'mongoose'

UserModel = new mongoose.Schema
  id: type: Number, unique: yes
  name: type: String
  icon: type: String
  updated: type: Date
  created: type: Date
,
  versionKey: no

exports.User = mongoose.model 'users', UserModel
