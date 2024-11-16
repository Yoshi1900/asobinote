document.addEventListener('turbolinks:load', () => {
  const fileInput = document.getElementById("post_images");

  if (!fileInput) return;

  fileInput.addEventListener("change", (event) => {
    const files = event.target.files;
    const maxFiles = 8;
    const maxFileSize = 1 * 1024 * 1024; // 1MB
    let errorMessage = "";

    // 枚数チェック
    if (files.length > maxFiles) {
      errorMessage = `画像は最大で${maxFiles}枚までアップロード可能です。`;
    }

    // 各画像サイズのチェック
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
});