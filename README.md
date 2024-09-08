
# 簡易な予約システム
- flutterを使った簡易な予約システム
- 予約対象を選択して、その後日付を選択して予約する

## 参考にした情報
https://codewithandrea.com/
  
## 追加パッケージ
- go_router
- firebase
- firestore
- riverpod
- freezed
- その他上記関連パッケージ

### 補足

1. showDatePicker
showDatePickerについてはflutterのマニュアルに記載のState Restorationを考慮せず単体で使っている。

2. firebase/firestoreエミュレーター
使っている。クラウドとはつなげていない。

3. builder
riverpod, freezed関連
#
# メモ
### go_router
1. redirect
以下を参考にしたのでredirect:を使っているが機能を十分使っているとは言えない。
https://codewithandrea.com/videos/starter-architecture-flutter-firebase/  

1. パラメータ
パラメータ渡しはextraを利用していたがユーザー情報のところでnull checkに引っかかりここだけstate.pathParameters方式に切り替える。
   1. class Userをextra:で渡すとcodecを使えとなる
   2. Userの代わりにUserのuid(String)を渡すようにしたがnull checkに引っかかる
   3. state.pathParameters方式に切り替える

### freezed
パラメータ渡しにクラスを作成し必要に応じデータを追加していた。
```text
  ReservationInputsBase
  ReservationInputsExt extends ReservationInputsBase
```
freezedでextendsは依然サポートされていないようなので簡易な対応とした(extendsを諦めた)。

### firestore user ref
Firebase Authに登録されたユーザーをrefすることはできないのuidを使う。
