<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AlexKraynov.Ru: project(s)</title>
        <link rel="shortcut icon" href="RESOURCES/IMAGES/java.png" type="image/png">
        <style>
            <%@include file="RESOURCES/CSS/main.css"%>
        </style>
        <script type="text/javascript"  
                src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">
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

            function ajaxLiveSearch() {
                ajaxFunction();

                // Here processRequest() is the callback function.
                ajaxRequest.onreadystatechange = callbackLiveSearch;

                var target = document.getElementById("search");
                var url = "${pageContext.request.contextPath}/servlet/LiveSearchServlet?search="
                        + encodeURIComponent(target.value);

                ajaxRequest.open("GET", url, true);
                ajaxRequest.send(null);
            }

            function callbackLiveSearch() {
                if (ajaxRequest.readyState === 4) {
                    if (ajaxRequest.status === 200) {
                        var json = JSON.parse(ajaxRequest.responseText);
                        suggest_count = json.length;
                        if (suggest_count > 0) {
                            $("#result").html("").show();
                            for (i = 0; i < suggest_count; i++) {
                                $("#result").append('<div class="advice_variant">' + json[i].name + '</div>');
                            }
                        }
                    }
                }
            }

            function ajaxGetValue() {
                if ($("#search").val() === "") {
                    $("#id").empty();
                    $("#name").empty();
                    $("#empty").html("").append("Введите слово или словосочетание");
                    $("#search").focus();
                    return;
                } else {
                    $("#empty").html("");
                }

                ajaxFunction();

                // Here processRequest() is the callback function.
                ajaxRequest.onreadystatechange = callbackGetValue;

                var target = document.getElementById("search");
                var url = "${pageContext.request.contextPath}/servlet/GetValueServlet?search="
                        + encodeURIComponent(target.value) + "&lang=EN";

                ajaxRequest.open("GET", url, true);
                ajaxRequest.send(null);
            }

            function callbackGetValue() {
                if (ajaxRequest.readyState === 4) {
                    if (ajaxRequest.status === 200) {
                        var json = JSON.parse(ajaxRequest.responseText);
                        suggest_count = json.length;
                        $("#id").empty();
                        $("#name").empty();
                        $("#search").focus();
                        $("#search").select();
                        if (json.length > 0) {
                            for (i = 0; i < json.length; i++) {
                                $("#id").append("<p>" + json[i].id + "</p>" + "<br>" + "<br>");
                                $("#name").append("<p>" + json[i].name + "</p>" + "<br>" + "<br>");
                            }
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
                                ajaxLiveSearch();
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
                            ajaxGetValue();
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
                    ajaxGetValue();
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
        <div id="page-shadow">
            <div id="page">
                <div id="lang">
                    <table>
                        <tr>
                            <td><a href="project.jsp">Русский</a></td>
                            <td>|</td>
                            <td class="current"><a href="project_en.jsp">English</a></td>
                        </tr>
                    </table>
                </div>
                <div class="content-innertube">
                    <div id="header">
                        <h1>Kraynov Aleksander</h1>

                        <ul id="main-nav">
                            <li><a href="index_en.jsp">About site</a></li>
                            <li><a href="about_en.jsp">About me</a></li>
                            <li class="current"><a href="project_en.jsp">Project(s)</a></li>
                        </ul>
                        <div class="clear"></div>                       
                    </div><!-- header end -->

                    <div id="content">
                        <div id="content-left">
                            <p>As my first web-application in Java, I chose development of the dictionary
                                by analogy with Multitran, which I often use.
                            </p>
                            <br>
                            <p>
                                The choice was not accidental - writing desktop-application of the dictionary was 
                                a condition of successful completion of the courses. There are also plans to 
                                develop a mobile version.
                            </p>
                            <br>
                            <p>
                                I did not and do not set ourselves the task to make full-fledged content
                                of the dictionary.
                            </p>
                            <br>
                            <p>
                                The main task of the project - the project itself and libraries, 
                                technologies and frameworks used in it:
                            </p>
                            <br>
                            <div align="center">
                                <ul>
                                    <li>MySQL</li>
                                    <li>Hibernate</li>
                                    <li>Java Servlet</li>
                                    <li>JSP</li>
                                    <li>JavaScript</li>
                                    <li>AJAX</li>
                                    <li>Maven</li>
                                </ul>
                            </div>
                        </div><!-- content-left end--> 
                        <div id="content-right">
                            <h6><b>Glossary</b></h6>
                            <br>
                            <br>
                            Input field:
                            <br>
                            <br>
                            <table>
                                <th><input id="search" type="text" placeholder="Java, Java SE, Java EE, Java ME, Java FX, Java Card" autofocus="true" autocomplete="off"/></th>
                                <th><p><input id="find" type="button" value="Поиск" onclick="ajaxGetValue()"/></p></th>
                            </table>
                            <div id="result"></div>
                            <br>
                            <table overflow="scroll">
                                <tr>
                                    <td nowrap><div id="id"></div></td>
                                    <td><div id="name"></div></td>
                                </tr>
                            </table>
                            <div id="empty"></div>
                        </div><!-- content-right end--> 
                    </div><!-- content end-->   
                </div><!-- content-innertube end--> 

                <div class="clear"></div>

                <div id="footer">
                    <div id="footer-innertube">
                        <div id="footer-address">
                            <h5>Address</h5>
                            <ul>
                                <li>Saint-Petersburg</li>
                            </ul>
                        </div><!--footer-address end--> 

                        <div id="footer-contact">
                            <h5>Contacts</h5>
                            <ul>
                                <li>+7 (921) 942-57-94</li>
                                <li><a href="mailto:lucky_1305@mail.ru">lucky_1305@mail.ru</a></li>
                            </ul>
                        </div><!--footer-contact end--> 

                        <div id="footer-social">
                            <h5>Social</h5>
                            <ul>
                                <li><a href="https://vk.com/id71436269" target="blank"><img src="RESOURCES/IMAGES/vkontakte.png" alt="vcontace"></a></li>
                                <li><a href="https://www.facebook.com/profile.php?id=100009932083825" target="blank"><img src="RESOURCES/IMAGES/facebook.png" alt="facebook"></a></li>
                            </ul>
                        </div><!-- footer-social end--> 

                        <div id="footer-resume">
                            <h5>Resume</h5>
                            <div id="download-resume"><a href="RESOURCES/DOCS/cv.pdf" target="blank"></a></div>
                        </div><!-- footer-resume end--> 

                        <div class="clear"></div>

                    </div><!--footer-innertube end--> 
                </div><!--footer end--> 
            </div><!-- page end -->
        </div><!-- page-shadow end -->
    </body>
</html>
