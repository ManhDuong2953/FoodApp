import pool from "../../../configs/database/database.config";
class Reviews {
    static listReviews = async (id) => {
        try {
            const sql = "SELECT * FROM reviews WHERE food_id = ? ";
            const [result] = await pool.query(sql, [id]);
            if (result.length > 0) {
                return result;
            } else {
                return false;
            }
        } catch (error) {
            return false;
        }
    }

    static uploadReviews = async (params) => {
        try {
            const sql = "INSERT INTO Reviews (food_id, user_id, comment, rate) VALUES (?,?,?,?);";
            await pool.query(sql, [params.food_id, params.user_id, params.comment, params.rate]);
            return true;
            
        } catch (error) {
            return false;
        }
    }
}
export default Reviews;