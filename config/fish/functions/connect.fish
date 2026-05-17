function connect
    set -l USERID "25BCE2951"
    set -l PASSWORD "Daya12345"

    set -l response (curl -s -X POST "http://phc.prontonetworks.com/cgi-bin/authlogin?URI=http://example.com" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        --data "userId=$USERID&password=$PASSWORD&serviceName=ProntoAuthentication")

    # CASE 1: already logged in
    if string match -rq "meta http-equiv=\"refresh\"" $response
        echo "✓ Already connected (session active)"
        return 0

    # CASE 2: success
    else if string match -rq "Access Granted" $response
        echo "✓ Login successful"
        return 0

    # CASE 3: invalid credentials
    else if string match -rq "check your username and password" $response
        echo "✗ Invalid credentials"
        return 1

    # CASE 4: unknown response
    else
        echo "⚠ Unknown response"
        echo $response | head -n 10
        return 2
    end
end
