function goback(index)
{
    
    NativeBridge.call("goback", [index],function (response){
                     
                      if (response) {
                      document.body.innerHTML+="<br/>You saw blue background, all is perfectly fine!<br/>";
                      } else {
                      document.body.innerHTML+="<br/>Are you sure ? Because you have to see blue!<br/>";
                      }
                      if (onSuccess)
                      onSuccess();
                      });
    
}
