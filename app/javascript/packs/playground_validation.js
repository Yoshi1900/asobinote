document.addEventListener('turbolinks:load', () => {
  //画像サイズと枚数のバリデーション
  const fileInput = document.getElementById("playground_images");

  if (!fileInput) return; // フォームが存在しない場合は何もしない

  fileInput.addEventListener("change", (event) => {
    const files = event.target.files;
    const maxFiles = 8;
    const maxFileSize = 1 * 1024 * 1024; // 1MB
    let errorMessage = "";

    // 枚数チェック
    if (files.length > maxFiles) {
      errorMessage = `画像は合計で${maxFiles}枚までアップロード可能です。`;
    }

    // サイズチェック
    for (const file of files) {
      if (file.size > maxFileSize) {
        errorMessage = "各画像のサイズは1MB以下にしてください。";
        break;
      }
    }

    if (errorMessage) {
      alert(errorMessage);
      fileInput.value = ""; // 入力をリセット
    }
  });

  // 郵便番号のバリデーション
  // const postCodeInput = document.querySelector("input[name='playground[post_code]']");

  // if (!postCodeInput) return;

  // postCodeInput.addEventListener("input", () => {
  //   const value = postCodeInput.value;
  //   const isValid = /^\d{7}$/.test(value); // 7桁の数字のみ許可

  //   if (!isValid) {
  //     postCodeInput.setCustomValidity("郵便番号は7文字の数字で入力してください");
  //   } else {
  //     postCodeInput.setCustomValidity(""); // エラーをクリア
  //   }
  // });

  // // 電話番号のバリデーション
  // const phoneInput = document.querySelector("input[name='playground[phone_number]']");

  // if (!phoneInput) return;

  // phoneInput.addEventListener("input", () => {
  //   const value = phoneInput.value;
  //   const isValid = /^\d{10,11}$/.test(value); // 10、11文字の数字のみ許可

  //   if (!isValid || (value.length > 0 && value.length < 10)) {
  //     phoneInput.setCustomValidity("電話番号はハイフンなしの10～11文字の数字で入力してください");
  //   } else {
  //     phoneInput.setCustomValidity(""); // エラーをクリア
  //   }
  // });
  // const fileInput = document.getElementById("post_images");

  // if (!fileInput) return;

  // fileInput.addEventListener("change", (event) => {
  //   const files = event.target.files;
  //   const maxFiles = 8;
  //   const maxFileSize = 1 * 1024 * 1024; // 1MB
  //   let errorMessage = "";

  //   // 枚数チェック
  //   if (files.length > maxFiles) {
  //     errorMessage = `画像は最大で${maxFiles}枚までアップロード可能です。`;
  //   }

  //   // 各画像サイズのチェック
  //   for (const file of files) {
  //     if (file.size > maxFileSize) {
  //       errorMessage = "各画像のサイズは1MB以下にしてください。";
  //       break;
  //     }
  //   }

  //   if (errorMessage) {
  //     alert(errorMessage);
  //     fileInput.value = ""; // 入力をリセット
  //   }
  // });
});