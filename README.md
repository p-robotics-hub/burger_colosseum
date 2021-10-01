# burger_colosseum
burger war 予選会用の自動対戦スクリプト

# 2021年2月大会予選（Docker＋aws使用）
## 前提
aws上でDockerを使って実行するようにした。

GPUインスタンスを使用するので、使用できるようにawsに制限緩和を申請する必要がある。

## 環境構築
以下を参考に「Swapの設定」まで行う。（Desktop環境をインストール以降は不要）

https://github.com/p-robotics-hub/aws-ec2-dev-env/blob/main/README.md

## Dockerインストール
以下を参考にインストールする。

https://github.com/p-robotics-hub/burger_war_dev/blob/main/STARTUP_GUIDE.md#1-%E3%83%9B%E3%82%B9%E3%83%88pc%E3%81%A7%E5%BF%85%E8%A6%81%E3%81%AA%E3%83%84%E3%83%BC%E3%83%AB%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB


## 対戦用スクリプトを準備する
1. cd ~/catkin_ws/src/burger_war_dev
2. git clone https://github.com/p-robotics-hub/burger_colosseum
3. ディレクトリ名を変えるcatkin_ws ⇒ catkin_ws_sim
```mv catkin_ws/ catkin_ws_sim```
4. 参加者のレポジトリーをCloneするスクリプトをHOMEディレクトリに置く（Symbolic Link）
```ln -s ~/catkin_ws_sim/src/burger_colosseum/ws_scripts/clone_ws.sh ~/```
5. 初期のカメラ視点を変更する（デフォルトでもよいが変更すると見栄えが良い）
    1. "~/catkin_ws_sim/src/burger_war_kit/burger_war/world/burger_field.world"の１６行目を編集 https://github.com/p-robotics-hub/burger_war_kit/blob/main/burger_war/world/burger_field.world#L16
    2. 下記に変更する ```<pose>0.0 0.0 3.0 -1.57 1.57 0.0</pose>```
    
## 対戦を実行する
1. cd ~/
2. ./clone_ws.sh github-repo-name
3. cd ~/catkin_ws_github-repo-name/src/burger_colosseum/docker_scripts
4. ./build_container.sh
5. ./launch_docker.sh
6. 全て終わると、~/catkin_ws_github-repo-name/　にmp4ファイルができている
7. ~/catkin_ws_github-repo-name/src/burger_war_kit/judge/log/game_result.log　に結果が格納されている

## 参考

実行中の試合の画面の中に入る方法
1. 5900番ポートをSSHでFORWADINGするとVNC Viewerを使ってデスクトップに入れる
参考） https://github.com/p-robotics-hub/aws-ec2-dev-env/blob/main/README.md#vnc%E3%81%A7%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%81%AB%E6%8E%A5%E7%B6%9A

コンテナを個別に起動して中に入る方法
1. cd ~/catkin_ws_github-repo-name/src/burger_war_dev
2. bash commands/docker-launch.sh -t sim -v github-repo-name
3. bash commands/kit.sh -t sim    # コンテナの中のターミナルに入れる
4. 5900番ポートをSSHでFORWADINGするとVNC Viewerを使ってデスクトップに入れる
		# 参考） https://github.com/p-robotics-hub/aws-ec2-dev-env/blob/main/README.md#vnc%E3%81%A7%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%81%AB%E6%8E%A5%E7%B6%9A



# 以下は古いドキュメント

# 2020年8月大会予選
## 前提
あまり大きくは変えていない。awsのec2で動かしている。

`burger_colosseum/script`　直下
- `match_202008_yosen.sh` - 敵プログラムの動かし方が変わったのに合わせた。録画をrecord_windows.shを使うようになった
- `record_windows.sh` - GStreamerを使って特定Windowのみを録画できるようにした。
- `movie_panelize.sh` - 動画を連結させる
- `lastframe.sh` - 動画の最後をJPGにする。点数チェックのため。

