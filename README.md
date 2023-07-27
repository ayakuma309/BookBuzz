■ サービス概要
マスクをした本たちは、本の選び方に悩む人に、新しい本との出会いを提供するサービスです。

■ユーザーが抱える課題
- 時間やエネルギーをかけて本を選ぶ必要がある
- 自分の好みや関心に合った本を見つけるのが難しい
- 新たなジャンルや著者に挑戦したい

■課題に対する仮説
- 時間やエネルギーをかけて本を選ぶ必要がある
  - ユーザーは多くの本の中から自分に合った本を見つけるために時間やエネルギーを費やしています。ランダム機能やいつもより異なった選び方をすることで、本選びの効率が向上すると考えられます。
- 自分の好みや関心に合った本を見つけるのが難しい
  - 自分の好みや関心に合った本を見つけることは、試行錯誤や情報収集が必要な作業です。本の表紙から選ぶのではなく内容から選ぶことによって自分に合った本を判断することができ、本選びのストレスが軽減されると考えられます。
  また本の内容を一度に提供するのではなくランダムでユーザーが選択して投稿したものを提供することによって一度に選ぶストレスを軽減します。
- 新たなジャンルや著者に挑戦したい
  - 新たなジャンルや著者に挑戦することは読書の醍醐味の一つですが、どの本を選べば良いのか迷うことがあります。ジャンルのデータやそのジャンルに紐づいたデータをAPIから取ってくることによって選択したユーザーは新しいジャンルによる読書体験に挑戦するのが容易になり選択するストレスを軽減します。

■解決方法
- ユーザーはまず自分が気に入った本を投稿します。また他のユーザーは全体に投稿されたデータからランダムに本の内容のデータが与えられそこから気になったものを選択し本と出会うことができます。
またジャンルから選択することでそのジャンルに紐づいたデータを取得しそこから本を選択することができます。

■メインのターゲットユーザー
- 本の選び方に迷っている読書愛好家
- 新たなジャンルや著者に挑戦したい人
- 自分の好みや関心に合った本を見つけたい人

■実装予定の機能
- 未ログインユーザー
    - 本日のおすすめ表示機能: 登録された本の内容を3つ表示し、ユーザーが直感的に気に入った内容から本を選択できる機能
    - ジャンルおすすめ機能: ジャンル一覧から本のおすすめを表示する
    - ユーザーの新規登録ができる
    - 登録済みユーザーがログインできる
    - 本日のおすすめ機能をTwitterで共有できる
- ログインユーザー
    - 本日のおすすめ表示機能: 登録された本の内容を3つ表示し、ユーザーが直感的に気に入った内容から本を選択できる機能
    - 選択した本の著者おすすめ機能: 本日のおすすめから選択した詳細画面にてその本の著者の他のおすすめ本を表示する機能
    - ブックマーク機能: おすすめから出てきたものを後で見れるようにする

■なぜこのサービスを作りたいのか？
- 読書愛好家や読書初心者が時間やエネルギーをかけずに魅力的な本を見つける手助けをしたい
- 読書体験を豊かにし、新たなジャンルや著者に挑戦する機会を提供したい
- ユーザーに直感的で楽しい本の選択体験を提供し、読書の幅を広げることを目指したい

■スケジュール

企画〜技術調査：6/23〆切
README〜ER図作成：6/16 〆切
メイン機能実装：6/24 - 6/30
β版をRUNTEQ内リリース（MVP）：7/15〆切
本番リリース：7月31日

■技術選定
- Rails7
- postgresql
- Hotwire
- Tailwind css
- daisyUI
- heroku
- Rakuten Books APIs(Books Book Search API,Books Genre Search API)


