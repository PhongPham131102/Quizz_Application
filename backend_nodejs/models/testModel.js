const mongoose = require("mongoose");
const testSchema = mongoose.Schema({
    uid: {
        type: String,
        require: true,
    },
    heading: {
        type: String,
        require: true,
    },
    testTheme: {
        type: String,
        require: true,
    },
    typePost: {
        type: String,
        require: true,
    },
    listQuestions: {
        type: [String],
        require: true,
    },
}, {
    timestamps: true,
});
module.exports = mongoose.model("Test", testSchema);