最後に下記を実行して動画を結合している。
```
cd ~/
echo file *cheese.mp4 >> files.txt
echo file *teriyaki.mp4 >> files.txt
echo file *clubhouse.mp4 >> files.txt
source ~/work/burger_colosseum/auto_start/init_settings 
ffmpeg -f concat -i files.txt -c copy ${CHALLENGER}-all.mp4
cp ~/work/OneNightROBOCON_ws/src/burger_war/judge/log/game_result.log ~/${CHALLENGER}-game_result.log
```

# 2020年3月大会予選

## 前提
今回は、すべてAWSのec2のGPUインスタンス上で実行することとした。

インスタンスは、各チームごとに用意した。

予選大会は各チーム３回試合を実施する。

クリーンな状態で試合ができるように、
試合毎にインスタンスを再起動する。

そのために、Ubuntuの起動時に、スクリプトが自動起動されるようにした。

下記の記述は2020年3月4日のレポジトリーを前提としている。

## 使い方
### ファイルの配置について
```
├── catkin_ws
│   ├── build
│   ├── devel
│   └── src                         ←ここに参加者のプログラムを`git clone`する
│       └── burger_war
│           ├── burger_navigation
│           ├── burger_war
│           │   ├── launch
│           │   ├── models
│           │   ├── scripts
│           │   ├── src
│           │   └── world
│           ├── doc
│           ├── judge
│           └── scripts
└── work
    ├── OneNightROBOCON_ws
    │   ├── build
    │   ├── devel
    │   └── src
    │       └── burger_war          ←ここにオフィシャルのレポジトリをclone。敵プログラムとモデル、JUDGEサーバーはここのを使う
    │           ├── burger_navigation
    │           ├── burger_war
    │           │   ├── launch
    │           │   ├── models
    │           │   ├── scripts
    │           │   ├── src
    │           │   └── world
    │           ├── doc
    │           ├── judge
    │           └── scripts
    └── burger_colosseum            ←burger_colosseumをclone。
        ├── auto_start              ←自動実行されるスクリプトがここに入る
        ├── etc                         使わない
        ├── launch                  ←参加者プログラムはここのLaunchを経由して起動する
        ├── robot_scripts               使わない
        └── scripts                 ←ここのスクリプトを使う
```

## 各スクリプトの説明
使うものだけを説明する。

`burger_colosseum/script`　直下
- `autostartup_exec.sh` - **このスクリプトをUbuntu起動時に自動実行するように設定しておく。**gnome-terminalをひとつだけ開いて、autostartup.shを実行する。
- `autostartup.sh` - auto_startディレクトリにあるスクリプトのうち最も若い数字のスクリプトを一つだけ実行する。実行後、実行されたスクリプトの拡張子が`*.sh~`に変更され、インスタンスが再起動する。こうすることで、スクリプト実行→再起動→スクリプト実行→再起動・・・が自動的に実行される。
- `autostartup_enabling.sh` - auto_startディレクトリにあるスクリプトの拡張子を`*.sh~`→`*.sh`に変更する
- `autostartup_remap.sh` - auto_startupディレクトリにあるスクリプト内のユーザー名を指定のものに変更する。使い方： `./autostartup_remap.sh user_name`
- `kill-burger.sh` - 使用した全てのプロセスをkillする
- `match_202003_yosen.sh` - 今回予選用のスクリプト。使い方：`./match_202003_yosen.sh user_name enemy`
- `movie_add_capture.sh` - 動画ファイルの上部にスクリプトを追加する。使い方：`./movie_add_capture.sh caption input.mp4 output.mp4`
- `movie_generate.sh` - HOMEディレクトリにある３試合の動画にキャプションを追加して、結合するスクリプト
- `set_window_pos.sh` - Gazeboの配置と視点を修正するスクリプト
- `set_window_pos_2.sh` - RVIZの配置と視点を修正して、Gazeboとjudgeウインドウを全面にだすスクリプト
- `wait_end_game.py` - 試合が終わるまで待つスクリプト
- `wait_ffmpeg.sh` - 動画のキャプチャ・変換が終わるまで待つスクリプト

