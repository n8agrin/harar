(function() {
  var harar, qunit, twitter_parts;
  qunit = require("qunit");
  harar = require("../harar.js");
  twitter_parts = {
    oauth_callback: "http://localhost:3005/the_dance/process_callback?service_provider_id=11",
    oauth_consumer_key: "GDdmIQH6jhtmLUypg82g",
    oauth_nonce: "QP70eNmVz8jvdPevU3oJD2AfF7R7odC2XJcn4XlZJqk",
    oauth_signature_method: "HMAC-SHA1",
    oauth_timestamp: "1272323042",
    oauth_version: "1.0"
  };
  test("Should create OAuth signatures correctly", function() {
    var checksum, h, method, oauth_consumer_secret, twitter_req_uri;
    h = new harar.OAuth;
    method = "post";
    oauth_consumer_secret = "MCD8BKwGdgPHvAuvgvz4EQpqDAtx89grbuNMRd7Eh98";
    twitter_req_uri = "https://api.twitter.com/oauth/request_token";
    checksum = "8wUi7m5HFQy76nowoCThusfgB+Q=";
    return equals(checksum, h.sign(method, twitter_req_uri, oauth_consumer_secret, twitter_parts), "should be the same");
  });
}).call(this);
