<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Glossary</title>
        <script type="text/javascript"  
                src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js">
        </script>
        <script type="text/javascript">
            var ajaxRequest;  // The variable that makes Ajax possible!
            function ajaxFunction() {
                try {
                    // Opera 8.0+, Firefox, Safari
                    ajaxRequest = new XMLHttpRequest();
                } catch (e) {

                    // Internet Explorer Browsers
                    try {
                        ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
                    } catch (e) {

                        try {
                            ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (e) {

                            // Something went wrong
                            alert("Your browser broke!");
                            return false;
                        }
                    }
                }
            }
            function ajaxSearch() {
                ajaxFunction();

                // Here processRequest() is the callback function.
                ajaxRequest.onreadystatechange = processRequest;

                var target = document.getElementById("search");
                var url = "${pageContext.request.contextPath}/servlet/AJAXServlet?search="
                        + encodeURIComponent(target.value);

                ajaxRequest.open("GET", url, true);
                ajaxRequest.send(null);
            }
            function processRequest() {
                if (ajaxRequest.readyState === 4) {
                    if (ajaxRequest.status === 200) {
                        var json = JSON.parse(ajaxRequest.responseText);
                        $("#results").empty();
                        for (i = 0; i < json.length; i++) {
                            $("#results").append(json[i].num + " " + json[i].name + "<br>");
                        }
                    }
                }
            }
        </script>  
    </head>
    <body>      
        Поле для ввода:
        <table>
            <th><input id="search" type="text" size="50"/></th>
            <th><p><input type="button" id="find" value="Поиск" onclick="ajaxSearch()"/></p></th>
        </table>
        <div id="results"></div>
    </body>
</html>
