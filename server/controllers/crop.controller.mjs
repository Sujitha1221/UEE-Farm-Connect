import Crop from '../models/crop.model.mjs';

// Create a new crop
export const createCrop = async (req, res) => {
  try {
    const { cropName, count, date } = req.body;
    const newCrop = new Crop({ cropName, count, date });

    await newCrop.save();
    res.status(200).json('Crop added successfully');
  } catch (err) {
    res.status(400).json('Error: ' + err);
  }
};

// Get all crops
export const getAllCrops = async (req, res) => {
  try {
    const crops = await Crop.find();
    res.status(200).json(crops);
  } catch (err) {
    res.status(400).json('Error: ' + err);
  }
};

// Get a single crop by ID
export const getCropById = async (req, res) => {
  try {
    const crop = await Crop.findById(req.params.id);
    if (!crop) {
      return res.status(404).json('Crop not found');
    }
    res.status(200).json(crop);
  } catch (err) {
    res.status(400).json('Error: ' + err);
  }
};

// Update a crop by ID
export const updateCrop = async (req, res) => {
  try {
    const { cropName, count, date } = req.body;
    await Crop.findByIdAndUpdate(req.params.id, { cropName, count, date });
    res.status(200).json('Crop updated successfully');
  } catch (err) {
    res.status(400).json('Error: ' + err);
  }
};

// Delete a crop by ID
export const deleteCrop = async (req, res) => {
  try {
    await Crop.findByIdAndRemove(req.params.id);
    res.status(200).json('Crop deleted successfully');
  } catch (err) {
    res.status(400).json('Error: ' + err);
  }
};