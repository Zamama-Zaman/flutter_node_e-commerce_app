const express = require("express");
const {
  add,
  deleteProduct,
  getSearchProduct,
  getAllProducts,
  getProductByCategory,
  ratingAProduct,
} = require("../controller/productController");

const router = express.Router();

router.post("/add-product", add);

router.post("/delete-product", deleteProduct);

router.get("/get-products/:query", getSearchProduct);

router.get("/get-all-products", getAllProducts);

router.post("/get-products-by-category", getProductByCategory);

router.post("/rating-a-product", ratingAProduct);

module.exports = router;
