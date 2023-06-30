const express = require("express");
const router = express.Router();
const nodemailer = require("nodemailer");
const otpData = require("../temporarydata");
const asyncHandler = require("express-async-handler");
const User = require("../models/userModel");
const csrf = require("csurf");
// Định nghĩa router POST để nhận API và gửi email
router.post(
    "/sendemail",
    asyncHandler(async(req, res) => {
        const { email } = req.body;
        const user = await User.findOne({ email });
        if (!user) {
            res.status(400).send();
        } else {
            const transporter = nodemailer.createTransport({
                service: "gmail",
                auth: {
                    user: "tracnghiemlaptrinhcaothang@gmail.com",
                    pass: "cjbckrgapzavlzjr",
                },
            });
            otp = generateOTP(6);
            otpData[email] = { otp };
            console.log(otpData);
            setTimeout(() => {
                delete otpData[email];
                console.log(otpData);
            }, 300000);
            const mailOptions = {
                from: "hi@gmail.com",
                to: email,
                subject: "Test Email",
                text: `Your OTP is : ${otp} `,
            };

            // Gửi email
            const info = await transporter.sendMail(mailOptions);
            console.log("Email sent: " + info.response);
            return res.status(200).json({ message: "Email sent successfully" });
        }
    })
);
router.get(
    "/checkotp", csrf({ cookie: true }),
    asyncHandler(async(req, res) => {
        const { email, otp } = req.query;
        console.log(email, otp);
        // Kiểm tra xem email và OTP có tồn tại trong otpData hay không
        if (otpData[email]) {
            console.log("ok");
            console.log(otpData[email].otp);
            const storedOTP = otpData[email].otp;

            if (otp == storedOTP) {
                delete otpData[email];
                res.render("repassword", { email: email, csrfToken: req.csrfToken() });
                // return res.status(200).json({ message: "OTP is valid" });
            } else {
                return res.status(400).json({ message: "Invalid OTP" });
            }
        } else {
            return res.status(400).json({ message: "OTP does not exist" });
        }
    })
);

function generateOTP(length) {
    const characters =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    let otp = "";

    for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * characters.length);
        otp += characters.charAt(randomIndex);
    }

    return otp;
}
module.exports = router;