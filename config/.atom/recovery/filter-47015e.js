function create_select_center(div_id,container,opt){
  $.ajax({
    url: 'functions/get_centers.php',
    success: function(result){
      $json=$.parseJSON(result);
      $("#"+div_id).append($('<select id="select_center" class="form-control col-4 " ><option value="-1">-</option></select>'));
      $select=$('#select_center');

      $json.forEach(function(e){
        $select.append(
          $('<option value="'+e.id+'">'+e.name+'</option>')
        )
      });
      $select.change(function(event) {
        if(this.value!="-1"){
          opt.location=this.value;
        }else{
          delete opt.location;
        }
        clearCanvas(container);
        //createGraph(opt);
        initCheckBox(container,opt);
      });
    }
  })
}

function create_select_date(div_id,container,opt) {
  $.ajax({
    url: 'functions/fork_date.php',
    success: function(result) {
      $json=$.parseJSON(result);

      //gestion des mois
      mois=["Janvier","Fevrier","Mars","Avril","Mai","Juin","Juillet","Aout","Septembre","Octobre","Novembre","Decembre"];
      $("#"+div_id).append($('<select id="select_month" class="form-control col-4 " ><option value="-1">-</option></select>'));
      $select_month=$('#select_month');
      for (var i = 0; i < mois.length; i++) {
        $select_month.append(
          $('<option value="'+(i+1)+'">'+mois[i]+'</option>')
        );
      };
      $select_month.change(function(event) {
        if(this.value!="-1"){
          opt.month=this.value;
        }else{
          delete opt.month;
        }
        clearCanvas(container);
        //createGraph(opt);
        initCheckBox(container,opt);
      });

      //gestion des années
      min = $json[0][0][0]+$json[0][0][1]+$json[0][0][2]+$json[0][0][3]
      max = $json[0][1][0]+$json[0][1][1]+$json[0][1][2]+$json[0][1][3]

      $("#"+div_id).append($('<select id="select_year" class="form-control col-4 "><option value="-1">En cours</option></select>'));
      $select_year=$('#select_year');
      for ( i = parseInt(min); i <= parseInt(max); i++) {
        $select_year.append(
          $('<option value="'+i+'">'+i+'</option>')
        );
      };
      $select_year.change(function(event) {
        if(this.value!="-1"){
          opt.year=this.value;
        }else{
          delete opt.year;
        }
        clearCanvas(container);
        //createGraph(opt);
        initCheckBox(container,opt);
      });
    }
  })
}
