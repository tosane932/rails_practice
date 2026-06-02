// Rails 8 完全に制御下に置くFetch API非同期ロジック
const初期化 = () => {
  const form = document.getElementById("async-log-form");
  if (!form) return; // フォームが画面にない場合はスルー

  // 2重にイベントが登録されるのを防ぐ現場主義の設計
  form.removeEventListener("submit", 送信処理);
  form.addEventListener("submit", 送信処理);
};

const 送信処理 = async (e) => {
  e.preventDefault(); // ブラウザの通常リロードを完全ブロック

  // フォームデータ取得
  const date = document.getElementById("form-date").value;
  const mins = document.getElementById("form-mins").value;
  const memo = document.getElementById("form-memo").value;

  // RailsのCSRFトークンをメタタグから確実に奪取
  const csrfTokenTag = document.querySelector('meta[name="csrf-token"]');
  const token = csrfTokenTag ? csrfTokenTag.getAttribute('content') : "";

  try {
    // ⚡ Fetch API 執行
    const response = await fetch("/learning_logs.json", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": token,
        "Accept": "application/json"
      },
      body: JSON.stringify({
        learning_log: { learned_on: date, duration_mins: mins, memo: memo }
      })
    });

    if (response.ok) {
      const data = await response.json();

      // 1. メーターの数値を無遅延で書き換え
      document.getElementById("stat-days").innerText = data.total_days;
      document.getElementById("stat-hours").innerText = data.total_hours;
      document.getElementById("stat-level").innerText = data.current_level;

      // 2. ログ一覧の最上部に、今登録したデータを滑り込ませる
      const list = document.getElementById("learning_logs_list");
      if (list) {
        // 小数点第1位まで計算
        const calculatedHours = (data.log.duration_mins / 60.0).toFixed(1);
        const newLogHtml = `
          <div style="background: #e0f2fe; padding: 15px; border-radius: 8px; color: #333; margin-bottom: 10px; transition: all 0.5s ease;">
            <strong>${data.log.learned_on}</strong> ｜ ${calculatedHours} 時間 (${data.log.duration_mins}分)
            <p style="margin: 5px 0 0 0; color: #666; font-size: 0.95rem;">${data.log.memo || ""}</p>
          </div>
        `;
        list.insertAdjacentHTML("afterbegin", newLogHtml);
      }

      // 3. 入力フォームを綺麗にして次へ備える
      form.reset();

    } else {
      alert("出荷エラー：日付が重複しているか、入力値が不正です。");
    }
  } catch (error) {
    console.error("通信エラーを検知:", error);
    alert("サーバーとの通信に失敗しました。");
  }
};

// Turboの読み込み時、および通常のページ読み込み時の両方で確実に発動させる
document.addEventListener("turbo:load", 初期化);
document.addEventListener("DOMContentLoaded", 初期化);