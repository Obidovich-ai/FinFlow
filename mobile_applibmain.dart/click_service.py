import hashlib

class ClickService:
    def __init__(self, service_id, merchant_id, secret_key):
        self.service_id = service_id
        self.merchant_id = merchant_id
        self.secret_key = secret_key

    def create_pay_link(self, amount, transaction_id):
        # Click uchun to'lov havolasi formatlash
        url = "https://my.click.uz/services/pay"
        params = (
            f"?service_id={self.service_id}"
            f"&merchant_id={self.merchant_id}"
            f"&amount={amount}"
            f"&transaction_param={transaction_id}"
        )
        return url + params

    def generate_auth_hash(self, click_trans_id, service_id, secret_key, merchant_trans_id, amount, action, sign_time):
        # Click xavfsizlik uchun MD5 hash talab qiladi
        hash_str = f"{click_trans_id}{service_id}{secret_key}{merchant_trans_id}{amount}{action}{sign_time}"
        return hashlib.md5(hash_str.encode()).hexdigest()
