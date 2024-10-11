// Import necessary dependencies
const { getAllOrders } = require('./userController');
const orderModel = require('../models/orderModel');
const httpMocks = require('node-mocks-http');
const asyncHandler = require('express-async-handler');

// Mock the orderModel
const orderModel = jest.mock('../models/orderModel');

describe('getAllOrders Controller', () => {
  let req, res, next;

  beforeEach(() => {
    req = httpMocks.createRequest();
    res = httpMocks.createResponse();
    res.__ = jest.fn((text) => text); // Mock the i18n translation function
    next = jest.fn();
  });

  it('should return 200 and all orders when they are found', async () => {
    // Mock the find method to return sample orders
    const mockOrders = [
      { _id: '1', name: 'Order 1' },
      { _id: '2', name: 'Order 2' },
    ];
    orderModel.find.mockResolvedValue(mockOrders);

    await getAllOrders(req, res, next);

    expect(orderModel.find).toHaveBeenCalled();
    expect(res.statusCode).toBe(200);
    expect(res._getJSONData()).toEqual({
      status: 'Success',
      message: 'all_order_fetched_successfully',
      body: mockOrders,
    });
  });

//   it('should return 400 and throw an error when no orders are found', async () => {
//     // Mock the find method to return null or empty array
//     orderModel.find.mockResolvedValue([]);

//     await getAllOrders(req, res, next);

//     expect(orderModel.find).toHaveBeenCalled();
//     expect(res.statusCode).toBe(400);
//     expect(next).toHaveBeenCalledWith(new Error('error_to_fetch_orders'));
//   });
});
