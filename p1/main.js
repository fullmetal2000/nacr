function myFunction(sitename)
{
    
    NativeBridge.call("section", [sitename],function (response){
                      if (response) {
                      document.body.innerHTML+="<br/>You saw blue background, all is perfectly fine!<br/>";
                      } else {
                      document.body.innerHTML+="<br/>Are you sure ? Because you have to see blue!<br/>";
                      }
                      if (onSuccess)
                      onSuccess();
                      });
    
}
function loadDetail(idx,img,title,author,time,article)
{

    NativeBridge.call("loadDetail", [idx,img,title,author,time,article],function (response){
                      if (response) {
                      document.body.innerHTML+="<br/>You saw blue background, all is perfectly fine!<br/>";
                      } else {
                      document.body.innerHTML+="<br/>Are you sure ? Because you have to see blue!<br/>";
                      }
                      if (onSuccess)
                      onSuccess();
                      });
    
}