■画面遷移図
[画面遷移図](https://www.figma.com/file/3RinAW89QggztgO5Cv3c8O/Untitled?type=design&node-id=0-1)
■ER図
[ER図](https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1&title=%E5%90%8D%E7%A7%B0%E6%9C%AA%E8%A8%AD%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB.drawio.png#R7Z1Rc6q6Fsc%2FjY%2FtCIjYx2rbve857ZxOz7739tyXTrZEzSkSJ8RW%2B%2BlvAgmCQQ%2FpVrEkM52OCSHCWn%2Fyg2Qt7Hij%2BeobAYvZAw5h1HG74arj3XRc1x8E7D%2BvWGcVgd%2FNKqYEhVmVs6n4E31AUSmbLVEIk1JDinFE0aJcOcZxDMe0VAcIwe%2FlZhMclb91AaZQqfhzDCK19r8opLOsdiDPgtd%2Fh2g6k9%2FsdMWWOZCNRUUyAyF%2BL1XBFb3DMRWH%2BAjJHMQwpmzLAyCvkHT82xml%2FEyvO%2B4d%2B5vw1pdTjKcRBAuUXI7xnFWPE9bkbgLmKOJmLnQ0FB2xr%2FNuO96IYEyzT%2FPVCEbcVdIN2THd7dia24HwfmvsMLp4W9%2B%2Fdmn8%2Fd37D314mD4GPy9EL28gWgr7CtvQtTQ4DJn9RZF9FaLrJxgBinB8u9kyhHF4zb3LGt0%2BfUCCf%2BAHELOTHyYUELrZhmPR%2FA6xw%2FNuHNlElLvpVkrWz8XCX7xw6cvizaq48WYtSytE090urwZ9UeZ7OpeO44ryZldeKO7JvITmkDLnZHWqgYW1ErwkY2Gdf7nPf%2F9B4%2Bh%2F0ev8md48%2FzFZ%2F30hjMjOagrpnnaelF1Y0rzw3zeI2eGQNWvwvlF6rudZUeWykqSueStfK0DoeZp3mH%2FHI0apvMXo4MnLSAwOnrzqZRfZqYu9imLb6qjnbXXU88sdZbZROmIfCie%2BqUq1rKNrt1XCPr4Uff%2FcpNgtK8jvf1KKuYZFR4PuVkeHk2KlZdUh9t9JBoCSGhmNFvwjBT9T3aXSEfj1uAYYUClAcTo8OWk5isAiQWnzrGaGovAerPGSyo5kaThBKxg%2BZfTlbZlq71lniRAY55i8FvhmEKFpzD6PmeD4Nw4JTNix3IOEihbpHtnhOf19En2DhMLVXk3JrUHZU650eUFzbpXm3KC7W14lf%2Bo6r8YwUnLcEx8MhjNM0Ad3l7zui85My%2B9oHrE7gu8QhFtVQxzKq37CBo4RjjD3eJwNL2Wn80YhwYsf8urmFQsu5NQO%2FpD9McuM%2BADjs2MdsbKzKbM%2F3pzQEY4TSgBKPQeZj98h9%2FOQ4oXoNIIT2T8Rdueff2JK2Q1PXUXsvT7%2BWSaSJTVV4R1LFJ4iisffd8qCnT9FIHpi98IgnkaZE9NbY7BxYoWnK22f23vbEdvXL2bmnEQpmWYoDGH8ef%2B4tf1TcIin6Q%2FR2cZK2r2BiA1UMaDsAlrGYXKMkbyn%2BJ01b9bvcpzO2g6TBRijeHqf7dnfEobflDBWnV0Xbj7kH0Yotbo7gVJ8i41a2Oh%2BXn3a2Kh7M3E0bPTri%2BI0gwcMkezvwMzwazun7cwIFKfHYA7T%2BSPmeMIG63MnSCOyMI4YA0uMsyPGVdPEuDKHGIPazmk7MeR0VcHrcA5QZCgz6gvDOGY4NVZvLDRODA3HbZoaddY%2B2oINp75%2FWs8NdVpyTNYLCsOXBUiSd0zY3teSH%2BxhlC%2BMSEMbgRINsRjHkjwowqKjOXT4TaMjX1ZuHymkwC0pLuT9QIEUCftag0igIQbjSOD0LAkaJ8GgaRI4fmtJIAVuSXDhqGtSBPNjNYYEGmIwjgSuZ0nQNAnyuPvmngl23w98dRJIgVsSXLhqyMqYQMBnjwDNlh5CVqJobhIdNARiHh36lg6N06HXOB2C9tKhX9sdraeDGp6yXITG06G%2BQMyjgxq7MsT4NdnPjC0%2BGJL34m9l3bkV6wD5jFDZr0dLcVCDUCztD5z4kl8iv5L5skMXx5KFGnHS5tSX%2FCqwdwCeumZkdPKLhjT2sN8%2FLPvrdHcKraiRKBYeB35U1IdHRf7LieGh5s%2FdNQ2P4z09enZuMTeFOre4TCB5OX%2BANKMH84ChkRpngXEqYFSkv5wYGGryXHtxYScbc1Ook40UUaOiEjTU0GZYXHneiwc%2FHuPrpEu%2FfYsmvd5vcpHEoqFBNFQluRyNDZUqaAUJ9unbLBBUWkKdRgBLyq7sdoLgF8XQZg5UM1IjO9qS4WRkqL92daSnBhkSYcRTQ33%2FtAgW1W5Xl6ZCmIwJWvA3erYTGb%2BqCeOY0bOIOANEVCS3nBgRuwPbvzoRpMItES566nrTT4xfX9Ccv2LeHCBoSMI8IOxOc7NAOBUQqnJcTgyE3bHsXx4I9l2MuSnU9SQUT%2FBLhOLXLIiZWcikNHgNbZhHhoElQ%2FNkqMhvOTEZrtpLBvvOxfzFtOqcoc1%2B1BGIcXjw7TL0GeAhaBoPfnvXFnwjF6KrTaGuRNv0Rx2BmIcHde6Rpz%2FOAbEpkNXKKKdABnWXkfPKww%2Ft9kdc6iH%2FF1Ig%2FfpvXzqXFEhfjVVvcwqkb6cPc1NUTB%2BG5877I6ZAakjDPP7b33M5%2BvOiPjwaT4H01ZjFFqdA%2BnaCMf%2FtN3WC0bwUSA09GAeMvv0tlzMERuMpkH3XJGD07ZRjbgp1yjELXjMJGBp6MA8Y6gyjBUbjwDhpYmS1LjSmLb88L%2Byb%2FHNTqNOShQgGg5BxkPf5txQZNqTtDAjReIJkv70hbX0745T%2F8HzFjNMmZsEgINhJp922qfGCJRhOoVxAYpZGdP0EI8Bzam83W4YwDq8JSR12%2B%2FQBCf6BH0C8lvTYbMvkwprfIX6s6QCQNhHldHxYIfrMPl90L7tdR1T8xTdedq9cUb5ZFVrfrAuFR0gQs0waLdGtFIqM3cNLMoZ77CMj0qhE1E4MiJtubqy6o45T9Z7%2BvJKkRn6DpQPeo7RHDs6ChmVKjaCOH2ypKzt3sddGWWpHbrmj4Movd5TZRunoYMOYOi86AnQ8W8wISKCNpakYvwZe2WW1l72cbZEc7JYjUKcx7a3ogWNpgvpCOZdYmkCd5GxzLE1%2BFdi700CdvTz%2Fme0jxtJoSMO4u9TABmIefR5DHx51byrco8FDnfFs8dJocLA4zH0O0WfHdm%2BnGA%2FUp1bzlkY19KAJjM%2Fro1Z3pxCIDb48Q2A0%2FtanQOOFkV8eF3YiXJpCaqy4MsqMCmOTZsE19GDc88XAhl6eIS6cxl8KNdCYtPzqvBjU90%2FreaFOShoZSaMhCfOQ0bOEaJ4Qjb8carD77ZFfHgg2tDI3hTrRaGQkjYYkzAPCwSJpis7hsS4zOpdxMruDbMrxNISfJsyJUoDOIGtbKI2X5C1tmn0Bs8KzHFt4IYu68WVxE3STlopRN8%2ByjzxWx%2B%2Fsi9RRRVc3Kke69x%2BjcuSi2tlE5Wz%2F0Lt%2FtaXUulE5%2Fa2OetsdfToqhxUJxrTYnIDF7AGHkLf4Pw%3D%3D)
