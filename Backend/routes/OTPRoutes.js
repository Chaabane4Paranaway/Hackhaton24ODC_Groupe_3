const express = require('express');
const router = express.Router();
const { generateOTP, verifyOtp } = require('../controllers/OTPController');
const authenticatioController = require('../controllers/authenticationController');

// router.use(authenticatioController.protect);

// POST Route to Generate OTP
router.post('/generate-otp', generateOTP);

// POST Route to Verify OTP
router.post('/verify-otp', verifyOtp);

module.exports = router;
