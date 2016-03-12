<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>AlexKraynov</title>
        <link rel="shortcut icon" href="RESOURCES/IMAGES/ic_launcher.png" type="image/png">
        <style>
            <%@include file="RESOURCES/CSS/global.css"%>
        </style>
        <select id="lang" onchange="getOption()">
            <option value="rus">RUS</option>
            <option value="eng" selected="selected">ENG</option>
        </select>
        <img src="RESOURCES/IMAGES/gb.png" >   
        <script type="text/javascript">
            function getOption() {
                var langChoice = document.getElementById("lang");
                var selIndex = langChoice.options.selectedIndex;
                var txt = langChoice.options[selIndex].text;
                if(txt == "RUS"){
                    document.location.replace("index.jsp");
                }    
            }
        </script>     
    </head>
    <body>
        <div id="container">  
            <div id="header">
                <img id="avatar" src="RESOURCES/IMAGES/avatar.jpg" height="26.5%">
            </div>

            <div id="navigation">
            </div>

            <div id="menu">
                <p><a href="">About me<a></p>
                <p><a href="">Education<a></p>
                <a href="">Career history<a>         
            </div>

            <div id="content">
            </div>

            <div id="clear">
            </div>

            <div id="footer">
            </div>
        </div>
    </body>
</html>