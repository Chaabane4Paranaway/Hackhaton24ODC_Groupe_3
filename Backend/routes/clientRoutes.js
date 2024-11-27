const express = require('express');
const router = express.Router();
const {
  fetchCurrentUserAndRandomOthers,
  verifyUserInformation,
  activateSecretWord,
  deactivateSecretWord,
  isSecretWordActive
} = require('../controllers/clientController');
const authenticatioController = require('../controllers/authenticationController');

router.post('/signup', authenticatioController.signUp);
router.post('/signin', authenticatioController.logIn);

router.post('/activate-secret-word', activateSecretWord);
router.post('/deactivate-secret-word', deactivateSecretWord);

// GET Route to Fetch OTP
// router.use(authenticatioController.protect);

router.get('/secret-word-status', isSecretWordActive);
router.post('/verify-user-info', verifyUserInformation);
router.post('/your-phone-number', fetchCurrentUserAndRandomOthers);

module.exports = router;
