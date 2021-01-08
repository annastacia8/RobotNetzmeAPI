import hmac
import hashlib
secret_key = b"SoaJaLinBank123"
def get_hmac(json_data):
    message = json_data.encode()
    return hmac.new(secret_key, message, hashlib.sha256).hexdigest().upper()

##import hashlib
##import hmac

##key = 'SoaJaLinBank123'
##message = json_data.encode()

# Generate the hash.
##signature = hmac.new(
    ##key,
    ##message,
    ##hashlib.sha256
##).hexdigest()


