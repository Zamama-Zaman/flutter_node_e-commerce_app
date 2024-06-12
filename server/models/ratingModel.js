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
});

module.exports = rateSchema;
