import Child from "../models/Child.js"

export const create = async (req, res) => {
    const { name, parentId } = req.body;
    try {
        const newChild = await Child.create({ name, parentId });
        res.status(201).json({ message: "Success", data: newChild });
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
}

export const index = async (req, res) => {
    try {
        const allChildren = await Child.find();
        res.status(200).json({ message: "Success", data: allChildren });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

export const show = async (req, res) => {
    const { id } = req.params;
    try {
        const child = await Child.findById(id);
        res.status(200).json({ message: "Success", data: child });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

export const getChildrenByParentId = async (req, res) => {
    const { parentId } = req.params;
    try {
        const children = await Child.find({ parentId: parentId });
        if (!children) {
            res.status(200).json({ message: "There is no children for this parentId" });
        }
        res.status(200).json({ message: "Success", data: children });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

export const update = async (req, res) => {
    const { id } = req.params;
    const { name, parentId } = req.body;

    try {
        const updatedChild = await Child.findByIdAndUpdate(id, { name, parentId }, { new: true });

        if (!updatedChild) {
            return res.status(404).json({ error: "Child not found" });
        }

        res.status(200).json({ message: "Success", data: updatedChild });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

}

export const destroy = async (req, res) => {
    const { id } = req.params;
    try {
        await Child.findByIdAndDelete(id);
        res.status(200).json({ message: "Child deleted Successfully!" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}