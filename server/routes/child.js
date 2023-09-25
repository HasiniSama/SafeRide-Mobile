import express from "express";
import { create, index, getChildrenByParentId, show, update, destroy } from "../controllers/child.js";

const router = express.Router();

/**
 * @swagger
 * components:
 *   schemas:
 *     Child:
 *       type: object
 *       required:
 *         - name
 *         - parentId
 *       properties:
 *         id:
 *           type: string
 *           format: mongoose.Types.ObjectId
 *         name:
 *           type: string
 *         parentId:
 *           type: string
 *           format: mongoose.Types.ObjectId
 */

/**
 * @swagger
 * /child/:
 *   post:
 *     summary: Create a new Child.
 *     tags: [Child]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Child'
 *     responses:
 *       '201':
 *         description: Successful response.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Child'
 *             example:
 *               id: "6123456789abcdef01234567"
 *               name: "John Doe"
 *               parentId: "6123456789abcdef01234567"
 *       '500':
 *         description: Server error
 * 
 *   get:
 *     summary: Get all Children.
 *     tags: [Child]
 *     responses:
 *       '200':
 *         description: Successful response.
 *         content:
 *           application/json:
 *             schema:
 *               type: array   // Change to array type
 *               items:
 *                 $ref: '#/components/schemas/Child'
 *             example:
 *               - id: "6123456789abcdef01234567"
 *                 name: "John Doe"
 *                 parentId: "6123456789abcdef01234567"
 *               - id: "6123456789abcdef01234568"
 *                 name: "Jane Doe"
 *                 parentId: "6123456789abcdef01234567"
 *       '500':
 *         description: Server error
 * 
 * /child/{id}:
 *   get:
 *     summary: Get a Child by ID.
 *     tags: [Child]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The ID of the Child to retrieve.
 *     responses:
 *       '200':
 *         description: Successful response.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Child'
 *             example:
 *               id: "6123456789abcdef01234567"
 *               name: "John Doe"
 *               parentId: "6123456789abcdef01234567"
 *       '404':
 *         description: Child not found.
 *       '500':
 *         description: Server error
 *   put:
 *     summary: Update a Child by ID.
 *     tags: [Child]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The ID of the Child to update.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Child'
 *     responses:
 *       '200':
 *         description: Successful response.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Child'
 *             example:
 *               id: "6123456789abcdef01234567"
 *               name: "Updated Name"
 *               parentId: "6123456789abcdef01234567"
 *       '404':
 *         description: Child not found.
 *       '500':
 *         description: Server error
 *   delete:
 *     summary: Delete a Child by ID.
 *     tags: [Child]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The ID of the Child to delete.
 *     responses:
 *       '204':
 *         description: Successful response (no content).
 *       '404':
 *         description: Child not found.
 *       '500':
 *         description: Server error
 * /child/parentId/{id}:
 *   get:
 *     summary: Get Children by Parent ID.
 *     tags: [Child]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The ID of the Parent to retrieve relevant Children.
 *     responses:
 *       '200':
 *         description: Successful response.
 *         content:
 *           application/json:
 *             schema:
 *              type: array
 *              items:
 *                  $ref: '#/components/schemas/Child'
 *             example:
 *               - id: "6123456789abcdef01234567"
 *                 name: "John Doe"
 *                 parentId: "6123456789abcdef01234567"
 *               - id: "6123456789abcdef01234568"
 *                 name: "Jane Doe"
 *                 parentId: "6123456789abcdef01234567"
 *       '404':
 *         description: Child not found.
 *       '500':
 *         description: Server error
 */

router.post("/", create);
router.get("/", index);
router.get("/parentId/:parentId", getChildrenByParentId)
router.get("/:id", show);
router.put("/:id", update);
router.delete("/:id", destroy);

export default router;
