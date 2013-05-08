
function myFunction()
{
    x=document.getElementById("demo");  // Find the element
    x.innerHTML="Hello JavaScript!";    // Change the content
        NativeBridge.call("NSLog", ["do you see fuck blue background ?"],function (response){
                          if (response) {
                          document.body.innerHTML+="<br/>You saw blue background, all is perfectly fine!<br/>";
                          } else {
                          document.body.innerHTML+="<br/>Are you sure ? Because you have to see blue!<br/>";
                          }
                          if (onSuccess)
                          onSuccess();
                          });
    
}
