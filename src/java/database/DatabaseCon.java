/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Rohith Reddy
 */
public class DatabaseCon {
    public Connection getConnection()
        {
            String url= "localhost/bec";
            String id= "root";
            String pass = "admin";
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con=DriverManager.getConnection("jdbc:mysql://"+url,id,pass);
                return con;           
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(ex.getMessage());
            }
            return null;
        }
    public String getCreateStmt(String Name){
        return "CREATE TABLE "+Name+"(id int(11) NOT NULL AUTO_INCREMENT,"+
              "Date varchar(10) DEFAULT NULL,"+
              "p1 int(11) DEFAULT '2',"+
              "p2 int(11) DEFAULT '2',"+
              "p3 int(11) DEFAULT '2',"+
              "p4 int(11) DEFAULT '2',"+
              "p5 int(11) DEFAULT '2',"+
              "p6 int(11) DEFAULT '2',"+
              "p7 int(11) DEFAULT '2',"+
              "p8 int(11) DEFAULT '2',"+
              "p9 int(11) DEFAULT '2',"+
              "PRIMARY KEY (id),"+
              "UNIQUE KEY id_UNIQUE (id)"+
            ") AUTO_INCREMENT=2 DEFAULT CHARSET=utf8";
    }
    public String CreateClassTable(String ClassName){
        return "CREATE TABLE "+ClassName+"(id int(11) NOT NULL AUTO_INCREMENT,"+
              "Date varchar(10) DEFAULT NULL,"+
              "p1 int(11) DEFAULT '0',"+
              "p2 int(11) DEFAULT '0',"+
              "p3 int(11) DEFAULT '0',"+
              "p4 int(11) DEFAULT '0',"+
              "p5 int(11) DEFAULT '0',"+
              "p6 int(11) DEFAULT '0',"+
              "p7 int(11) DEFAULT '0',"+
              "p8 int(11) DEFAULT '0',"+
              "p9 int(11) DEFAULT '0',"+
              "PRIMARY KEY (id),"+
              "UNIQUE KEY id_UNIQUE (id)"+
            ") AUTO_INCREMENT=2 DEFAULT CHARSET=utf8";
    }
}
