function parse_log(text_body) {
    return text_body.split("\n");
}
function update_logs(log_arr) {
    for(i = 0; i < log_arr.length; i++)
    {
        account_el = $("#" + log_arr[i].account);
        if(!account_el.length)
        {
            $(".row").append("<div class='col-lg-2 col-md-4 terminal' id='" + log_arr[i].account + "'><h4>" + log_arr[i].account + "</h4></div>");
            account_el = $("#" + log_arr[i].account);
        }

        if(log_arr[i].action_type == 'donate' || log_arr[i].action_type == 'revoke')
        {
            account_el.append("<p class='log'> > " + "<em class='action_type'>" + log_arr[i].action_type + "</em> " + log_arr[i].account + "</p>");

            if(log_arr[i].action_type == 'revoke')
                account_el.addClass("revoked");
            else
                account_el.removeClass("revoked");
        }
        else
            account_el.append("<p class='log'> > " + "<em class='action_type'>" + log_arr[i].action_type + "</em> file " + log_arr[i].file_name + " chunk <em class='chunk'>#" + log_arr[i].chunk + "</em> as <em class='upload_type'>" + log_arr[i].upload_type + "</em></p>");
    }
}
