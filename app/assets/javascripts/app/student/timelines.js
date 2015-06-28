function set_timeline(timeline_id, canvas_id){
  var calendar = JSON.parse(window.calendar.replace(/&quot;/ig, '"'));
  var items = JSON.parse(window.items.replace(/&quot;/ig, '"'));
  var json = window.json;
  for(i in items){
    if(items[i].link){
      items[i].link = items[i].link.replace('academico', 'academico/timeline/'+timeline_id);
    }
  }
  header(json, items, calendar.half, function(){
    body(items);
    events(items);
  }, canvas_id);
}