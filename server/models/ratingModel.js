const mongoose = require("mongoose");

const rateSchema = mongoose.Schema({
  rate: {
    type: String,
    required: true,
  },
  productId: {
    type: String,
    required: true,
  },
  userId: {
    type: String,
    required: true,
  },
  _id: mongoose.Schema.Types.ObjectId,
});

module.exports = rateSchema;
