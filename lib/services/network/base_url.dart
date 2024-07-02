class AppBaseUrl {
  static const url = "http://192.168.0.102:80";

  static const loginUrl = "$url/login";
  static const registerUrl = "$url/register";
  static const addProductUrl = "$url/add-product";
  static const fetchAllProductUrl = "$url/get-all-products";
  static const deleteAProduct = "$url/delete-product";
  static const getProductsByCategory = "$url/get-products-by-category";
  static const addToCartUrl = "$url/add-to-cart";
  static const removeFromCartUrl = "$url/remove-from-cart";
  static const getCartUrl = "$url/cart";
  static const saveUserAddressUrl = "$url/save-user-address";
  static const placeOrderUrl = "$url/place-order";
  static const myOrdersUrl = "$url/my-orders";
  static const orderStatusChangeUrl = "$url/change-order-status";
}
