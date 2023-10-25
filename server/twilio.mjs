import twilio from "twilio";
import cron from "node-cron";
import mongoose from "mongoose";
import moment from "moment-timezone"; // Import the moment-timezone library

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

// Set the time zone to Sri Lankan time (Asia/Colombo)
moment.tz.setDefault("Asia/Colombo");

// Calculate the notification date (three days in the future)
const notificationDate = moment();

// Set the time portion to midnight (00:00:00)
notificationDate.startOf("day");

notificationDate.add(3, "days"); // Advance by 3 days

// Schedule SMS notifications for products expiring in two days at midnight Sri Lankan time
// Schedule SMS notifications for products expiring in two days at midnight Sri Lankan time
cron.schedule('0 0 * * *', async () => {
  try {
    const products = await Product.find({
      // Find products with expiry date greater than or equal to notificationDate and less than expiryDate
      expiryDate: {
        $gte: notificationDate.toDate(),
        $lt: moment(notificationDate).add(2, "days").toDate(), // Two days later
      },
    });
    console.log(notificationDate); // Change this line

    for (const product of products) {
      const farmer = await User.findOne({ userName: product.farmerName });

      if (farmer) {
        const farmerPhoneNumber = "+94" + farmer.contact.toString();
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

