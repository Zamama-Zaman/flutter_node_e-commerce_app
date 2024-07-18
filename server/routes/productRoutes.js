const express = require("express");
const validateToken = require("../middleware/validateTokenHandler");
const {
  add,
  deleteProduct,
  getSearchProduct,
  getAllProducts,
  getProductByCategory,
  ratingAProduct,
  topRatedProducts,
} = require("../controller/productController");

const router = express.Router();

router.post("/add-product", validateToken, add);

router.post("/delete-product", deleteProduct);

router.get("/get-products/:query", getSearchProduct);

router.get("/get-all-products", validateToken, getAllProducts);

router.post("/get-products-by-category", getProductByCategory);

router.post("/rating-a-product", validateToken, ratingAProduct);

router.get("/top-rated-products", topRatedProducts);

module.exports = router;
