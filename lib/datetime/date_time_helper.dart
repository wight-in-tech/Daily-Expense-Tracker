//convert Datetime object to a string ddmmyyyy
String convertDateTimeToString(DateTime dateTime){


   //day in format --> dd
  String day = dateTime.day.toString();
  if(day.length==1){
    day ="0"+ day;
  }


  //month in format --> mm
  String month = dateTime.month.toString();
  if(month.length==1){
    month ="0"+ month;
  }

  //year in the format --> yyyy
  String year = dateTime.year.toString();

  //final format --> ddmmyyyy
  String ddmmyyyy =day + month + year;
  return ddmmyyyy;
}
