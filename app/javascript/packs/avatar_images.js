document.addEventListener('DOMContentLoaded', function () {
  const MAX_FILE_SIZE = 1 * 1024 * 1024; // 1MB in bytes
  const MAX_TOTAL_FILES = 8;

  const fileInput = document.getElementById('avatar_image');

  if (fileInput) {
    fileInput.addEventListener('change', function (event) {
      const files = Array.from(event.target.files); // 選択されたファイル
      let invalidFiles = []; // 不正なファイルを格納
      let oversizedFiles = []; // サイズ超過ファイルを格納
      let totalFiles = files.length; // 新しく選択されたファイル数

      // ファイル形式とサイズをチェック
      files.forEach(file => {
        if (!file.type.startsWith('image/')) {
          invalidFiles.push(file.name); // 画像ファイルでない場合
        }
        if (file.size > MAX_FILE_SIZE) {
          oversizedFiles.push(file.name); // サイズ超過の場合
        }
      });

      // 既存のアップロード済み画像数を考慮して合計枚数をチェック
      const existingFilesCount = document.querySelectorAll('.existing-image').length || 0;
      totalFiles += existingFilesCount;

      if (totalFiles > MAX_TOTAL_FILES) {
        alert(`画像の合計枚数が${MAX_TOTAL_FILES}枚を超えています。`);
        fileInput.value = ''; // ファイル選択をリセット
        return;
      }

      if (invalidFiles.length > 0 || oversizedFiles.length > 0) {
        if (invalidFiles.length > 0) {
          alert(`以下のファイルは画像ファイルではありません: \n- ${invalidFiles.join('\n')}`);
        }

        if (oversizedFiles.length > 0) {
          alert(`以下のファイルはサイズが1MBを超えています: \n- ${oversizedFiles.join('\n')}`);
        }

        fileInput.value = ''; // 不正なファイル選択をリセット
      }
    });
  }
});