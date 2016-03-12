package ru.alexkraynov.glossary.logic;

import java.io.IOException;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class Server {

    private static Server instance;
    private static Connection connection;

    private Server() {
        try {
//            Class.forName("com.mysql.jdbc.Driver");
//            String url = "jdbc:mysql://localhost:3306/2015301_1?zeroDateTimeBehavior=convertToNull";
//            connection = DriverManager.getConnection(url, "b2015301_1", "Hj9ptkqj");

            Class.forName("org.apache.derby.jdbc.ClientDriver");
            String url = "jdbc:derby://localhost:1527/example";
            connection = DriverManager.getConnection(url, "Alex", "1");
        } catch (SQLException | ClassNotFoundException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public static synchronized Server getInstance() {
        if (instance == null) {
            instance = new Server();
        }
        return instance;
    }

    public List getAllTable() throws SQLException {
        List strike = new ArrayList();
        Statement stmt = null;
        ResultSet rs = null;
        stmt = connection.createStatement();
        String sql = "SELECT * FROM example";
        rs = stmt.executeQuery(sql);
        while (rs.next()) {
            Glossary word = new Glossary();
            word.setNum(rs.getInt(1));
            word.setName(rs.getString(2));
            strike.add(word);
        }
        rs.close();
        stmt.close();
        return strike;
    }

    public List getAllTable(String line) throws SQLException {
        List strike = new ArrayList();
        Statement stmt = null;
        ResultSet rs = null;
        stmt = connection.createStatement();
        String sql = "SELECT * FROM example WHERE name='" + line + "'";
        rs = stmt.executeQuery(sql);
        while (rs.next()) {
            Glossary word = new Glossary();
            word.setNum(rs.getInt(1));
            word.setName(rs.getString(2));
            strike.add(word);
        }
        rs.close();
        stmt.close();
        return strike;
    }

    public String getGSONArray(String line) throws SQLException, IOException {
        JSONArray array = new JSONArray();
        Statement stmt = null;
        ResultSet rs = null;
        stmt = connection.createStatement();
        String sql = "SELECT * FROM example WHERE name='" + line + "'";
        rs = stmt.executeQuery(sql);
        
//        7890890
//        7890987078
//        789087907890

        while (rs.next()) {
            JSONObject obj = new JSONObject();
            obj.put("num", rs.getInt(1));
            obj.put("name", rs.getString(2).trim());
            array.add(obj);
        }

        StringWriter out = new StringWriter();
        array.writeJSONString(out);
        String jsonText = out.toString();

        rs.close();
        stmt.close();
        
        return jsonText;
    }

//    public List<Group> getAllGroups() throws SQLException {
//        List<Group> groups = new ArrayList<>();
//        Statement st = null;
//        ResultSet rs = null;
//        st = con.createStatement();
//        String sql = "SELECT * FROM division";
//        rs = st.executeQuery(sql);
//        while (rs.next()) {
//            Group g = new Group();
//            g.setGroupId(rs.getInt(1));
//            g.setGroupName(rs.getString(2));
//            g.setGroupHead(rs.getString(3));
//            groups.add(g);
//        }
//        if (rs != null) {
//            rs.close();
//        }
//        if (st != null) {
//            st.close();
//        }
//        return groups;
//    }
//    public Collection<Person> personsFromOneGroup(Group group) throws SQLException {
//        Collection groupPersons = new ArrayList();
//        PreparedStatement st = null;
//        ResultSet rs = null;
//        String sql = "SELECT * FROM person WHERE groupid=?";
//        st = con.prepareStatement(sql);
//        st.setInt(1, group.getGroupId());
//        rs = st.executeQuery();
//        while (rs.next()) {
//            Person p = new Person();
//            p.setPersonId(rs.getInt(1));
//            p.setGroupId(rs.getInt(2));
//            p.setSurName(rs.getString(3));
//            p.setFirstName(rs.getString(4));
//            p.setSecondName(rs.getString(5));
//            p.setBirthday(rs.getDate(6));
//            p.setNickLetter(rs.getString(7));
//            p.setNickNumber(rs.getInt(8));
//            p.setMail(rs.getString(9));
//            groupPersons.add(p);
//        }
//        if (rs != null) {
//            rs.close();
//        }
//        if (st != null) {
//            st.close();
//        }
//        return groupPersons;
//    }
//
//    public void addPerson(Person person) {
//        PreparedStatement st = null;
//        try {
//            String sql = "INSERT INTO person (groupid, "
//                    + "surname, "
//                    + "firstname, "
//                    + "secondname, "
//                    + "mail) "
//                    + "VALUES (?, ?, ?, ?, ?)";
//            st = con.prepareStatement(sql);
//            st.setInt(1, person.getGroupId());
//            st.setString(2, person.getSurName());
//            st.setString(3, person.getFirstName());
//            st.setString(4, person.getSecondName());
//            st.setString(5, person.getMail());
//            st.execute();
//            if (st != null) {
//                st.close();
//            }
//        } catch (SQLException ex) {
//            System.out.println(ex.getMessage());
//        }
//    }
//
//    public void editPerson(Person person) {
//        PreparedStatement st = null;
//        try {
//            String sql = "UPDATE person SET surname=?, "
//                    + "firstname=?, "
//                    + "secondname=?, "
//                    + "mail=? "
//                    + "WHERE personid=?";
//            st = con.prepareStatement(sql);
//            st.setString(1, person.getSurName());
//            st.setString(2, person.getFirstName());
//            st.setString(3, person.getSecondName());
//            st.setString(4, person.getMail());
//            st.setInt(5, person.getPersonId());
//            st.execute();
//            if (st != null) {
//                st.close();
//            }
//        } catch (SQLException ex) {
//            System.out.println(ex.getMessage());
//        }
//    }
//
//    public void delPerson(Person person) {
//        PreparedStatement st = null;
//        try {
//            String sql = "DELETE FROM person WHERE personid=?";
//            st = con.prepareStatement(sql);
//            st.setInt(1, person.getPersonId());
//            st.execute();
//            if (st != null) {
//                st.close();
//            }
//        } catch (SQLException ex) {
//            System.out.println(ex.getMessage());
//        }
//    }
//
//    public static void printString(Object o) {
//        System.out.println(o.toString());
//    }
}
