<!DOCTYPE html>
<html lang="en">
<head>
<cfprocessingdirective pageEncoding="utf-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link href="style.css" rel="stylesheet" id="bootstrap-css">

</head>
<body><br/>
<div class="container">
  <div class="row">
<div class="col-md-5">
<div class="container register-form">
            <div class="form">
                <div class="note">
                    <p id="baslik">Kayıt Ekle</p>
                </div>
                <div class="form-content">
                    <div class="row">
                    <span id="guncelid"></span>
                        <div class="col-md-6">
                            <div class="form-group">
                                <input type="text" id="isim" class="form-control" placeholder="İsim" tabindex="1"/>
                            </div>
                            <div class="form-group">
                                <input type="text" id="telefon" class="form-control" placeholder="Telefon" tabindex="3"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <input type="text" id="soyisim" class="form-control" placeholder="Soyisim" tabindex="2"/>
                            </div>
                            <div class="form-group">
                                <input type="text" id="email" class="form-control" placeholder="Email" tabindex="4"/>
                            </div>
                        </div>
                           <div class="col-md-12">
                            <div class="form-group">
                                <input type="text" id="adres" class="form-control" placeholder="Adres" tabindex="5"/>
                            </div>
                        </div>
                    </div>
                    <button type="submit" id="ekle" class="btnSubmit buton">+Kayıt Ekle</button>
                    <button style="float: right; background-color: green; visibility:hidden;" type="submit" id="degistir" class="btnSubmit">+Kayıt Ekle</button>
                </div>
            </div>
        </div>
    </div>
  <div class="col-md-7">
     <table class="table" id="tablo">
  <thead class="thead-dark">
    <tr>
      <th>İd</th>
      <th>İsim</th>
      <th>Soyisim</th>
      <th>Telefon</th>
      <th>Email</th>
      <th>Adres</th>
      <th>Sil</th>
      <th>Güncelle</th>
    </tr>
  </thead>
  <tbody>
  <cfquery name="cek" datasource="veritabani">
      SELECT * From bilgiler
      </cfquery>
      <cfloop query="cek">
      <cfoutput>
      <tr id="#id#">
      <th>#id#</th>
      <td>#isim#</td>
      <td>#soyisim#</td>
      <td>#telefon#</td>
      <td>#mail#</td>
      <td>#adres#</td>
      <td><i class="fas fa-trash sil" id="#id#"></i></td>
      <td><i class="fas fa-edit goster" id="#id#"></i></td>
    </tr>
 </cfoutput>
</cfloop>
</tbody>
</table>
</div>
</div>
</div>
<div class="return"></div>
</body>
</html>


<script>
//ekle
$("#ekle").parent().on("click","#ekle", function () {
    var isim=$("#isim").val();
    var soyisim=$("#soyisim").val();
    var tel=$("#telefon").val();
    var email=$("#email").val();
    var adres=$("#adres").val();
 $.ajax({
 url: "islem.cfc"
  , type: "get"
  , data: {
 method: "ekle"
    , isim:isim,soyisim:soyisim,tel:tel,email:email,adres:adres
  }
  , success: function (response){
     var sonuc = response.split("|");
    if(sonuc[0]=="Başarılı"){ 
$('#tablo').append('<tr id="'+sonuc[1]+'"><th>'+sonuc[1]+"</th><td>"+sonuc[2]+
"</td><td>"+sonuc[3]+"</td><td>"+sonuc[4]+"</td><td>"+sonuc[5]+
"</td><td>"+sonuc[6]+'</td><td><i class="fas fa-trash sil"  id="'+sonuc[1]+'"></i>'+
'</td><td><i class="fas fa-edit goster" id="'+sonuc[1]+'"></i></td></tr>');
       }
  }
  , error: function (xhr, textStatus, errorThrown){
    alert(errorThrown);
  }
});
});

//sil

 $('#tablo > tbody:last-child').on('click','.sil',function(){
var deletee = $(this).attr("id");
      var onay
onay = confirm("Silmek İstediğinize Emin Misiniz?");
if (onay == true) {
$.ajax({
url:"islem.cfc" 
, type: "get"
  , data: {
 method: "sil"
    , id:deletee
  }
,success : function(response){
    
$("table#tablo tr#"+deletee).remove();
  }
});}

});

//göster

 $('#tablo > tbody:last-child').on('click','.goster',function(){
var id = $(this).attr("id");
$.ajax({
url:"islem.cfc"
, type: "get"
  , data: {
 method: "goster"
    , id:id
  }
,success : function(response){
   var sonuc = response.split("|");
    if(sonuc[0]=="Başarılı"){ 
 $("#isim").val(sonuc[2]);
$("#soyisim").val(sonuc[3]);
$("#telefon").val(sonuc[4]);
$("#email").val(sonuc[5]);
$("#adres").val(sonuc[6]);
$('#baslik').text('Güncelle');
$(".buton").attr("id","guncelle");
$('.buton').html("Güncelle"); 
$("#degistir").css( "visibility","visible");
$("#guncelid").attr('class', id);
    }
  }
});
});


$('#degistir').on('click',function(){
$(this).css( "visibility","hidden");
$('#baslik').text('Kayıt Ekle');
$('.buton').attr('id','ekle');
$('.buton').html("+Kayıt Ekle"); 
 $("#isim").val("");
$("#soyisim").val("");
$("#telefon").val("");
$("#email").val("");
$("#adres").val("");
});

//güncelle
$("#ekle").parent().on("click","#guncelle", function () {
    var id=$("#guncelid").attr('class');
    var isim=$("#isim").val();
    var soyisim=$("#soyisim").val();
    var tel=$("#telefon").val();
    var email=$("#email").val();
    var adres=$("#adres").val();
 $.ajax({
 url: "islem.cfc"
  , type: "get"
  , data: {
 method: "guncelle"
    ,id:id,isim:isim,soyisim:soyisim,tel:tel,email:email,adres:adres
  }
  , success: function (response){
     var sonuc = response.split("|");
    if(sonuc[0]=="Başarılı"){ 
        $("table#tablo tr#"+id).remove();
$('#tablo').append('<tr id="'+sonuc[1]+'"><th>'+sonuc[1]+"</th><td>"+sonuc[2]+
"</td><td>"+sonuc[3]+"</td><td>"+sonuc[4]+"</td><td>"+sonuc[5]+
"</td><td>"+sonuc[6]+'</td><td><i class="fas fa-trash sil"  id="'+sonuc[1]+'"></i>'+
'</td><td><i class="fas fa-edit goster" id="'+sonuc[1]+'"></i></td></tr>');

       }
  }
  , error: function (xhr, textStatus, errorThrown){
    alert(errorThrown);
  }
});
});
</script>