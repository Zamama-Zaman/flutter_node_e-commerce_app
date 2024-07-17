const asyncHandler = require("express-async-handler");
const {productModel, productSchema} = require("../models/productModel");
const rateSchema = require("../models/ratingModel");
// add product
const add = asyncHandler(async (req, res) => {
  const { name, price, quantity, description, images, category } = req.body;
  const rating = [];
  
  const isFound = await productModel.findOne({ name });
  if (isFound) {
    res.status(400).json({
      message: "Already in database",
      status: false,
    });
    throw new Error("Already in exist");
  }

  const newProduct = await productModel.create({
    name,
    price,
    quantity,
    category,
    description,
    images,
    rating
  });

  if (newProduct) {
    res.status(201).json({
      status: true,
      message: "Successfully Added",
      body: newProduct,
    });
  } else {
    res.status(400);
    throw new Error("Product data is not valid");
  }
});

// delete product
const deleteProduct = asyncHandler(async (req, res) => {
  const { _id } = req.body;

  const isDeleted = await productModel.findByIdAndDelete(_id);

  if (isDeleted) {
    res.status(200).json({
      status: true,
      message: "Successfully Deleted",
    });
  } else {
    res.status(400);
    throw new Error("Unable to delete product");
  }
});

// get product
const getSearchProduct = asyncHandler(async (req, res) => {
  const result = await productModel.find({
    name: { $regex: req.params.query, $options: "i" },
  });

  if (result) {
    res.status(200).json({
      status: true,
      data: result,
    });
  } else {
    res.status(400);
    throw new Error("Unable to delete product");
  }
});

// get product
const getAllProducts = asyncHandler(async (req, res) => {
  const result = await productModel.find();

  if (result) {
    res.status(200).json({
      status: true,
      data: result,
    });
  } else {
    res.status(400);
    throw new Error("Unable to delete product");
  }
});

// get products by categorys
const getProductByCategory = asyncHandler(async (req, res) => {
  const { category } = req.body;

  const result = await productModel.find({ category });

  if (result) {
    res.status(200).json({
      status: true,
      data: result,
    });
  } else {
    res.status(400);
    throw new Error("Unable to delete product");
  }
});

const ratingAProduct = asyncHandler(async (req, res) => {
  const { rate, productId } = req.body;
  const userId = req.user.id;

  try {
    let findProduct = await productModel.findById(productId);

    // first delete a rate from product if raing exits
    if(findProduct){
      for (let i = 0; i < findProduct.rating.length; i++) {
        if (findProduct.rating[i].userId == userId) {
          findProduct.rating.splice(i, 1);
          break;
        }
      }
    }

    const rateSchema = {
      rate,
      productId,
      userId,
    }

    findProduct.rating.push(rateSchema);
    findProduct = await findProduct.save();


    if (findProduct) {
      res.status(200).json({
        status: "Success",
        message: "Rating added successfully",
        body: findProduct,
      });
    } else {
      res.status(400);
      throw new Error("Unable to rate a product");
    }

    
  } catch (error) {
    res.status(500).json({
      status: "Error",
      message: "Unable to rate the product",
      error: error.message,
    });
  }
});

const topRatedProducts = asyncHandler(async (req, res) => {
  try {

    const products = await productModel.find().lean();

    const topRated = products.filter(product => {
      const totalRatings = product.rating.reduce((acc, curr) => acc + parseFloat(curr.rate), 0);
      const avgRating = totalRatings / product.rating.length;

      return avgRating > 4.5;
    });

    if (topRated) {
      res.status(200).json({
        status: "Success",
        message: "Top rated product fetched successfully",
        body: topRated,
      });
    } else {
      res.status(400);
      throw new Error("Unable to fetch top rated product");
    }

    
  } catch (error) {
    res.status(500).json({
      status: "Error",
      message: "Unable to fetch top rated product",
      error: error.message,
    });
  }
});

module.exports = {
  add,
  deleteProduct,
  getSearchProduct,
  getAllProducts,
  getProductByCategory,
  ratingAProduct,
  topRatedProducts,
};
