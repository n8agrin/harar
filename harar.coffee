sys = require 'sys'
http = require 'http'
sha = require './sha1.js'

euc = encodeURIComponent



# Sanity check
# twitter_secret = "MCD8BKwGdgPHvAuvgvz4EQpqDAtx89grbuNMRd7Eh98"
# good_sig = "POST&https%3A%2F%2Fapi.twitter.com%2Foauth%2Frequest_token&oauth_callback%3Dhttp%253A%252F%252Flocalhost%253A3005%252Fthe_dance%252Fprocess_callback%253Fservice_provider_id%253D11%26oauth_consumer_key%3DGDdmIQH6jhtmLUypg82g%26oauth_nonce%3DQP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1272323042%26oauth_version%3D1.0"
# key = "GDdmIQH6jhtmLUypg82g"
# 
# # Twitter example
# twitter_req_uri = "https://api.twitter.com/oauth/request_token"
# 
# parts =
#   oauth_callback: "http://localhost:3005/the_dance/process_callback?service_provider_id=11"
#   oauth_consumer_key: "GDdmIQH6jhtmLUypg82g"
#   oauth_nonce: "QP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk"
#   oauth_signature_method: "HMAC-SHA1"
#   oauth_timestamp: "1272323042"
#   oauth_version: "1.0"

# key = "key"
# secret = "secret"
# req_host = "www.term.ie"
# req_path = "/oauth/example/request_token.php"
# req_uri = "http://" + req_host + req_path
# 
#  
# parts =
#   oauth_callback: "http://localhost:3005/the_dance/process_callback?service_provider_id=11"
#   oauth_consumer_key : key
#   oauth_signature_method : "HMAC-SHA1"
#   oauth_timestamp : (new Date).getTime()
#   oauth_version : "1.0"
# 
# parts["oauth_nonce"] = nonce(parts["oauth_timestamp"])
#  
# sig_parts = parts
# sig_parts['oauth_signature'] = sign('get', req_uri, secret+"&", parts)
#  
# req_params = encode_parts(sig_parts)
# client = http.createClient(80, req_host)
# req = client.request("GET", req_path + "?" + req_params, {'host': req_host})
# req.end()
# req.on('response', (resp) ->
#   sys.puts(JSON.stringify(resp.headers))
#   resp.on('data', (ch) ->
#     sys.puts(ch)
#   )
# )


class OAuth
  constructor: (@options) ->
    
    # Required params:
    # consumer_key
    # consumer_secret
    # service_url
    # oauth_callback
    #
    # Optional params:
    # oauth_signature_method -> defaults to HMAC-SHA1
    # oauth_version -> defaults to 1.0
    # throw "Foo" if not @options["key"];
    
    @oauth_params = {}
    @_oauth_param_list = [
      "oauth_callback",
      "oauth_consumer_key",
      "oauth_signature_method",
      "oauth_timestamp",
      "oauth_version"
    ]
    @oauth_params[k] = v for k, v of @options if k in @_oauth_param_list
  
  encode_parts: (parts, joiner) ->
    (euc(key) + "=" + euc(parts[key]) for key in ((key for key of parts).sort())).join(joiner || '&')

  sign: (method, token_uri, secret, parts) ->
    sig_parts = [method.toUpperCase(), euc(token_uri), euc(@encode_parts(parts))].join('&')
    sha.b64_hmac_sha1(secret, sig_parts)

  nonce: (timestamp)->
    sha.hex_sha1(timestamp || (new Date).getTime())


exports.OAuth = OAuth  if exports?

