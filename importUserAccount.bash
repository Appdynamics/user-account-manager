source config

for user in "${users[@]}";
do

   eval ${user};

   for controllerHost in "${controllerHosts[@]}";
   do

     eval ${controllerHost}
     host=${q[1]}
     acctid=`curl -u ${adminUser}@${q[0]}:${adminPass} https://$host/controller/api/accounts/myaccount | tr '},{' '}\n{' | grep id | cut -d' ' -f2 | tr -d '"'`
     tempUserId=`curl -u ${adminUser}@${q[0]}:${adminPass} https://$host/api/accounts/$acctid/users | tr '},{' '}\n{' | tr '[' '\n[' | tr '{' '\n{' | grep -i -B 4 ${p[3]} | grep -o '"id".\{0,\}' | cut -d' ' -f2 | tr -d '"'`

     # if the user already exists in the controller, then update the user info; Else, create the new user
     if [[ -n "${tempUserId/ /}" ]]; then

	user_name=`curl -u ${adminUser}@${q[0]}:${adminPass} https://$host/api/accounts/$acctid/users | tr '},{' '}\n{' | grep -i -B 3 ${p[3]} | grep name | cut -d' ' -f2 | tr -d '"'`	

        curl -X POST --user ${adminUser}@${q[0]}:${adminPass} https://$host/controller/rest/users --data-urlencode "user-id=${tempUserId}" --data-urlencode "user-name=${user_name}" --data-urlencode "user-display-name=${p[1]}" --data-urlencode "user-email=${p[3]}" --data-urlencode "user-roles=${p[4]}"
        echo "Updated existing user ${p[1]}"

     else

	echo "tempUserId does not exist"

        curl -X POST --user ${adminUser}@${q[0]}:${adminPass} https://$host/controller/rest/users --data-urlencode "user-name=${p[0]}" --data-urlencode "user-display-name=${p[1]}" --data-urlencode "user-password=${p[2]}" --data-urlencode "user-email=${p[3]}" --data-urlencode "user-roles=${p[4]}"

	echo "Created new user ${p[1]}"
     fi

   done

done

