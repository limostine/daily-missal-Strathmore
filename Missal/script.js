$(document).ready(function(){
    var meta = document.createElement('meta');
    meta.name = 'viewport';
    meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
    var head = document.getElementsByTagName('head')[0];
    head.appendChild(meta);
    
    alert('Success!');
})