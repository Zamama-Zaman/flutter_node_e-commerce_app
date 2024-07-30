const express = require("express");
const connectDb = require("./config/dbConnection");
const errorHandler = require("./middleware/errorHandler");
const dotenv = require("dotenv").config();
const path = require('path')
const { I18n } = require("i18n");

connectDb();
const app = express();

const port = process.env.PORT || 80;

const i18n = new I18n({
  locales: ['en', 'ar'],
  directory: path.join(__dirname, 'translations')
});

app.use(i18n.init);

app.use(express.json());

app.use("/", require("./routes/userRoutes"));

app.use("/", require("./routes/productRoutes"));

app.use(errorHandler);

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
