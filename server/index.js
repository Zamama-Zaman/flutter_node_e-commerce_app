const express = require("express");
const connectDb = require("./config/dbConnection");
const dotenv = require("dotenv").config();

connectDb();
const app = express();

const port = process.env.PORT || 80;

app.use(express.json());

app.use("/", require("./routes/userRoutes"));

app.use("/", require("./routes/productRoutes"));

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
