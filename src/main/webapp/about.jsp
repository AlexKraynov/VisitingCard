<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>AlexKraynov.Ru: обо мне</title>
        <link rel="shortcut icon" href="RESOURCES/IMAGES/java.png" type="image/png">
        <style>
            <%@include file="RESOURCES/CSS/main.css"%>
        </style> 
    </head>
    <body>
        <div id="page-shadow">
            <div id="page">
                <div id="lang">
                    <table>
                        <tr>
                            <td class="current"><a href="about.jsp">Русский</a></td>
                            <td>|</td>
                            <td><a href="about_en.jsp">English</a></td>
                        </tr>
                    </table>
                </div>
                <div class="content-innertube">
                    <div id="header">
                        <h1>Крайнов Александр</h1>

                        <ul id="main-nav">
                            <li><a href="index.jsp">О сайте</a></li>
                            <li class="current"><a href="about.jsp">Обо мне</a></li>
                            <li><a href="project.jsp">Проект(ы)</a></li>
                        </ul>
                        <div class="clear"></div>                       
                    </div><!-- header end -->

                    <div id="content">
                        <img id="avatar" src="RESOURCES/IMAGES/avatar.jpg">
                        <p></p>
                    </div><!-- content end -->  
                </div><!-- content-innertube end -->

                <div class="clear"></div>

                <div id="footer">
                    <div id="footer-innertube">
                        <div id="footer-address">
                            <h5>Адрес</h5>
                            <ul>
                                <li>Санкт-Петербург</li>
                                <li>Приморский район</li>
                            </ul>
                        </div><!-- footer-address end -->

                        <div id="footer-contact">
                            <h5>Контакты</h5>
                            <ul>
                                <li>+7 (921) 942-57-94</li>
                                <li><a href="mailto:lucky_1305@mail.ru">lucky_1305@mail.ru</a></li>
                            </ul>
                        </div><!-- footer-contact end -->

                        <div id="footer-social">
                            <h5>Я в интернете</h5>
                            <ul>
                                <li><a href="https://vk.com/id71436269" target="blank"><img src="RESOURCES/IMAGES/vkontakte.png" alt="vcontace"></a></li>
                                <li><a href="https://www.facebook.com/profile.php?id=100009932083825" target="blank"><img src="RESOURCES/IMAGES/facebook.png" alt="facebook"></a></li>
                            </ul>
                        </div><!-- footer-social end -->

                        <div id="footer-resume">
                            <h5>Мое резюме</h5>
                            <div id="download-resume"><a href="RESOURCES/DOCS/cv.pdf" target="blank"></a></div>
                        </div><!-- footer-resume end -->

                        <div class="clear"></div>

                    </div><!-- footer-innertube end -->
                </div><!-- footer end -->
            </div><!-- page end -->
        </div><!-- page-shadow end -->
    </body>
</html>