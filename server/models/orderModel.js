const mongoose = require("mongoose");
const { productSchema } = require("../models/productModel");

const orderSchema = mongoose.Schema(
  {
    subTotal: {
      type: Number,
      required: true,
    },
    deliveryAddress: {
      type: String,
      required: true,
    },
    userDetail: {
      userId: {
        type: String,
        required: true,
      },
      name: {
        type: String,
        required: true,
      },
    },
    cart: [
      {
        product: productSchema,
        quantity: {
          type: Number,
          required: true,
        },
      },
    ],
  },
  {
    timestamps: true,
  }
);
const orderModel = mongoose.model("Orders", orderSchema);
module.exports = { orderModel, orderSchema };
