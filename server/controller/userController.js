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
    throw new Error(res.__("all_fields_are_mandatory"));
  }

  const isEmailAvailable = await User.findOne({ email });
  if (!isEmailAvailable) {
    res.status(401);
    throw new Error(res.__("user_not_exist"));
  }

  const verifyed = await bcrypt.compare(password, isEmailAvailable.password);

  if (!verifyed) {
    res.status(401);
    throw new Error(res.__("password_not_matched"));
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
        expiresIn: "60m",
      }
    );
    res.status(200).json({
      status: "Success",
      message: res.__("user_is_successfully_login"),
      body: {
        user: isEmailAvailable,
        token: accessToken,
      },
    });
  } else {
    res.status(401);
    throw new Error(res.__("email_or_password_is_not_valid"));
  }
});

const register = asyncHandler(async (req, res) => {
  const { name, email, password } = req.body;
  if (!name || !email || !password) {
    res.status(400);
    throw new Error(res.__("all_fields_are_mandatory"));
  }

  const userAvailble = await User.findOne({ email });
  if (userAvailble) {
    res.status(400);
    throw new Error(res.__("user_already_register"));
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
      message: res.__("user_register_successfully"),
      body: user,
    });
  } else {
    res.status(400);
    throw new Error(res.__("user_data_is_not_valid"));
  }
});

//
const profile = asyncHandler(async (req, res) => {
  res.status(200).json({
    status: "Success",
    message: res.__("fetched_user_data_successfully"),
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
      message: res.__("product_added_uccessfully"),
      body: savedUser,
    });
  } else {
    res.status(400);
    throw new Error(res.__("user_data_is_not_fount"));
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
      message: res.__("successfully_remove_from_cart"),
      body: savedUser,
    });
  } else {
    res.status(400);
    throw new Error(res.__("error_to_remove_from_cart"));
  }
});

// view-cart
const getCart = asyncHandler(async (req, res) => {

  const user = await User.findById(req.user.id);

  if (user) {
    res.status(200).json({
      status: "Success",
      message: res.__("successfully_fetch_carts"),
      body: {
        cart: user.cart,
      },
    });
  } else {
    res.status(400);
    throw new Error(res.__("error_to_fetch_cart"));
  }
});

// order a product
const placeOrder = asyncHandler(async (req, res) => {
  const { subTotal, deliveryAddress } = req.body;

  let user = await User.findById(req.user.id);

  const order = await orderModel.create({
    subTotal,
    deliveryAddress,
    userDetail: {
      userId: user._id,
      name: user.name,
    },
    cart: user.cart,
    status: 0,
  });

  const savedOrder = await order.save();
  
  // clearing cart
  user.cart = [];
  user = await user.save();

  if (savedOrder) {
    res.status(200).json({
      status: "Success",
      message: res.__("the_order_is_successfull"),
      body: savedOrder,
    });
  } else {
    res.status(400);
    throw new Error(res.__("error_occured_to_order"));
  }
});

// get all users order
const myOrders = asyncHandler(async (req, res) => {

  const myOrders = await orderModel.find({ 'userDetail.userId': req.user.id});

  if (myOrders) {
    res.status(200).json({
      status: "Success",
      message: res.__("my_orders_is_fetched_successfull"),
      body: myOrders,
    });
  } else {
    res.status(400);
    throw new Error(res.__("error_to_fetch_my_orders"));
  }
});

// save user address
const saveUserAddress = asyncHandler(async (req, res) => {
  const { address } = req.body;

  const user = await User.findById(req.user.id);

  user.address = address;
  user = await user.save();

  if (user) {
    res.status(200).json({
      status: "Success",
      message: res.__("address_added_successfully"),
      body: user,
    });
  } else {
    res.status(400);
    throw new Error(res.__("error_occured_to_save_user_address"));
  }
});

// change order status
const changeOrderStatus = asyncHandler(async (req, res) => {
  const { id, status } = req.body;
  
  let order = await orderModel.findById(id);

  order.status = status;
    order = await order.save();
    res.json(order);

  if (order) {
    res.status(200).json({
      status: "Success",
      message: res.__("order_status_changed_successfully"),
      body: order,
    });
  } else {
    res.status(400);
    throw new Error(res.__("error_occured_to_change_order_status"));
  }
});

// get all orders
const getAllOrders = asyncHandler(async (req, res) => {
  
  let order = await orderModel.find();

  if (order) {
    res.status(200).json({
      status: "Success",
      message: res.__("all_order_fetched_successfully"),
      body: order,
    });
  } else {
    res.status(400);
    throw new Error(res.__("error_to_fetch_orders"));
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
  saveUserAddress,
  myOrders,
  changeOrderStatus,
  getAllOrders,
};
