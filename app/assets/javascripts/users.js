$(document).ready(function(){
  $('.delete').on("click",function(){
    alert('ユーザー情報を削除しました。ありがとうございました。')
  });

});


$(function(){
  // Strict Mode はスクリプトや関数の先頭で文字列 'use strict'; を追加することで有効になる。
  'user strict';

  // 定数にdocument上のIDを入れます　documentはブラウザに読み込まれたwebページ
  const select_year = document.getElementById('user_year');
  const select_month = document.getElementById('user_month');
  const select_day = document.getElementById('user_day');
  // なんでも使えるiを生成
  let i;

  // 年を生成する関数を作成
  function $set_year(){
    for(i = 1919; i < 2020; i++){
      // document.createElement()はtagNameで指定されたHTML要素を生成し、
      // またtagNameが認識できない場合はHTMLUnknownElementを生成
      // <option>タグはセレクトボックスの選択肢を指定するタグ
      let op = document.createElement('option');
      // optionタグのvalueとtextをiに(1919から2020)
      op.value = i;
      op.text = i;
      // appendChild()で親要素に子要素を追加
      select_year.appendChild(op);
    }
  }
  // 月を生成
  function $set_month(){
    for(i = 1; i <= 12; i++){
      let op = document.createElement('option');
      op.value = i;
      op.text = i;
      select_month.appendChild(op)
    }
  }

  function $set_day(){
    // 日の選択肢を空にする
    // .childrenは指定した要素の子要素のコレクションを返す
    // IDがselectdayの部分
    let children = select_day.children
    // .lengthは配列の最後のインデックスに+1した値が入る
    // 日付の子要素が空になるまで子要素を取り除く
    while (children.length) {
      children[0].remove()
    }
    // 日を生成（動的に変える）
    if (select_year.value !== '' && select_month.value !== '') {
      const last_day = new Date(select_year.value,select_month.value,0).getDate()
      // Date()は指定した日付を表す日付オブジェクトを生成。 .getDate()は地方時の日を1~31の整数で返す
      for(i =1; i <= last_day; i++){
        let op = document.createElement('option');
        op.value = i;
        op.text = i;
        select_day.appendChild(op);
      }
    }
  }

  // load時、年月変更時に実行する
  window.onload = function(){
    $set_year();
    $set_month();
    $set_day();
    // changeはユーザーによる要素の値の変更が確定した時に発生
    // addEventListenerで第一引数が行われた際に第二引数を行う
    select_year.addEventListener('change',$set_day)
    select_month.addEventListener('change',$set_day)
  }

});
