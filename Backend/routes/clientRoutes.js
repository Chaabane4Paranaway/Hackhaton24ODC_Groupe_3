const express = require('express');
const router = express.Router();
const {
  fetchCurrentUserAndRandomOthers,
  verifyUserInformation,
  activateSecretWord,
  deactivateSecretWord,
  isSecretWordActive,
  addSecretWordIfNotExists,
  getAllClients,
} = require('../controllers/clientController');
const authenticatioController = require('../controllers/authenticationController');

router.post('/signup', authenticatioController.signUp);
router.post('/signin', authenticatioController.logIn);

router.post('/activate-secret-word', activateSecretWord);
router.post('/deactivate-secret-word', deactivateSecretWord);

// router.use(authenticatioController.protect);

router.get('/all-clients', getAllClients);
router.post('/secret-word-status', isSecretWordActive);
router.post('/verify-user-info', verifyUserInformation);
router.post('/your-phone-number', fetchCurrentUserAndRandomOthers);
router.patch('/add-secret-word', addSecretWordIfNotExists);

module.exports = router;
