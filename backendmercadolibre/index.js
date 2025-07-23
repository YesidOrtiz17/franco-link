import express from 'express';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import userRoutes from './src/routes/user.js'; // Agrega esta línea

dotenv.config();

const app = express();

app.get('/', (req, res) => {
    res.send('Bienvenido a la API de Mercado Libre');
});

app.use(express.json());

app.use("/api", userRoutes);

const PORT = process.env.PORT || 9000;

app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));

mongoose.connect(process.env.MONGODB_URI)
    .then(() => console.log('MongoDB connected'))
    .catch(err => console.error('MongoDB connection error:', err));