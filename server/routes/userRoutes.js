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
} = require("../controller/userController");

router.post("/login", login);

router.post("/register", register);

router.get("/profile", validateToken, profile);

router.post("/add-to-cart", addToCart);

router.post("/remove-from-cart", removeFromCart);

router.get("/cart", getCart);

router.post("/place-order", placeOrder);

module.exports = router;
