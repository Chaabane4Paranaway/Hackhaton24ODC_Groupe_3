const mongoose = require('mongoose');
const Client = require('../model/clientModel');
const catchAsync = require('../utils/catchAsync');
const appError = require('../utils/appError');

const numStore = new Map();

exports.getAllClients = catchAsync(async (req, res, next) => {
  const clients = await Client.find();
  res.status(200).json({
    status: 'success',
    results: clients.length,
    data: {
      clients,
    },
  });
});

exports.fetchCurrentUserAndRandomOthers = catchAsync(async (req, res, next) => {
  const { phone_number } = req.body;

  // Fetch the current user based on the provided phone number
  const currentUser = await Client.findOne(
    { phone_number: phone_number },
    {
      firstName: 1,
      lastName: 1,
      date_of_birth: 1,
      phone_number: 1,
      CNIB_number: 1,
    }
  );

  if (!currentUser) {
    return next(appError('User not found!', 404));
  }

  // Retrieve three other users with distinct fields
  const otherUsers = await Client.aggregate([
    { $sample: { size: 3 } }, // Fetch exactly 3 random users
  ]);

  if (otherUsers.length < 3) {
    return next(appError('Not enough users found!', 404));
  }

  // Prepare the final result for the frontend
  const result = {
    correct_firstName: currentUser.firstName,
    correct_lastName: currentUser.lastName,
    correct_date_of_birth: currentUser.date_of_birth,
    correct_CNIB_number: currentUser.CNIB_number,
    options: [
      {
        firstName: currentUser.firstName,
        lastName: currentUser.lastName,
        date_of_birth: currentUser.date_of_birth,
        CNIB_number: currentUser.CNIB_number,
      },
      ...otherUsers.map((user) => ({
        firstName: user.firstName,
        lastName: user.lastName,
        date_of_birth: user.date_of_birth,
        CNIB_number: user.CNIB_number,
      })),
    ],
  };

  // Shuffle the options array for randomness
  result.options = result.options.sort(() => Math.random() - 0.5);
  res.status(200).json(result);
});

exports.verifyUserInformation = catchAsync(async (req, res) => {
  const { phone_number, firstName, lastName, date_of_birth, CNIB_number } = req.body;

  const user = await Client.findOne({ phone_number });

  if (!user) {
    return next(appError('User not found!', 404));
  }

  const isMatch =
    user.firstName === firstName &&
    user.lastName === lastName &&
    user.date_of_birth.toISOString().slice(0, 10) === date_of_birth &&
    user.CNIB_number === CNIB_number;

  res.status(200).json({ isMatch });
});

// Function to activate the secret word
exports.activateSecretWord = catchAsync(async (req, res, next) => {
  const { phone_number } = req.body;

  // Find the user by phone number
  const user = await Client.findOne({ phone_number });

  if (!user) {
    return next(appError('User not found!', 404));
  }

  if (user.secret_word.active === true) {
    return next(appError('Secret word is already active!', 400));
  }

  if (user.secret_word) {
    await Client.findByIdAndUpdate(user.id, { 'secret_word.active': true }, { new: true });
  }
  res.status(200).json({ message: 'Secret word activated successfully' });
});

// Function to deactivate the secret word
exports.deactivateSecretWord = catchAsync(async (req, res, next) => {
  const { phone_number } = req.body;

  // Find the user by phone number
  const user = await Client.findOne({ phone_number });

  if (!user) {
    return next(appError('User not found!', 404));
  }

  if (user.secret_word.active === false) {
    return next(appError('Secret word is already deactivated!', 400));
  }

  if (user.secret_word) {
    await Client.findByIdAndUpdate(user.id, { 'secret_word.active': false }, { new: true });
  }
  res.status(200).json({ message: 'Secret word deactivated successfully' });
});

// Function to check if the secret word is active
exports.isSecretWordActive = catchAsync(async (req, res, next) => {
  const { phone_number } = req.body;
  const user = await Client.findOne({ phone_number }).select('secret_word.active'); // Fetch only the `active` field of `secret_word`
  if (!user) {
    return next(appError('User not found!', 404));
  }
  res.status(200).json({ message: 'Secret word status fetched successfully', active: user.secret_word.active });
});

exports.addSecretWordIfNotExists = catchAsync(async (req, res, next) => {
  const { indice, secret, phone_number } = req.body;
  const user = await Client.findOne({ phone_number: phone_number });

  if (!user) {
    return next(appError('User not found!', 404));
  }

  if (user.secret_word && user.secret_word.indice && user.secret_word.secret) {
    return next(appError('User already has a secret_word', 400));
  }

  const updatedUser = await Client.findByIdAndUpdate(
    user._id,
    { secret_word: { indice, secret, active: true } },
    { new: true, runValidators: true }
  );
  res.status(200).json({ message: 'Secret word updated successfully', user: updatedUser });
});
