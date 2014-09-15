// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

var chartData = {};

function legend(parent, data) {
    parent.className = 'legend';
    var datas = data.hasOwnProperty('datasets') ? data.datasets : data;

    // remove possible children of the parent
    while(parent.hasChildNodes()) {
        parent.removeChild(parent.lastChild);
    }

    datas.forEach(function(d) {
        var title = document.createElement('span');
        title.className = 'title';
        title.style.borderColor = d.hasOwnProperty('strokeColor') ? d.strokeColor : d.color;
        title.style.borderStyle = 'solid';
        parent.appendChild(title);

        var text = document.createTextNode(d.title);
        title.appendChild(text);
    });
}

var GetChartData = function () {
    $.ajax({
        url: '/infos.json',
        method: 'GET',
        dataType: 'json',
        success: function (d) {
           console.log(d);
           chartData = {
                labels: d["labels"],
                datasets: [
                    {
                        title: "Температура",
                        fillColor: "rgba(220,220,220,0.5)",
                        strokeColor: "rgba(220,220,220,1)",
                        pointColor: "rgba(220,220,220,1)",
                        pointStrokeColor: "#fff",
                        data: d["temps"]
                    },
                    {
                        title: "Влажность",
                        fillColor: "rgba(151,187,205,0.2)",
                        strokeColor: "rgba(151,187,205,1)",
                        pointColor: "rgba(151,187,205,1)",
                        pointStrokeColor: "#fff",
                        pointHighlightFill: "#fff",
                        pointHighlightStroke: "rgba(151,187,205,1)",
                        data: d["hums"]
                    }

                ]
            };
           legend(document.getElementById("lineLegend"), chartData);

        }
    });
};


function respondCanvas() {
    var c = $('#temp_chart');
    if (c.length > 0) {
        var ctx = c.get(0).getContext("2d");
        var container = c.parent();

        var $container = $(container);

        c.attr('width', $container.width()); //max width

        c.attr('height', $container.height()); //max height                   

        //Call a function to redraw other content (texts, images etc)
        var chart = new Chart(ctx).Line(chartData);
    }
}


$(document).ready(function() {
    $(window).resize(setTimeout(respondCanvas, 500));

    if($('#temp_chart').length > 0){
        GetChartData();
    }
});
