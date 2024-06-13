const asyncHandler = require("express-async-handler");
const bcrypt = require("bcrypt");
const User = require("../models/userModel");
const { productModel, productSchema } = require("../models/productModel");
const jwt = require("jsonwebtoken");
const { orderModel } = require("../models/orderModel");

const login = asyncHandler(async (req, res) => {
  //* email, password,
  const { email, password } = req.body;

  if (!email || !password) {
    res.status(400);
    throw new Error("All fields are mandatory!");
  }

  const isEmailAvailable = await User.findOne({ email });
  if (!isEmailAvailable) {
    res.status(401);
    throw new Error("User not exist");
  }

  const verifyed = await bcrypt.compare(password, isEmailAvailable.password);

  if (!verifyed) {
    res.status(401);
    throw new Error("Password not matched");
  }

  if (isEmailAvailable && verifyed) {
    const accessToken = jwt.sign(
      {
        user: {
          name: isEmailAvailable.name,
          email: isEmailAvailable.email,
          id: isEmailAvailable.id,
        },
      },
      process.env.ACCESS_TOKEN_SECRET,
      {
        expiresIn: "15m",
      }
    );
    res.status(200).json({
      status: "Success",
      message: "User is successfully login",
      body: {
        user: isEmailAvailable,
        token: accessToken,
      },
    });
  } else {
    res.status(401);
    throw new Error("Email or password is not valid");
  }
});

const register = asyncHandler(async (req, res) => {
  const { name, email, password } = req.body;
  if (!name || !email || !password) {
    res.status(400);
    throw new Error("All fields are mandatory!");
  }

  const userAvailble = await User.findOne({ email });
  if (userAvailble) {
    res.status(400);
    throw new Error("user already register!");
  }

  const hashedPassword = await bcrypt.hash(password, 10);
  console.log("hash Password", hashedPassword);

  const user = await User.create({
    name,
    email,
    password: hashedPassword,
  });

  if (user) {
    res.status(201).json({
      status: "Success",
      message: "User register successfully",
      body: user,
    });
  } else {
    res.status(400);
    throw new Error("User data is not valid");
  }
});

//
const profile = asyncHandler(async (req, res) => {
  res.status(200).json({
    status: "Success",
    message: "Fetched user data successfully",
    body: req.user,
  });
});

// add to cart
const addToCart = asyncHandler(async (req, res) => {
  const { productId } = req.body;

  const user = await User.findById(req.user.id);

  const product = await productModel.findById(productId);

  if (user.cart.length == 0) {
    user.cart.push({ product, quantity: 1 });
  } else {
    let isProductFound = false;
    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        isProductFound = true;
        break;
      }
    }

    if (isProductFound) {
      let producttt = user.cart.find((productt) =>
        productt.product._id.equals(product._id)
      );
      producttt.quantity += 1;
    } else {
      user.cart.push({ product, quantity: 1 });
    }
  }

  const savedUser = await user.save();

  if (user) {
    res.status(200).json({
      status: "Success",
      message: "Fetched user data successfully",
      body: savedUser,
    });
  } else {
    res.status(400);
    throw new Error("User data is not Fount");
  }
});

// remove from cart
const removeFromCart = asyncHandler(async (req, res) => {
  const { productId } = req.body;

  const user = await User.findById(req.user.id);

  if (user.cart.length != 0) {
    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id == productId) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
          break;
        } else {
          user.cart[i].quantity--;
        }
      }
    }
  }

  const savedUser = await user.save();

  if (savedUser) {
    res.status(200).json({
      status: "Success",
      message: "Successfully remove from cart",
      body: savedUser,
    });
  } else {
    res.status(400);
    throw new Error("Error to remove from cart");
  }
});

// view-cart
const getCart = asyncHandler(async (req, res) => {

  const user = await User.findById(req.user.id);

  if (user) {
    res.status(200).json({
      status: "Success",
      message: "Successfully fetch carts",
      body: {
        cart: user.cart,
      },
    });
  } else {
    res.status(400);
    throw new Error("Error to fetch cart");
  }
});

// order a product
const placeOrder = asyncHandler(async (req, res) => {
  const { subTotal, deliveryAddress } = req.body;

  const user = await User.findById(req.user.id);

  const order = await orderModel.create({
    subTotal,
    deliveryAddress,
    userDetail: {
      userId: user._id,
      name: user.name,
    },
    cart: user.cart,
  });

  const savedOrder = await order.save();

  if (savedOrder) {
    res.status(200).json({
      status: "Success",
      message: "The Order is successfull",
      body: savedOrder,
    });
  } else {
    res.status(400);
    throw new Error("Error Occured to order");
  }
});

module.exports = {
  login,
  register,
  profile,
  addToCart,
  removeFromCart,
  placeOrder,
  getCart,
};
