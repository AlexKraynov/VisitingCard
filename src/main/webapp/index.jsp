<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>AlexKraynov</title>
        <link rel="shortcut icon" href="RESOURCES/IMAGES/java.png" type="image/png">
        <style>
            <%@include file="RESOURCES/CSS/global.css"%>
        </style>
<!--        <script>
            document.write(screen.availWidth +" x " + screen.availHeight);
        </script>-->
        <select id="lang" onchange="getOption()">
            <option value="rus" selected="selected">RUS</option>
            <option value="eng">ENG</option>
        </select>
        <img src="RESOURCES/IMAGES/ru.png">  
        <script type="text/javascript">
            function getOption() {
                var langChoice = document.getElementById("lang");
                var selIndex = langChoice.options.selectedIndex;
                var txt = langChoice.options[selIndex].text;
                if(txt === "ENG"){
//                    document.getElementById("a").innerHTML = (txt);
                    document.location.replace("index_eng.jsp");
                }    
            }
        </script>     
    </head>
    <body>  
        <div id="container">  
            <div id="header">
                <!--<p>-->
                    <img id="avatar" 
                         src="RESOURCES/IMAGES/avatar.jpg" 
                         height="100%" 
                         align="middle">
                    Крайнов Александр Борисович
                <!--</p>-->
            </div>

            <div id="navigation">
            </div>

            <div id="menu">
                <p><a href="about.jsp" target="browse">О себе<a></p>
                <p><a href="education.jsp" target="browse">Образование<a></p>
                <p><a href="expertise.jsp" target="browse">Профессиональный опыт<a></p>
                <p><a href="contacts.jsp" target="browse">Контакты<a></p>
                <br>
                <br>
                <a href="${pageContext.request.contextPath}/servlet/GlossaryServlet">Словарь</a>
            </div>
               
            <div id="content">
                <iframe id="browse" name="browse" height="385" width="845" src="about.jsp">                  
                </iframe>
            </div>

            <div id="clear">
            </div>

            <div id="footer">
                <a href="https://vk.com/id71436269" target="_blank">
                    <img src="RESOURCES/IMAGES/vkontakte.png" height="100%">
                </a>
                <a href="https://www.facebook.com/profile.php?id=100009932083825" target="_blank">
                    <img src="RESOURCES/IMAGES/facebook.png" height="100%">
                </a>
            </div>
        </div>      
    </body>
</html>