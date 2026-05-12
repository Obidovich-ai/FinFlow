import base64

class PaymeService:
    def __init__(self, merchant_id, secret_key):
        self.merchant_id = merchant_id
        self.secret_key = secret_key

    def create_pay_link(self, amount, order_id):
        # Payme-ga yuboriladigan ma'lumotlarni tayyorlash
        params = f"m={self.merchant_id};ac.order_id={order_id};a={amount * 100}"
        # Ma'lumotlarni Base64 formatiga o'tkazish
        encode_params = base64.b64encode(params.encode()).decode()
        return f"https://checkout.payme.uz/{encode_params}"

    def handle_webhook(self, data, db_session):
        # Webhook kelganda (to'lov amalga oshsa) bazani yangilash
        transaction_id = data['params']['id']
        amount = data['params']['amount'] / 100 # Tiyindan so'mga qaytarish
        
        # 1. Tranzaksiyani bazada topish
        # 2. Statusini 'completed' qilish
        # 3. Foydalanuvchi balansiga pulni qo'shish
        return {"result": {"success": True}}
