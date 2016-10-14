# user-account-manager
Bash script for user account management

IMPORTING USERS IN CONTROLLER

1. Please modify the config file with the users (see the config_example file for an example)
   1.1 List all the controllers where the user with the specified role needs to be added
   1.2 Please add the roles that the users need to be assigned to. Please verify that the roles exist in the controllers before running the script.
   1.3 Create a list of all users in the appropriate format as given in the example. If users don't exist, new account will be created for the user. If the user does exist, then the user info is updated.
2. Run the importUserAccount.bash file

THIS SCRIPT WILL CREATE USER ACCOUNTS FOR ANY NEW ACCOUNTS AS WELL AS UPDATE ANY EXISTING USER ACCOUNTS BASED ON THE EMAIL ADDRESS
