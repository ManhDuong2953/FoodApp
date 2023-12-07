import { userLogin, userSignup,getUserByID, postUpdateUserInfo } from '../../controllers/users/user.controller';

export default function UserRouter(app) {
    app.post("/login", userLogin);
    app.post("/signup", userSignup);
    app.get("/info/:id", getUserByID);
    app.post("/update/info", postUpdateUserInfo);
    return app;
}