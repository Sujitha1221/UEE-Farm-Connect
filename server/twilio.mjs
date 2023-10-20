import twilio from "twilio";
import cron from "node-cron";
import mongoose from "mongoose";

// Replace with your MongoDB connection URL
mongoose.connect(process.env.MONGODB_URL, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Import the Product and Farmer models (use .js file extension if that's what you have)
import Product from "./models/Product.mjs";
import User from "./models/User.mjs";

// Configure Twilio with your credentials
const client = twilio(
  "AC96f078c97786bfd74b35eb37c0342c0b",
  "006b560393dc7f3807521b2d69f03701"
);

// Function to send SMS
const sendSMS = (to, body) => {
  return client.messages.create({
    to,
    from: "+16787103076",
    body,
  });
};



// Calculate the notification date (two days before expiryDate)
const notificationDate = new Date();


// Set the time portion to midnight (00:00:00)
notificationDate.setHours(0, 0, 0, 0);

notificationDate.setDate(notificationDate.getDate() + 2); // Advance by 1 day

console.log(notificationDate);

// Schedule SMS notifications for products expiring in two days
cron.schedule('0 8 * * *', async () => {
  
  try {
  
    const products = await Product.find({
      // Find products with expiry date greater than notificationDate and less than expiryDate
      expiryDate: {
        $gte: notificationDate,
        $lt: new Date(notificationDate.getTime() + 2 * 24 * 60 * 60 * 1000), // Two days later
      },
    });


    for (const product of products) {
      const farmer = await User.findOne({ userName: product.farmerName });

      if (farmer) {
        console.log(farmer);
        const farmerPhoneNumber = "+94" + farmer.contact.toString();
        console.log(farmerPhoneNumber);
        const message = `Hi ${farmer.userName}, your product "${product.productName}" is expiring in two days. Please take action.`;

        // Send SMS notification
        sendSMS(farmerPhoneNumber, message)
          .then((message) => console.log(`SMS sent to ${farmer.userName}: ${message.sid}`))
          .catch((error) => console.error(`Error sending SMS to ${farmer.userName}: ${error}`));
      }
    }
  } catch (error) {
    console.error(`Error retrieving products: ${error}`);
  }
});
