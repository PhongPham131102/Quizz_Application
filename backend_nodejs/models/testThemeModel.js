const mongoose = require("mongoose");
const testThemeSchema = mongoose.Schema({
    uid: {
        type: String,
        require: true,
    },
    topic: {
        type: String,
        require: true,
    },
    parent: {
        type: String,
        default: "",
    }
}, {
    timestamps: true,
});
module.exports = mongoose.model("TestTheme", testThemeSchema);