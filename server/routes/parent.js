import express from "express";
import { create, index, show, update, destroy } from "../controllers/parent.js";

const router = express.Router();

/**
 * @swagger
 * components:
 *   schemas:
 *     Parent:
 *       type: object
 *       required:
 *         - name
 *         - email
 *       properties:
 *         id:
 *           type: string
 *           format: mongoose.Types.ObjectId
 *         name:
 *           type: string
 *         email:
 *           type: string
 */

/**
 * @swagger
 * /parent/:
 *   post:
 *     summary: Create a new Parent.
 *     tags: [Parent]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Parent'
 *     responses:
 *       '201':
 *         description: Successful response.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Parent'
 *             example:
 *               id: "6123456789abcdef01234567"
 *               name: "John Doe"
 *               email: "johndoe@example.com"
 *       '500':
 *         description: Server error
 * 
 *   get:
 *     summary: Get all Parents.
 *     tags: [Parent]
 *     responses:
 *       '200':
 *         description: Successful response.
 *         content:
 *           application/json:
 *             schema:
 *               type: array   // Change to array type
 *               items:
 *                 $ref: '#/components/schemas/Parent'
 *             example:
 *               - id: "6123456789abcdef01234567"
 *                 name: "John Doe"
 *                 email: "johndoe@example.com"
 *               - id: "6123456789abcdef01234568"
 *                 name: "Jane Doe"
 *                 email: "janedoe@example.com"
 *       '500':
 *         description: Server error
 * 
 * /parent/{id}:
 *   get:
 *     summary: Get a Parent by ID.
 *     tags: [Parent]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The ID of the Parent to retrieve.
 *     responses:
 *       '200':
 *         description: Successful response.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Parent'
 *             example:
 *               id: "6123456789abcdef01234567"
 *               name: "John Doe"
 *               email: "johndoe@example.com"
 *       '404':
 *         description: Parent not found.
 *       '500':
 *         description: Server error
 *   put:
 *     summary: Update a Parent by ID.
 *     tags: [Parent]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The ID of the Parent to update.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Parent'
 *     responses:
 *       '200':
 *         description: Successful response.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Parent'
 *             example:
 *               id: "6123456789abcdef01234567"
 *               name: "Updated Name"
 *               email: "updated@example.com"
 *       '404':
 *         description: Parent not found.
 *       '500':
 *         description: Server error
 *   delete:
 *     summary: Delete a Parent and relevant Children by Parent ID.
 *     tags: [Parent]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: string
 *         required: true
 *         description: The ID of the Parent to delete.
 *     responses:
 *       '204':
 *         description: Successful response (no content).
 *       '404':
 *         description: Parent not found.
 *       '500':
 *         description: Server error
 */

router.post("/", create);
router.get("/", index);
router.get("/:id", show);
router.put("/:id", update);
router.delete("/:id", destroy);

export default router;
