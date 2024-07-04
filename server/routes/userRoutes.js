const express = require("express");
const router = express.Router();
const validateToken = require("../middleware/validateTokenHandler");
const {
  login,
  register,
  profile,
  addToCart,
  removeFromCart,
  getCart,
  placeOrder,
  saveUserAddress,
  myOrders,
  changeOrderStatus,
  getAllOrders,
} = require("../controller/userController");

router.post("/login", login);

router.post("/register", register);

router.get("/profile", validateToken, profile);

router.post("/add-to-cart", validateToken, addToCart);

router.post("/remove-from-cart", validateToken, removeFromCart);

router.get("/cart", validateToken, getCart);

router.post("/place-order", validateToken, placeOrder);

router.get("/my-orders", validateToken, myOrders);

router.post("/save-user-address", validateToken, saveUserAddress);

router.post("/change-order-status", validateToken, changeOrderStatus);

router.get("/get-all-orders", getAllOrders);

module.exports = router;
