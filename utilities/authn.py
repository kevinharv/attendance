import os
import base64
import hashlib
import http.server
import socketserver
import threading
import urllib.parse
import webbrowser
import requests

# ==== Configuration ====
CLIENT_ID = "2pjos1melk7dkq6drg5kdjfd3d"
AUTH_DOMAIN = "auth.aws.kevharv.com"
REDIRECT_URI = "http://localhost:3000/callback"
SCOPES = "openid profile email"

# ==== PKCE: generate code verifier and code challenge ====
def generate_pkce():
    verifier = base64.urlsafe_b64encode(os.urandom(40)).rstrip(b"=").decode()
    challenge = base64.urlsafe_b64encode(
        hashlib.sha256(verifier.encode()).digest()
    ).rstrip(b"=").decode()
    return verifier, challenge

code_verifier, code_challenge = generate_pkce()

# ==== Start temporary HTTP server to receive the callback ====
class OAuthHandler(http.server.BaseHTTPRequestHandler):
    server_version = "OAuthHandler/1.0"
    auth_code = None

    def do_GET(self):
        parsed_path = urllib.parse.urlparse(self.path)
        if parsed_path.path == "/callback":
            params = urllib.parse.parse_qs(parsed_path.query)
            if "code" in params:
                OAuthHandler.auth_code = params["code"][0]
                self.send_response(200)
                self.send_header("Content-type", "text/html")
                self.end_headers()
                self.wfile.write(b"<h1>You may now close this window.</h1>")
            else:
                self.send_error(400, "Missing code in callback")

    def log_message(self, format, *args):
        return  # Silence logging

httpd = socketserver.TCPServer(("localhost", 3000), OAuthHandler)
threading.Thread(target=httpd.serve_forever, daemon=True).start()

# ==== Step 1: Open Browser for Login ====
params = {
    "response_type": "code",
    "client_id": CLIENT_ID,
    "redirect_uri": REDIRECT_URI,
    "scope": SCOPES,
}
auth_url = f"https://{AUTH_DOMAIN}/login?" + urllib.parse.urlencode(params)
print(f"Opening browser to log in...\n{auth_url}")
webbrowser.open(auth_url)

# ==== Step 2: Wait for callback ====
print("Waiting for authentication...")
while OAuthHandler.auth_code is None:
    pass
httpd.shutdown()

# ==== Step 3: Exchange code for tokens ====
token_url = f"https://{AUTH_DOMAIN}/oauth2/token"
data = {
    "grant_type": "authorization_code",
    "client_id": CLIENT_ID,
    "code": OAuthHandler.auth_code,
    "redirect_uri": REDIRECT_URI,
    "code_verifier": code_verifier,
}
headers = { "Content-Type": "application/x-www-form-urlencoded" }

response = requests.post(token_url, data=data, headers=headers)
response.raise_for_status()
tokens = response.json()

# ==== Done ====
print("\n✅ Login successful!")
print("Access Token (Bearer):")
print(tokens["access_token"])
print("\nID Token:")
print(tokens["id_token"])
