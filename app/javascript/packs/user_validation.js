document.addEventListener('turbolinks:load', () => {
  const fileInput = document.getElementById("avatar_image");

  if (!fileInput) return;

  fileInput.addEventListener("change", (event) => {
    const file = event.target.files[0];
    const maxFileSize = 1 * 1024 * 1024; // 1MB

    if (file && file.size > maxFileSize) {
      alert("アバター画像のサイズは1MB以下にしてください");
      fileInput.value = ""; // 入力をリセット
    }
  });
  const phoneInput = document.querySelector("input[name='user[phone_number]']");

  if (!phoneInput) return;

  phoneInput.addEventListener("input", () => {
    const value = phoneInput.value;
    const isValid = /^\d{10,11}$/.test(value); // 10、11文字の数字のみ許可

    if (!isValid || (value.length > 0 && value.length < 10)) {
      phoneInput.setCustomValidity("電話番号はハイフンなしの10～11文字の数字で入力してください");
    } else {
      phoneInput.setCustomValidity(""); // エラーをクリア
    }
  });

});