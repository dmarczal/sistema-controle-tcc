if(window.calendar && window.items){
  var calendar = JSON.parse(window.calendar.replace(/&quot;/ig, '"'));
  var items = JSON.parse(window.items.replace(/&quot;/ig, '"'));
  var json = window.json
  header(json, items, calendar.half, function(){
    body(items);
    events(items);
  });
}