/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Login;

import database.DatabaseCon;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Rohith Reddy
 */
public class LoginValidation {
    public int LoginValidate(String username,String password,String login_as){
        int ID=0;
        try {
            String pass=md5encryption.Md5Encryption.encrypt(password);
            try {
                DatabaseCon db=new DatabaseCon();
                Connection con=db.getConnection();
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery("select * from bec_"+login_as+" where Name='"+username+"'");
                while(rs.next()){
                    ID=rs.getInt(1);
                }
                
            } catch (SQLException ex) {
                Logger.getLogger(LoginValidation.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        } catch (Exception ex) {
            Logger.getLogger(LoginValidation.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ID;
    }    
}
