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
            + encodeURIComponent(target.value) + "&lang=RU";

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