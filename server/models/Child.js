import mongoose from "mongoose";

const childSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    parentId: {
        type: mongoose.Types.ObjectId,
        required: true
    }
});

const Child = mongoose.model("Child", childSchema);
export default Child;