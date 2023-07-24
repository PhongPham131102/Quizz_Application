const mongoose = require("mongoose");
const userTemporarySchema = mongoose.Schema({
    fullName: {
        type: String,
        required: [true, "Please add the full name"],
    },
    email: {
        type: String,
        required: [true, "Please add the user email address"],
        unique: [true, "Email address already taken"],
    },
    password: {
        type: String,
        required: [true, "Please add the password"],
    },
}, {
    timestamps: true,
});
module.exports = mongoose.model("UserTemporary", userTemporarySchema);