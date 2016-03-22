<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Glossary</title>
        <script type="text/javascript"  
                src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">
        </script>
        <style>
            #result{
                display:none;
                width: 350px;
                /*background-color: rgb(80, 80, 114);*/
                /*color: rgb(255, 227, 189);*/
                -moz-opacity: 0.95;
                opacity: 0.95;
                -ms-filter: progid:DXImageTransform.Microsoft.Alpha(opacity=95);
                filter: progid:DXImageTransform.Microsoft.Alpha(opacity=95);
                filter: alpha(opacity=95);
                z-index: 999;
                position: absolute;
                top: 70px; left: 10px;
            }
            #result .advice_variant{
                cursor: pointer;
                padding: 5px;
                text-align: left;
                background-color: white;
            }
            #result .advice_variant:hover{
                background-color: #DBDBDB;
            }
            #result .active{
                cursor: pointer;
                padding: 5px;
                background-color: #DBDBDB;
            }
        </style>
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
                        suggest_count = json.length;
                        $("#result").html("").show();
                        for (i = 0; i < json.length; i++) {
                            $("#result").append('<div class="advice_variant">' + json[i].name + '</div>');
                        }
//                        $("#id").empty();
//                        $("#name").empty();
//                        for (i = 0; i < json.length; i++) {
//                            $("#id").append(json[i].id + "<br>");
//                            $("#name").append(json[i].name + "<br>");
//                        }
                    }
                }
            }

            function ajaxSearch1() {
                ajaxFunction();

                // Here processRequest() is the callback function.
                ajaxRequest.onreadystatechange = processRequest1;

                var target = document.getElementById("search");
                var url = "${pageContext.request.contextPath}/servlet/AJAXServlet?search="
                        + encodeURIComponent(target.value);

                ajaxRequest.open("GET", url, true);
                ajaxRequest.send(null);
            }
            function processRequest1() {
                if (ajaxRequest.readyState === 4) {
                    if (ajaxRequest.status === 200) {
                        var json = JSON.parse(ajaxRequest.responseText);
                        $("#id").empty();
                        $("#name").empty();
                        for (i = 0; i < json.length; i++) {
                            $("#id").append(json[i].id + "<br>");
                            $("#name").append(json[i].name + "<br>");
                        }
                    }
                }
            }
        </script>    
        <script type="text/javascript">
            var suggest_count = 0;
            var input_initial_value = "";
            var suggest_selected = 0;
            $(document).ready(function () {
                $("#search").keyup(function (event) {
                    switch (event.keyCode) {
                        // игнорируем нажатия на эти клавишы
                        case 13:  // enter
                        case 27:  // escape
                        case 38:  // стрелка вверх
                        case 40:  // стрелка вниз
                            break;

                        default:
                            if ($(this).val().length >= 1) {
                                ajaxSearch();
//                                alert(ajaxRequest.responseText);
//                                $("#result").html("").show();
//                                for (i = 0; i < list.length; i++) {
//                                    $("#result").append('<div class="advice_variant">' + list[i].name + '</div>');
//                                }
//                                $("#result").append('<div class="advice_variant">' + '0000000000000000' + '</div>');
//                                $("#result").append('<div class="advice_variant">' + '1111111111111111' + '</div>');
//                                $("#result").append('<div class="advice_variant">' + '2222222222222222' + '</div>');
//                                suggest_count = list.length;
                            } else {
                                $("#result").html("").hide();
                            }
                            break;
                    }
                });

                $("#search").on("keydown", function (event) {
                    switch (event.keyCode) {
                        // по нажатию клавишь прячем подсказку
                        case 13: // enter
                            ajaxSearch1();
                        case 27: // escape
                            $("#result").hide();
                            return false;
                            break;
                            // делаем переход по подсказке стрелочками клавиатуры
                        case 38: // стрелка вверх
                        case 40: // стрелка вниз
                            event.preventDefault();
                            if (suggest_count) {
                                //делаем выделение пунктов в слое, переход по стрелочкам
                                key_activate(event.keyCode - 39);
                            }
                            break;
                    }
                });

                $(".advice_variant").live("click", function () {
                    // ставим текст в input поиска
                    $("#search").val($(this).text());
                    // прячем слой подсказки
                    $("#result").fadeOut(350);
                    ajaxSearch1();
                });

                $("html").click(function () {
                    $("#result").hide();
                });

                $("#search").click(function (event) {
                    if (suggest_count)
                        $("#result").show();
                    event.stopPropagation();
                });
            });

            function key_activate(n) {
                $("#result div").eq(suggest_selected - 1).removeClass("active");

                if (n == 1 && suggest_selected < suggest_count) {
                    suggest_selected++;
                } else if (n == -1 && suggest_selected > 0) {
                    suggest_selected--;
                }

                if (suggest_selected > 0) {
                    $("#result div").eq(suggest_selected - 1).addClass("active");
                    $("#search").val($("#result div").eq(suggest_selected - 1).text());
                } else {
                    $("#search").val(input_initial_value);
                }
            }
        </script>
    </head>
    <body> 
        Поле для ввода:
        <table>
            <th><input id="search" type="text" size="50" autofocus="true" autocomplete="off"/></th>
            <th><p><input type="button" id="find" value="Поиск" onclick="ajaxSearch1()"/></p></th>
        </table>
        <div id="result"></div>
        <br>
        <table>
            <caption></caption>
            <tr>
                <td><div id="id"></div></td>
                <td><div id="name"></div></td>
            </tr>
        </table>
    </body>
</html>
