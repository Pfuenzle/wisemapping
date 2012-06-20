<%@ include file="/jsp/init.jsp" %>

<div>
    <ul class="nav nav-tabs">
        <li class="active"><a href="#changeUserPanel" data-toggle="pill">General</a></li>
        <li><a href="#changePasswordPanel" data-toggle="pill">Security</a></li>
    </ul>

    <div class="tab-content">
        <div class="tab-pane fade active in" id="changeUserPanel">
            <div id="changeInfoMsg" class="alert">
            </div>
            <form action="#" method="POST" id="changeUserForm">
                <fieldset>
                    <label for="email"><strong><spring:message code="EMAIL"/>:</strong></label>
                    <input type="text" name="password" id="email" required="required" readonly="readonly"
                           value="${user.email}"/>

                    <label for="userName"><strong><spring:message code="USERNAME"/>:</strong></label>
                    <input type="text" name="password" id="userName" required="required" value="${user.username}"
                           readonly="readonly"/>

                    <label for="firstname"><strong><spring:message code="FIRSTNAME"/>:</strong></label>
                    <input type="text" name="firstname" id="firstname" required="required" value="${user.firstname}"/>

                    <label for="lastname"><strong><spring:message code="LASTNAME"/>:</strong></label>
                    <input type="text" name="lastname" id="lastname" required="required" value="${user.lastname}"/>

                    <br/>
                    <input type="submit" id="changeUserInfoBtn" class="btn btn-primary" value="Save"/>
                </fieldset>
            </form>

        </div>
        <div class="tab-pane fade" id="changePasswordPanel">
            <div id="changePasswordMsg" class="alert">
            </div>
            <form action="#" method="POST" id="changePasswordForm">
                <fieldset>
                    <label for="password"><strong><spring:message code="NEW_PASSWORD"/>:</strong></label>
                    <input type="password" name="password" id="password" required="required"/>

                    <label for="repassword"><strong><spring:message code="CONFIRM_NEW_PASSWORD"/>:</strong></label>
                    <input type="password" name="password" id="repassword" required="required"/>
                    <br/>
                    <input type="submit" id="changePasswordBtn" class="btn btn-primary"
                           value="<spring:message code="CHANGE_PASSWORD"/>"/>
                </fieldset>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
    $('#changePasswordMsg').hide();
    function postChange(url, postBody, msgContainerId, successMsg) {
        // Change success message ...
        jQuery.ajax(url, {
            async:false,
            dataType: 'json',
            data: postBody,
            type: 'PUT',
            contentType:"text/plain; charset=utf-8",
            success : function(data, textStatus, jqXHR) {
                $('#' + msgContainerId).removeClass('alert-error').addClass('alert-info').show();
                $('#' + msgContainerId).text(successMsg);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                $('#' + msgContainerId).removeClass('alert-info').addClass('alert-error').show();
                $('#' + msgContainerId).text(textStatus);
            }
        });
    }

    $('#changePasswordForm').submit(function(event) {

        var inputVal = $('#changePasswordForm #password').val();
        var rinputVal = $('#changePasswordForm #repassword').val();
        if (inputVal != rinputVal) {
            // Password mismatch message ...
            $('#changePasswordMsg').removeClass('alert-info').addClass('alert-error').show();
            $('#changePasswordMsg').text('<spring:message code="PASSWORD_MISSMATCH"/>');
        } else {
            postChange("service/account/password", inputVal, 'changePasswordMsg', '<spring:message code="CHANGE_PASSWORD_SUCCESS"/>');
        }
        event.preventDefault();
    });

    $('#changeUserForm').submit(function(event) {

        var fistname = $('#changeUserForm #firstname').val();
        var lastname = $('#changeUserForm #lastname').val();

        postChange("service/account/firstname", fistname, 'changeInfoMsg', 'Your info has been changed successfully');
        postChange("service/account/lastname", lastname, 'changeInfoMsg', 'Your info has been changed successfully');
        event.preventDefault();
    });

</script>