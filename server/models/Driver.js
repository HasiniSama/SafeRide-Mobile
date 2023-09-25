import mongoose from "mongoose";

const driverSchema = mongoose.Schema({
    name: {
        type: String,
        required: true
    }
});

const User = mongoose.model("Driver", driverSchema);
export default User;