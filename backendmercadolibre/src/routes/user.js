import express from "express";
import bcrypt from "bcrypt";
import User from "../models/users.js";

const router = express.Router();

router.post("/users", async (req, res) => {
    try {
        const { name, email, password } = req.body;

        // Verifica si el usuario ya existe
        const existe = await User.findOne({ email });
        if (existe) {
            return res.status(400).json({ message: "El correo ya está registrado" });
        }

        // Hashear la contraseña
        const hashedPassword = await bcrypt.hash(password, 10);

        // Crear y guardar el nuevo usuario
        const newUser = new User({ name, email, password: hashedPassword });
        const savedUser = await newUser.save();

        res.status(201).json(savedUser);
    } catch (error) {
        console.error("Error al registrar usuario:", error.message);
        res.status(500).json({ message: "Error interno del servidor" });
    }});
router.get("/users/:id", (req, res) => {
    const { id } = req.params;
    userSchema
        .find()
        .then(data => res.json(data))
        .catch((error)=> res.json({ message: error}));

});
router.get("/users", async (req, res) => {
    try {
        const users = await User.find();
        res.json(users);
    } catch (error) {
        console.error("Error al obtener usuarios:", error.message);
        res.status(500).json({ message: "Error interno del servidor" });
    }
});
router.put("/users/:id", async (req, res) => {
    const { id } = req.params;
    const { name, email, password } = req.body;

    try {
        const updatedUser = await User.findByIdAndUpdate(
            id,
            { name, email, password },
            { new: true }
        );
        if (!updatedUser) {
            return res.status(404).json({ message: "Usuario no encontrado" });
        }
        res.json(updatedUser);
    } catch (error) {
        console.error("Error al actualizar usuario:", error.message);
        res.status(500).json({ message: "Error interno del servidor" });
    }
});
router.delete("/users/:id", async (req, res) => {
    const { id } = req.params;

    try {
        const deletedUser = await User.findByIdAndDelete(id);
        if (!deletedUser) {
            return res.status(404).json({ message: "Usuario no encontrado" });
        }
        res.json({ message: "Usuario eliminado exitosamente" });
    } catch (error) {
        console.error("Error al eliminar usuario:", error.message);
        res.status(500).json({ message: "Error interno del servidor" });
    }  
});

export default router;
