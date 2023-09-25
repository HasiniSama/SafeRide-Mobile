import mongoose from "mongoose";

const parentSchema = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        unique: true
    },
})

const Parent = mongoose.model("Parent", parentSchema);
export default Parent;