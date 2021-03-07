ロボコン本戦運営のスクリプトの解説

# ロボコン本戦運営のスクリプトの解説
https://github.com/p-robotics-hub/burger_colosseum/
以下にあるスクリプトについて、使い方を説明する。

## ジャッジサーバー起動
judge_scripts/judge_start.sh
(引数無し)

以下の動作を行う
1. ジャッジサーバーが起動 ( gnome-terminal )
2. ジャッジウインドウが起動
3. Firefoxが起動し、http://192.168.0.100:5000 へアクセス

![screenshot](image/judge-browser.jpg)

1. RESET judge
2. SET UP
3. Be READY robo
の順番にクリックし、サーバーをReady状態にしておく

## 参加者のレポジトリをCloneする
burger_colosseum/ws_scripts/clone_ws_robo.sh
- (第1引数) レポジトリ名 例: p-robotics-hub

このスクリプトの使用には、`~/catkin_ws_robo/src/*`に、リファレンスとなる
`burger_war_dev`、`burger_war_kit`および`burger_colosseum`を入れておく必要がある。


使用例
```
./clone_ws_robo.sh p-robotics-hub
```

まず最初に、下記を実行してホームディレクトリにこのスクリプトのシンボリックリンクを作っておく。
```
ln -s ~/catkin_ws_robo/src/burger_colosseum/ws_scripts/clone_ws_robo.sh ~/
```

以下の動作をする。
1. ホームディレクトリに、というように、`catkin_ws_{レポジトリ名}/src`のディレクトリをつくる。例: 
`~/catkin_ws_p-robotics-hub`
2. レポジトリをcloneする
3. `burger_war_kit`, `burger_colosseum`)をcatkin_ws_roboからコピーする
4. `burger_war_dev/docker/robo`をcatkin_ws_roboからコピーする
5. `burger_war_dev/commands/*`をcatkin_ws_roboからコピーする
6. `burger_war_dev/commands/config.sh`をレポジトリ名に書き換える
	
	
スクリプトの最後に次に入るべきディレクトリが指示されている。

上で作られた`catkin_ws_{レポジトリ名}/src`の中の`burger_colosseum/docker_robot_scripts`のスクリプトを使う。

## コンテナのビルド
docker_robot_scripts/build_container_robo.sh
(引数無し)

コンテナをビルドする。ライブラリの追加が無ければすぐに完了する。

必要なライブラリは、`burger_war_dev/docker/core/Dockerfile`
に記述する。

## コンテナをランチする
docker_robot_scripts/launch_docker_robo.sh
(引数無し)

起動すると設問があるので、赤側(r)か青側(b)かを選ぶ。
コンテナが起動し、ロボットがbring_upする。

## ロボットをスタートする
docker_robot_scripts/start_robo.sh
(引数無し)
起動すると設問があるので、赤側(r)か青側(b)かを選ぶ。
ユーザープログラムが動き出す。

## ロボットを停止する
まず、`Ctrl+c`でユーザープログラムを停止する。

そのままでは、最後の速度指令のまま動き続けてしまうので、

docker_robot_scripts/start_robo.sh
(引数無し)

を実行してロボットを止める。

## コンテナの中に入ってメンテナンスする
docker_robot_scripts/enter_container.sh
(引数無し)

コンテナの中に入ってメンテナンスができる。`apt`や`pip`、`rosdep`なども使える。
`apt`を使う場合まず`sudo apt update`を行う必要がある。
`rosdep`を使う場合、`catkin build`を行って後でないといけない。