burger_colosseum/auto_start　直下
- auto_start/*.sh - 自動実行されるスクリプトはここにいれる。最も若い数字のスクリプトが実行される。拡張子が`*.sh~`となっているものは実行されない。


## 使い方

### 前提
ROS Kinetic のインストールが完了していること。
[burger_war/README.md#インストール](https://github.com/OneNightROBOCON/burger_war/blob/master/README.md#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)を参照し、
環境設定まで終わらせる。
ワークスペース作成は下記の手順で行う。

### catkin_wsの作成とレポジトリーのclone
`catkin_ws`を作成し、**参加者のレポジトリー**をcloneする。

```
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace
cd ~/catkin_ws/
catkin_make
#devel/setup.bashの読み込みは行わない

cd ~/catkin_ws/src
#           ↓参加者のレポジトリ
git clone https://github.com/hogehoge_user/burger_war
cd ~/catkin_ws
catkin_make
```

### workの作成とレポジトリーのclone
workの下には、公式レポジトリと、対戦用スクリプト集burger_colosseumを入れる。
```
mkdir -p ~/work/OneNightROBOCON_ws/src
cd ~/work/OneNightROBOCON_ws/src
catkin_init_workspace
cd ~/work/OneNightROBOCON_ws/
catkin_make

cd ~/work/OneNightROBOCON_ws/src
git clone https://github.com/OneNightROBOCON/burger_war
cd ~/work/OneNightROBOCON_ws/
catkin_make

cd ~/work/
git clone https://github.com/hotic06/burger_colosseum
```

### 最低限必要なパッケージのインストール
```
# pip のインストール 
sudo apt-get install python-pip
#　requests flask のインストール
sudo pip install requests flask
# turtlebot3 ロボットモデルのインストール
sudo apt-get install ros-kinetic-turtlebot3 ros-kinetic-turtlebot3-msgs ros-kinetic-turtlebot3-simulations
# aruco (ARマーカー読み取りライブラリ）
sudo apt-get install ros-kinetic-aruco-ros

sudo apt-get install ros-kinetic-joy ros-kinetic-teleop-twist-joy ros-kinetic-teleop-twist-keyboard ros-kinetic-laser-proc ros-kinetic-rgbd-launch ros-kinetic-depthimage-to-laserscan  ros-kinetic-rosserial-arduino ros-kinetic-rosserial-python ros-kinetic-rosserial-server ros-kinetic-rosserial-client ros-kinetic-rosserial-msgs ros-kinetic-amcl ros-kinetic-map-server ros-kinetic-move-base ros-kinetic-urdf ros-kinetic-xacro ros-kinetic-compressed-image-transport ros-kinetic-rqt-image-view ros-kinetic-gmapping ros-kinetic-navigation ros-kinetic-interactive-markers

sudo apt install ffmpeg
sudo apt install wmctrl xdotool
```

### Launchファイルの修正
仮想敵プログラムのLaunchファイル（下記3種）で、自機が起動しないように修正する。

- `sim_level_1_cheese.launch`
- `sim_level_2_teriyaki.launch`
- `sim_level_3_clubhouse.launch`

下記の3行をコメントアウトする。`<!--`と`-->`で囲む。
```xml
<!--
  <include file="$(find burger_war)/launch/your_burger.launch">
    <arg name="side" value="r" />
  </include>
-->
```

### 参加者プログラムの動作を確認
下記が動くことを確認する。

```
source ~/catkin_ws/devel/setup.bash
export GAZEBO_MODEL_PATH=$HOME/catkin_ws/src/burger_war/burger_war/models/
export TURTLEBOT3_MODEL=burger

cd ~/catkin_ws/src/burger_war/
bash scripts/sim_with_judge.sh
```
フィールドとロボットが立ち上がったら 別のターミナルで下記ロボット動作スクリプトを実行
```
source ~/catkin_ws/devel/setup.bash
export GAZEBO_MODEL_PATH=$HOME/catkin_ws/src/burger_war/burger_war/models/
export TURTLEBOT3_MODEL=burger

cd ~/catkin_ws/src/burger_war/
bash scripts/start.sh
```

動かない場合、必要なライブラリを入れるなどの対応をとる。

典型的な動かない理由
- 必要なライブラリが入っていない。参加者に確認して入れる。
- スクリプトの実行権限が未設定。次のコマンドで設定する。`chmod +x userscript.py`
- プログラム中にファイルパスが絶対パスでハードコーディングされている。直す。
- GitHubのsubmodule設定の問題。認証関係のトラブルで、必要なレポジトリがcloneされてこない。認証を通さなくてもcloneができるようにしてもらう。
- your_burger.launchを使っていない。
- そもそも動かない。

### Ubuntuで自動起動の設定をする
`自動起動するアプリケーションの設定`を開く。
```
gnome-session-properties
```

追加をクリックし、下記を入力して、保存をクリックする。
- `名前` : auto_start
- `コマンド` : /home/ubuntu/work/burger_colosseum/scripts/autostartup_exec.sh

### auto_startを設定し再起動

下記を実行する。`~/work/auto_start/`内のシェルスクリプトの拡張子を変更する。`*.sh~`→`*.sh`
```
cd ~/work/burger_colosseum/scripts
./autstartup_enabling.sh
```
auto_start内のシェルスクリプトに書かれたユーザー名を任意のものに変更する。これはJUDGEサーバーのウインドウに表示するのに使われる。
```
./autostartup_remap.sh user_name
```

再起動すると、試合が自動実行される。
```
sudo reboot
```

`~/work/auto_start/`内のシェルスクリプトを実行→再起動をすべて実行し終わるまで繰り返す。３つの試合が自動実行される。
試合中のスクリーンキャプチャはホームディレクトリに自動保存される。

### 動画をまとめる

動画にキャプションを付けて、３つの試合動画を１つの動画に結合する。動画はホームディレクトリへ出力される。

```
cd ~/work/burger_colosseum/scripts
./mobie_generator.sh チームほげほげ
```

### ファイルをダウンロードする
下記2つのファイルをダウンロードして試合の実行は完了する。

- `~/work/OneNightROBOCON_ws/src/burger_war/judge/log/game_result.log` - 試合結果のログファイル
- `~/チームほげほげ.mp4` - 試合中のスクリーンキャプチャ


---
---
---
# 以下、２０１９年8月大会のREADME
## How TO USE
つかいかた。


### リポジトリのclone make
`clone_make_burger_fork_repo.sh` は実行すると https://github.com/OneNightROBOCON/burger_war をfork しているリポジトリをすべて
`~/wss/` clone し catkin_make する。
`~/wss/`ディレクトリがない場合は事前に作成してください。
```
bash clone_make_burger_fork_repo.sh
```



### 対戦リストの作成
match_list.csv にアカウント名をスペース区切りでならべる.
１行目から順にさいごの行まで試合を行う。

リスト手動でつくるのは大変なので、総当り用のリスト作成スクリプトなど作ったほうがいいかもしれません。


`match_list.csv` sample
```
ichiro jiro
foo bar
hoge hogehoge
```

### スクリプト実行
以上の準備ができたら下記を実行します。
```
python main.py
```


## その他
あまりテストできていないので、なにかぬけているかもしれません。
画面録画用のウインドウ位置の対応はまだできていません。。。


## 注意事項
burger_colosseumの置き場所はHOMEディレクトリ直下

.bashrcのROS関係の各種設定は消しておく。

