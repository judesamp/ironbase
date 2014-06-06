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
//= require dashboard.js


//= require foundation
//= require gritter
//= require turbolinks

//= require_tree .




$(function(){
 $(document).foundation(); 
});

function Pad(n) {return n < 10 ? '0' + n : n}

function AddDate(oldDate, offset, offsetType) {
  console.log(oldDate);
       var year = parseInt(oldDate.getFullYear());
       console.log(year);
       var month = parseInt(oldDate.getMonth());
       console.log(month);
       var date = parseInt(oldDate.getDate());
       console.log(date);
       var newDate;
       switch (offsetType) {
       case "Y":
       case "y":
           newDate = new Date(year + offset, month, date);
           break;

       case "M":
       case "m":
           newDate = new Date(year, month + offset, date);
           break;

       case "D":
       case "d":
           newDate = new Date(year, month, date + offset);
           break;

       }
       return newDate;            
   } 

