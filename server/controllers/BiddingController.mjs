import Bidding from "../models/Bidding.mjs";
import moment from "moment";
import nodemailer from "nodemailer";

export const newBidding = async (req, res) => {
  const {
    farmerUserName,
    userName,
    productName,
    weight,
    amountPerKg,
    totalAmount,
  } = req.body;

  Bidding.create({
    farmerUserName,
    userName,
    productName,
    weight,
    amountPerKg,
    totalAmount,
    status: "pending",
    creationDateTime: new Date(),
  })
    .then((Bidding) => {
      console.log({ status: "Success", Bidding });
      try {
        const transporter = nodemailer.createTransport({
          service: "gmail",
          auth: {
            user: "nonamenecessary0612@gmail.com",
            pass: "ekbgdpcvlpdiciws",
          },
          tls: {
            rejectUnauthorized: false,
          },
        });

        const mailOptions = {
          from: "nonamenecessary0612@gmail.com",
          to: Bidding.farmerUserName,
          subject: "New Bidding Request",
          text:
            `Bidding Details : \n` +
            "Bidding Person : " + 
            Bidding.userName +
            "\nProduct Name : " +
            Bidding.productName +
            "\nWeight : " +
            Bidding.weight +
            "\nTotal Amount : " +
            Bidding.totalAmount,
        };

        transporter.sendMail(mailOptions, (error, info) => {
          if (error) {
            console.error("Error:", error);
            return res
              .status(500)
              .json({ Status: "Error sending email" });
          } else {
            console.log("Email sent:", info.response);
            return res.status(200).json({ Status: "Success" });
          }
        });
      } catch (error) {
        console.error("Error:", error);
        return res.status(500).json({ Status: "Internal Server Error" });
      }
      return res.json(Bidding);
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });
};

export const getPendingByFarmerId = async (req, res) => {
  const { farmerUserName } = req.params;

  Bidding.find({ farmerUserName: farmerUserName, status: "pending" })
    .then((Bidding) => {
      if (!Bidding) {
        return res.json({ status: "No Bidding found" });
      } else {
        return res.json(Bidding);
      }
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });
};

export const getPendingByUserId = async (req, res) => {
  const { userName } = req.params;

  Bidding.find({ userName: userName, status: "pending" })
    .then((Bidding) => {
      if (!Bidding) {
        return res.json({ status: "No Bidding found" });
      } else {
        return res.json(Bidding);
      }
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });
};

export const getHistoryByFarmerId = async (req, res) => {
  const { farmerUserName } = req.params;

  Bidding.find({ farmerUserName: farmerUserName, status: { $ne: "pending" } })
    .then((Bidding) => {
      if (!Bidding) {
        return res.json({ status: "No Bidding found" });
      } else {
        return res.json(Bidding);
      }
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });
};

export const getHistoryByUserId = async (req, res) => {
  const { userName } = req.params;

  Bidding.find({ userName: userName, status: { $ne: "pending" } })
    .then((Bidding) => {
      if (!Bidding) {
        return res.json({ status: "No Bidding found" });
      } else {
        return res.json(Bidding);
      }
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });
};

export const acceptBidding = async (req, res) => {
  const { id } = req.body;

  Bidding.findById(id)
    .then((Bidding) => {
      if (!Bidding) return res.json({ status: "No bidding found" });
      else {
        Bidding.status = "Accepted";
        Bidding.lastModifiedDateTime = new Date();

        Bidding.save()
          .then((Bidding) => {
            try {
              const transporter = nodemailer.createTransport({
                service: "gmail",
                auth: {
                  user: "nonamenecessary0612@gmail.com",
                  pass: "ekbgdpcvlpdiciws",
                },
                tls: {
                  rejectUnauthorized: false,
                },
              });

              const mailOptions = {
                from: "nonamenecessary0612@gmail.com",
                to: [Bidding.userName, Bidding.farmerUserName],
                subject: "Congratulations! Your Bid Has Been Accepted",
                text:
                  `Bidding Details : \n` +
                  "Product Name : " +
                  Bidding.productName +
                  "\nWeight : " +
                  Bidding.weight +
                  "\nTotal Amount : " +
                  Bidding.totalAmount,
              };

              transporter.sendMail(mailOptions, (error, info) => {
                if (error) {
                  console.error("Error:", error);
                  return res
                    .status(500)
                    .json({ Status: "Error sending email" });
                } else {
                  console.log("Email sent:", info.response);
                  return res.status(200).json({ Status: "Success" });
                }
              });
            } catch (error) {
              console.error("Error:", error);
              return res.status(500).json({ Status: "Internal Server Error" });
            }

            return res.json(Bidding);
          })
          .catch((err) => {
            console.log({ status: "Error", err });
            return res.json({ status: "Error", err });
          });
      }
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });
};

export const rejectBidding = async (req, res) => {
  const { farmerUserName, productName } = req.params;

  Bidding.find({
    $and: [
      { farmerUserName: farmerUserName },
      { productName: productName },
      { status: "pending" },
      {
        creationDateTime: {
          $gte: moment().startOf("day").toDate(),
          $lt: moment().endOf("day").toDate(),
        },
      },
    ],
  })
    .then((bidding) => {
      if (!bidding) return res.json({ status: "No bidding found" });
      else {
        const updatedBidding = bidding.map((bid) => {
          bid.status = "rejected";
          return bid.save();
        });

        Promise.all(updatedBidding)
          .then((updatedBids) => {
            return res.json(updatedBids);
          })
          .catch((err) => {
            console.log({ status: "Error", err });
            return res.json({ status: "Error", err });
          });
      }
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });
};

export const expireBidding = async (req, res) => {
  Bidding.find({
    $and: [
      { status: "pending" },
      {
        creationDateTime: {
          $gte: moment().startOf("day").toDate(),
          $lt: moment().endOf("day").toDate(),
        },
      },
    ],
  })
    .then((bidding) => {
      if (!bidding) return res.json({ status: "No bidding found" });
      else {
        const updatedBidding = bidding.map((bid) => {
          bid.status = "expired";
          return bid.save();
        });

        Promise.all(updatedBidding)
          .then((updatedBids) => {
            return res.json(updatedBids);
          })
          .catch((err) => {
            console.log({ status: "Error", err });
            return res.json({ status: "Error", err });
          });
      }
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });
};
