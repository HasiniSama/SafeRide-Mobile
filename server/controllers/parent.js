import Child from "../models/Child.js";
import Parent from "../models/Parent.js"

export const create = async (req, res) => {
    const { name, email } = req.body;
    try {
        const newParent = await Parent.create({ name, email });
        res.status(201).json({ message: "Success", data: newParent });
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
}

export const index = async (req, res) => {
    try {
        const allParents = await Parent.find();
        res.status(200).json({ message: "Success", data: allParents });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

export const show = async (req, res) => {
    const { id } = req.params;
    try {
        const parent = await Parent.findById(id);
        res.status(200).json({ message: "Success", data: parent });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

export const update = async (req, res) => {
    const { id } = req.params;
    const { name, email } = req.body;

    try {
        const updatedParent = await Parent.findByIdAndUpdate(id, { name, email }, { new: true });

        if (!updatedParent) {
            return res.status(404).json({ error: "Parent not found" });
        }

        res.status(200).json({ message: "Success", data: updatedParent });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

}

export const destroy = async (req, res) => {
    const { id } = req.params;
    try {
        await Parent.findByIdAndDelete(id);
        await Child.deleteMany({ parentId: id })
        res.status(200).json({ message: "Parent deleted Successfully" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}