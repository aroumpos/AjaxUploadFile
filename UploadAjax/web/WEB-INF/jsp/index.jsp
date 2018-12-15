<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
         <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
         
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">       
        <title>Welcome to Spring Web MVC project</title>
    </head>
    <body>
        <script type="text/javascript">
            $(document).ready(function(){
                $('button[type=submit]').click(function(e){
                    e.preventDefault();
                    var form=document.forms[0];
                    var formData=new FormData(form);
                    var ajaxReq = $.ajax({
                        url: 'fileUpload.htm',
                        type: 'POST',
                        data: formData,
                        cache: false,
                        contentType: false, // λεμε να μην βαλει content-type στο request
                        processData: false, // Να μην το κάνει string για να το στειλει
                        //Callback for creating the XMLHttpRequest object
                        xhr: function () {
                           alert("create request")
                            //Get XmlHttpRequest object
                            var xhr = $.ajaxSettings.xhr();

                            //Set onprogress event handler
                            xhr.upload.onprogress = function (event) {
                                 alert("sending")
                                var perc = Math.round((event.loaded / event.total) * 100);
                                $('#progressBar').text(perc + '%');
                                $('#progressBar').css('width', perc + '%');
                            };
                            return xhr;
                        },
                        beforeSend: function (xhr) {
                             alert("before send")
                            //Reset alert message and progress bar
                            $('#alertMsg').text('');
                            $('#progressBar').text('');
                            $('#progressBar').css('width', '0%');
                        }
                    });

                    // Called on success of file upload
                    ajaxReq.done(function (msg) {
                        alert("done")
                        $('#alertMsg').text(msg);
                        $('input[type=file]').val('');
                        $('button[type=submit]').prop('disabled', false);
                    });

                    // Called on failure of file upload
                    ajaxReq.fail(function (jqXHR) {
                        $('#alertMsg').text(jqXHR.responseText + '(' + jqXHR.status +
                                ' - ' + jqXHR.statusText + ')');
                        $('button[type=submit]').prop('disabled', false);
                    });
                });              
            });
        </script>
        <div>
    <form>
        File Name : <input type="text" name="filename"><br/>
        File to upload: <input type="file" name="img" multiple="multiple">
        <button type="submit" value="Upload">Upload</button>
    </form>
        </div><br/>
         <div class="progress">
               <div id="progressBar" class="progress-bar progress-bar-success" role="progressbar"
                    aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">0%</div>
           </div>
    </body>
</html>
