echo Logging into admin
echo
echo

authObject="$(curl -X POST -H "Content-Type: application/json" \
-d '{"userName": "admin", "password": "8pzPdcZAG6&Q"}' \
https://dev-k8s.treetracker.org/api/admin/auth/login)"

token=$(python3 -c "import sys,json; sys.stdout.write(str($authObject['token']))")

echo $token

