var key = 'AIzaSyBWaCbUsFEfHF8pSsBSZbTHNnIAZdm320s';
function getPlace(placeArr , callback)
{
//    console.log("In the getPlace function");
//    console.log(place);
//console.log(placeArr);
for(var k = 0 ; k < placeArr.length; k++){
    var place = placeArr[k];
    
    var str="";
    for(var i=0;i< place.length;i++)
    {
        if(place[i]==' ')
             str+="+";
        else
           str+=place[i];
    }
//    console.log(str);
//    console.log("https://maps.googleapis.com/maps/api/geocode/json?address=" + str + "&key=" + key);
    var res;
    $.ajax({
        type: 'GET',
        url: 'https://maps.googleapis.com/maps/api/geocode/json?address=' + str + '&key=' + key,
        dataType: 'json',
        async : false,
        success: function (result) {
            res = result;
            var flag=0;
            for(var i in res['results'])
            {
                lat = res['results'][0]['geometry']['location']['lat'];
                lng = res['results'][0]['geometry']['location']['lng'];
                flag = 1;
            }
            if (flag == 0 )
            {
                lat = 0;lng = 0;
            }
//            console.log(lat+" "+lng);
            getSublocality(lat, lng, function(data){
//                console.log(data);
                
                placeArr[k] = data;
//                console.log(k);
            });  
        }
    });
}
callback(placeArr);
}

function getSublocality(lat, lng, callback)
{
    var res;
    //var lat = 28.6528, lng = 77.1921;
    $.ajax({
        //"url": 'https://maps.googleapis.com/maps/api/geocode/json?latlng='+lat+','+lng+'&key=' + key,
        type: 'GET',
        url: 'https://maps.googleapis.com/maps/api/geocode/json?latlng=' + lat + ',' + lng + '&key=' + key,
        dataType: 'json',
        async : false,
        success: function (result) {
            temp(result, function(data){
//                console.log(data);
                callback(data);
            });
        }
    });
//    console.log(res);
    
}

function temp(res, callback)
{
//    console.log("In temp");
//    console.log(res);
    var sublocality;
    var level = "sublocality_level_1";
    var typeArray = ["political", "sublocality", level];
    var flag = 0;
    for (var iterator in res['results'])
    {
        for (var i in res['results'][iterator]['address_components'])
        {
            var is_same = (res['results'][iterator]['address_components'][i]['types'].length == typeArray.length) && res['results'][iterator]['address_components'][i]['types'].every(function (element, index) {
                return element === typeArray[index];
            });
//                console.log(res['results'][0]['address_components'][i]['types']+"   "+is_same);
            if (is_same)
            {
                sublocality = res['results'][iterator]['address_components'][i]['long_name'];
//                console.log(res['results'][iterator]['address_components'][i]['long_name']);
                flag = 1;
            }
        }
        if (flag == 1)
        {
            break;
        }
    }
    if (flag == 0) {
        var data =  "Place Not Found";
        callback(data);
    }
    else {
        var data =  sublocality;
        callback(data);
    }
}