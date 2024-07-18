const mongoose = require("mongoose");
const rateSchema = require("./ratingModel");

const productSchema = mongoose.Schema(
  {
    adminId: {
      type: String,
      default: "",
    },
    name: {
      type: String,
      default: "",
    },
    price: {
      type: String,
      default: "",
    },
    category: {
      type: String,
      default: "",
    },
    quantity: {
      type: String,
      default: "",
    },
    description: {
      type: String,
      default: "",
    },
    images: [
      {
        type: String,
        default: "",
      },
    ],
    rating: [rateSchema],
  },
  {
    timestamps: true,
  }
);
const productModel = mongoose.model("Products", productSchema);
module.exports = { productModel, productSchema };
