import { userLogin, userSignup,getUserByID } from '../../controllers/users/user.controller';

export default function UserRouter(app) {
    app.post("/login", userLogin);
    app.post("/signup", userSignup);
    app.get("/:id", getUserByID);
    return app;
}