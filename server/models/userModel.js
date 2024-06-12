const mongoose = require("mongoose");
const { productModel, productSchema } = require("./productModel");

const userSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, "name field is required"],
    },
    email: {
      type: String,
      required: [true, "email field is required"],
      unique: [true, "email is not Unique"],
    },
    password: {
      type: String,
      required: [true, "password field is required"],
    },
    type: {
      type: String,
      default: "user",
    },
    address: {
      type: String,
      default: "",
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

module.exports = mongoose.model("User", userSchema);
