import pool from "../../../configs/database/database.config";
class Orders {
    static listOrder = async (id) => {
        try {
            const sql = "SELECT * FROM orders WHERE user_id = ? ";
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

    static uploadOrder = async (params) => {
        try {
            const sql = "INSERT INTO Orders (food_id, user_id, quantity, total_price) VALUES (?,?,?,?);";
            await pool.query(sql, [params.food_id, params.user_id, params.quantity, params.total_price]);
            return true;
            
        } catch (error) {
            return false;
        }
    }
}
export default Orders;