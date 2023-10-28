// routes/cropRoutes.js

import express from 'express';
import {
  createCrop,
  getAllCrops,
  getCropById,
  updateCrop,
  deleteCrop,
} from '../controllers/CropController.mjs';

const router = express.Router();

// Create a new crop
router.post('/add', createCrop);

// Get all crops
router.get('/', getAllCrops);

// Get a single crop by ID
router.get('/:id', getCropById);

// Update a crop by ID
router.put('/:id', updateCrop);

// Delete a crop by ID
router.delete('/:id', deleteCrop);

export default router;
