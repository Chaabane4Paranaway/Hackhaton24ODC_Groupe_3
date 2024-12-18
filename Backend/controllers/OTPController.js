const express = require('express');
const router = express.Router();
const crypto = require('crypto');
const catchAsync = require('../utils/catchAsync');
const appError = require('../utils/appError');
const sendEmail = require('../utils/email');

// In-memory store for OTPs (for simplicity, replace with Redis or similar for production)
const otpStore = new Map();

// Models
const Client = require('../model/clientModel');

// POST Route to Generate OTP
exports.generateOTP = catchAsync(async (req, res, next) => {
  const { response, phone_number } = req.body;
  // const user_id = req.user.id;

  // if (!response || !phone_number) {
  //   return res.status(400).json({ error: 'Invalid request data.' });
  // }

  // const current_user = await Client.findOne(phone_number);

  // if (!current_user) {
  //   return next(appError('User not found!', 404));
  // }

  // if (current_user.phone_number !== phone_number) {
  //   return next(appError('Phone number mismatch!', 400));
  // }

  // Find user by phone number
  const user = await Client.findOne({ phone_number });

  if (!user) {
    return res.status(404).json({ error: 'User not found.' });
  }

  if (response === true) {
    // Generate a 4-digit OTP
    const otp = crypto.randomInt(1000, 9999);

    // Here, you might send the OTP via SMS or any other delivery mechanism.
    // For now, returning it in the response for demonstration purposes.

    // const message = `Your OTP is: ${otp}`;
    // try {
    //   await sendEmail({
    //     email: user.email_address,
    //     subject: 'Your password reset OTP (Valid for 1min).',
    //     message,
    //   });

    //   res.status(200).json({
    //     status: 'success',
    //     message: 'OTP sent to email!',
    //   });
    // } catch (err) {
    //   user.passwordResetToken = undefined;
    //   user.passwordResetExpires = undefined;
    //   await user.save({ validateBeforeSave: false });

    //   return next(appError('there was an error sending this email, please try again later!', 500));
    // }

    // Store the OTP in the in-memory store
    const addOtp = await Client.findByIdAndUpdate(user._id, { otp }, { new: true });

    return res.status(200).json({
      message: 'OTP generated successfully.',
      otp,
      expiresAt: Date.now() + 1 * 60 * 1000, // Inform the client about the expiration time
    });
  } else {
    return res.status(200).json({ message: 'Response is false; OTP not generated.' });
  }
});

exports.verifyOtp = catchAsync(async (req, res, next) => {
  const { otp, phone_number } = req.body;
  const user = await Client.findOne({ phone_number });

  if (!user) {
    return next(appError('User not found!', 404));
  }

  if (user.otp === otp) {
    await Client.findByIdAndUpdate(user._id, { otp: null }, { new: true });
    return res.status(200).json({ message: 'OTP verified successfully.' });
  } else {
    return next(appError('Invalid OTP.', 400));
  }
});
