import UserRouter from './users/user.router';
import FoodRouter from './foods/food.router';
import express from 'express';
const router = express.Router();

export default function RouterMain(app){
    app.use("/users", UserRouter(router));
    app.use("/foods", FoodRouter(router));
    return app;
}