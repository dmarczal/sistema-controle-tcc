$(function(){
    $('.go').on('click', function(){
        window.location.href = "/responsavel/timelines/"+$('[name=year]').val()+"/"+$('[name=half]:checked').val()+"/"+$('[name=tcc]:checked').val();
    });
    var base_element = '<a href="/responsavel/timelines/{{year-half}}/{{tcc}}">{{text}}</a>'
    var date = new Date();
    var year = date.getFullYear();
    if(date.getMonth() <= 5){
      var current_year_half = year+'/1';
      var next_year_half = year+'/2';
    }else{
      var current_year_half = year+'/2';
      var next_year_half = (year+1)+'/1';
    }
    for(var i=1; i<=2; i++){
      var element = base_element.replace('{{year-half}}', current_year_half).replace('{{tcc}}', i).replace('{{text}}', 'TCC '+i+' deste semestre');
      $('.links').append(element);
      element = base_element.replace('{{year-half}}', next_year_half).replace('{{tcc}}', i).replace('{{text}}', 'TCC '+i+' do próximo semestre');
      $('.links').append(element);
    }
});

function set_timeline(){
  var calendar = JSON.parse(window.calendar.replace(/&quot;/ig, '"'));
  var items = JSON.parse(window.items.replace(/&quot;/ig, '"'));
  var json = window.json;
  header(json, items, calendar.half, function(){
    body(items);
    events(items);
  });
}
;
