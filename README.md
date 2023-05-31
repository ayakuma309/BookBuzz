■ サービス概要
BookBuzzは、本の選び方に悩む人に、魅力的なキャッチフレーズから新しい本との出会いを提供するサービスです。

■ユーザーが抱える課題
- 時間やエネルギーをかけて本を選ぶ必要がある
- 自分の好みや関心に合った本を見つけるのが難しい
- 新たなジャンルや著者に挑戦したい


■課題に対する仮説
- 時間やエネルギーをかけて本を選ぶ必要がある
  - ユーザーは多くの本の中から自分に合った本を見つけるために時間やエネルギーを費やしています。キャッチフレーズを活用することで、本の魅力や内容を短い文で伝えることができ、本選びの効率が向上すると考えられます。
- 自分の好みや関心に合った本を見つけるのが難しい
  - 自分の好みや関心に合った本を見つけることは、試行錯誤や情報収集が必要な作業です。キャッチフレーズを提供することで、ユーザーは一目で自分に合った本を判断することができ、本選びのストレスが軽減されると考えられます。
- 新たなジャンルや著者に挑戦したい
  - 新たなジャンルや著者に挑戦することは読書の醍醐味の一つですが、どの本を選べば良いのか迷うことがあります。キャッチフレーズを通じて新たなジャンルや著者の魅力を伝えることで、ユーザーは新しい読書体験に挑戦する意欲が高まると考えられます。

■解決方法
- ユーザーはまず自分が気に入った本を選択し、OpenAIがその本に対してキャッチフレーズを生成します。ユーザーは生成されたキャッチフレーズと本を組み合わせて登録し、他のユーザーがキャッチフレーズを選んでそのキャッチフレーズに関連する本を提供することができます。

■メインのターゲットユーザー
- 本の選び方に迷っている読書愛好家
- 新たなジャンルや著者に挑戦したい人
- 自分の好みや関心に合った本を見つけたい人

■実装予定の機能
- 未ログインユーザー
    - キャッチフレーズ一覧表示機能: 登録されたキャッチフレーズを一覧表示し、ユーザーが直感的に気に入ったキャッチフレーズを選択できる機能
    - 選択した結果を表示する詳細ページ(そのキャッチフレーズがつけられた本を表示する)
    - ユーザーの新規登録ができる
    - 登録済みユーザーがログインできる
- ログインユーザー
    - 本の選択機能: ユーザーが様々な条件（ジャンル、著者、キーワードなど）を指定して本を検索・選択できる機能
    - キャッチフレーズ生成機能: OpenAIを活用して本のキャッチフレーズを自動生成する機能
    - キャッチフレーズ登録機能: ユーザーが選んだ本と生成されたキャッチフレーズを登録できる機能

■なぜこのサービスを作りたいのか？
- 読書愛好家や読書初心者が時間やエネルギーをかけずに魅力的な本を見つける手助けをしたい
- 読書体験を豊かにし、新たなジャンルや著者に挑戦する機会を提供したい
- ユーザーに直感的で楽しい本の選択体験を提供し、読書の幅を広げることを目指したい

■スケジュール

企画〜技術調査：5/31〆切
README〜ER図作成：5/31 〆切
メイン機能実装：5/31 - 7/15
β版をRUNTEQ内リリース（MVP）：7/15〆切
本番リリース：7月末

■技術選定
- Rails7
- postgresql
- Hotwire
- Tailwind css
- daisyUI
- heroku
- Google Books API
- OpenAI API

■画面遷移図
https://www.figma.com/file/3RinAW89QggztgO5Cv3c8O/Untitled?type=design&node-id=0-1
