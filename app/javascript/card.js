const pay = () => {
  //テスト公開鍵
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey)

  //elementsインスタンスを生成
  const elements = payjp.elements();

  //elementsインスタンスに各カード情報を格納するための定数（入力フォーム）を定義
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  //作成した入力フォームをorders/indexビューの該当idを持つ要素と置き換える
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  //orders/indexビューの「購入」ボタンを押したら起動する
  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    //トークン化
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      //定数のカード情報を削除
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      //カード情報を送信
      document.getElementById("charge-form").submit();
    });
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);