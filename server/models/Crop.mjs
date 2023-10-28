import mongoose from 'mongoose';

const cropSchema = new mongoose.Schema({
  cropName: String,
  count: Number,
  date: Date,
});

const Crop = mongoose.model('Crop', cropSchema);

export default Crop;