import express from 'express';
import bcrypt from 'bcryptjs';
import User from '../models/users.js';

const router = express.Router();

// Crear usuario (POST)
router.post('/agrege', async (req, res) => {
    try {
        const { nombre, email, password } = req.body;
        if (!nombre || !email || !password) {
            return res.status(400).json({ msg: 'Todos los campos son requeridos' });
        }

        // Verificar si el email ya está registrado
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(409).json({ msg: 'El email ya está registrado' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const newUser = new User({ nombre, email, password: hashedPassword });

        await newUser.save();
        res.status(200).json({ msg: 'Usuario creado exitosamente' });
    } catch (error) {
        res.status(500).json({ msg: 'Error al crear usuario' });
    }
});

// Obtener todos los usuarios (GET)
router.get('/liste', async (req, res) => {
    const users = await User.find();
    res.json(users);
});

// Obtener un usuario (GET)
router.get('/liste:id', async (req, res) => {
    const user = await User.findById(req.params.id);
    if (!user) return res.status(404).json({ msg: 'Usuario no encontrado' });
    res.json(user);
});

// Actualizar usuario (PUT)
router.put('/actualice/:id', async (req, res) => {
    const updatedUser = await User.findByIdAndUpdate(req.params.id, req.body, { new: true });
    res.json(updatedUser);
});

// Eliminar usuario (DELETE)
router.delete('/elimine/:id', async (req, res) => {
    await User.findByIdAndDelete(req.params.id);
    res.json({ msg: 'Usuario eliminado' });
});

// Endpoint de login (POST)
router.post('/login', async (req, res) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            return res.status(400).json({ msg: 'Email y password son requeridos' });
        }

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(401).json({ msg: 'Credenciales inválidas' });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).json({ msg: 'Credenciales inválidas' });
        }

        // Opcional: devolver solo datos públicos del usuario
        res.status(200).json({
            msg: 'Login exitoso',
            user: {
                id: user._id,
                nombre: user.nombre,
                email: user.email
            }
        });
    } catch (error) {
        res.status(500).json({ msg: 'Error en el login', error });
    }
});

export default router;
