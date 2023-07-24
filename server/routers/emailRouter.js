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
                from: "tracnghiemlaptrinhcaothang@gmail.com",
                to: email,
                subject: "Mã khôi phục tài khoản Quizziz của bạn",
                html: `<div style="display: flex; justify-content: center; align-items: center; height: 100vh;">
                <form style="min-width: 200px; padding: 20px;">
                    <div style="display: flex; margin: 0 auto; justify-content: center;">
                     </div>
                    <div style="padding-top: 20px;">
                        <p style="color: #1E1E1E; font-size: 20px; font-style: normal; font-weight: 400; padding-bottom: 30px;">
                            Chúng tôi đã nhận được yêu cầu đặt lại Mật khẩu của bạn.<br>
                            Nhập mã đặt lại mật khẩu sau đây:
                        </p>
                        <div>
                            <p  style="color: #1E1E1E; font-size:32px; font-weight: 700;">${otp}</p>
                        </div>
                        <p style="color: #1E1E1E; font-size: 20px; font-style: normal; font-weight: 400;">
                            Bạn đã không yêu cầu thay đổi này?<br>
                            Nếu bạn không yêu cầu mật khẩu mới, hãy cho chúng tôi biết:
                        </p>
                    </div>
                    <div style="display: flex; justify-content: center; align-items: center; padding-top: 20px;">
                        <hr>
                        <div style="display: flex; flex-direction: column; align-items: center; color: #7E7A7A; font-size: 15px; font-weight: 400;">
                            <p style="color: #218806; font-size: 22px; font-weight: 700;">Trắc Nghiệm Lập Trình</p>
                            <p>@PM20C, 65 Huỳnh Thúc Kháng, Quận 1, Tp.Hồ Chí Minh</p>
                            <p>Thư này được gửi đến ${email}.</p>
                            <p>Để bảo vệ tài khoản của bạn, vui lòng không chuyển tiếp email này.</p>
                        </div>
                    </div>
                </form>
            </div>`,
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