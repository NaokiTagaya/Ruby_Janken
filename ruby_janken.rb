begin
   # あっち向いてホイモジュール
   module Atchimuitehoi
    # じゃんけんに勝った場合のあっち向いてホイ
    def atchimuitehoi_win
       puts "あっち向いて〜"
       puts "指を差す方向：0（上） 1（下） 2（左） 3（右）"
       # プレイヤーは指差す方向を選択し、CPUはランダムで顔を向く方向を選択する。
       player_finger = gets.to_i
       cpu_face = rand(4)
       puts "ホイ！"
       puts "-------------"
       # 上下左右いずれか選択した場合
       if player_finger == 0 || player_finger == 1 || player_finger == 2 || player_finger == 3 then
          puts "あなた：#{Directions[player_finger]}"
          puts "相手：#{Directions[cpu_face]}"
          # 差す方向が一緒だった場合はfalseと「win」を返す
          if player_finger == cpu_face then
             return false, "win"
          # 差す方向が違った場合はtrueと「again」を返し、じゃんけんからやり直す
          else
             return true, "again"
          end
       # それ以外
       else
          puts "相手：真面目にやらんかい！･:，(ﾟдﾟ○≒(｀д´＃)"
          return false, "none"
       end
    end
    # じゃんけんに負けた場合のあっち向いてホイ
    def atchimuitehoi_lose
       puts "あっち向いて〜"
       puts "顔を向く方向：0（上） 1（下） 2（左） 3（右）"
       # プレイヤーは顔を向く方向を選択し、CPUはランダムで指差す方向を選択する。
       player_face = gets.to_i
       cpu_finger = rand(4)
       puts "ホイ！"
       puts "-------------"
       # 上下左右いずれか選択した場合
       if player_face == 0 || player_face == 1 || player_face == 2 || player_face == 3 then
          puts "あなた：#{Directions[player_face]}"
          puts "相手：#{Directions[cpu_finger]}"
          # 差す方向が一緒だった場合はfalseと「lose」を返す
          if player_face == cpu_finger then
             return false, "lose"
          # 差す方向が違った場合はtrueと「again」を返し、じゃんけんからやり直す
          else
             return true, "again"
          end
       # それ以外
       else
          puts "相手：どこ向いとんねん！･:，(ﾟдﾟ○≒(｀д´＃)"
          return false, "none"
       end
    end
   end
   
   # じゃんけんクラス
   class JankenApp
      # あっち向いてホイモジュールをマージ
      include Atchimuitehoi
      # じゃんけん
      def janken
       puts "0（グー） 1（チョキ） 2（パー） 3（戦わない）"
       # プレイヤーはじゃんけんの出す手を選択し、CPUはランダムで出す手を選択する。
       player_hand = gets.to_i
       cpu_hand = rand(3)
       puts "ポン！"
       puts "-------------"
       # グー、チョキ、パーいずれか入力した場合
       if player_hand == 0 || player_hand == 1 || player_hand == 2 then
          puts "あなた：#{Jankens[player_hand]}を出しました。"
          puts "相手：#{Jankens[cpu_hand]}を出しました。"
          # あいこだった場合はtrueを返す
          if player_hand == cpu_hand then
           puts "あいこで..."
           return true, "aiko"
          # プレイヤーが勝った場合ははfalseと「win」を返す
          elsif (player_hand == 0 && cpu_hand == 1) || (player_hand == 1 && cpu_hand == 2) || (player_hand == 2 && cpu_hand == 1)
           return false, "win"
          # プレイヤーが負けた場合はfalseと「lose」を返す
          else
           return false, "lose"
          end
       # 3(戦わない)を入力した場合
       elsif player_hand == 3 then
          puts "あなた：戦わんよ・・・（　´_ゝ`）"
          puts "相手：戦わんのかい(；´Д｀)"
          return false, "none"
       # その他値を入力した場合
       else
          puts "相手：何か出せや！･:，(ﾟдﾟ○≒(｀д´＃)"
          return false, "none"
       end
      end
   end

   # 定数
   Jankens = ["グー", "チョキ", "パー"]
   Directions = ["上", "下", "左", "右"]
   # 初期値
   notend_flg = true
   janken_result = ""
   ah_result = ""
   janken = JankenApp.new()
   # あっち向いてホイが決着つくまで繰り返す
   while notend_flg do
    aiko_flg = true # あいこフラグ
    # じゃんけんスタート
    puts "最初はグー！じゃんけん..."
    # あいこだった場合はじゃんけんを繰り返す
    while aiko_flg do
       aiko_flg, janken_result = janken.janken()
    end
    # じゃんけん結果
    case janken_result
       # じゃんけんに勝った場合
       when "win"
          notend_flg, ah_result = janken.atchimuitehoi_win()
       # じゃんけんに負けた場合
       when "lose"
          notend_flg, ah_result = janken.atchimuitehoi_lose()
       # それ以外
       else
          break
    end
   end
   # あっち向いてホイ結果
   case ah_result
    # あっち向いてホイに勝った場合
    when "win"
       puts "あなたの勝ち！おめでとう！(`･ω･´)"
    # あっち向いてホイに勝った場合
    when "lose"
       puts "あなたの負け、残念・・・(´·ω·`)"
    # それ以外
    else
       puts "〜THE END〜"
   end
rescue
   puts $! # 例外オブジェクトを出力する
   puts $@ # 例外が発生した位置情報を出力する
   puts "例外エラーが発生しました(ﾟдﾟ)"
end