# 説明
- ubuntuの手動でのインストールするためのシェル
- インストール対象のデバイスとは別のデバイス上で実行する
- シェルの実行前に`./conf/conf-sample.sh`の記載に従い、適切に設定ファイルを作成する
- シェルの実行前に`./conf/conf_mnt-sample.sh`の記載に従い、適切にディスク情報を作成する
    - ただし、`1a_create_disk.sh`か`1b_parted_format.sh`を実行する場合は自動で設定されるため、ファイルの用意でよい
- シェルの実行前に`./conf/conf_part-sample.sh`
    - ただし、`1a_create_disk.sh`か`1b_parted_format.sh`を実行する場合にのみ使用する
- 最初にディスクを初期化する方法として`1a_create_disk.sh`と`1b_parted_format.sh`の2種類ある
- カーネルのバージョンは[ここ](https://www.hpe.com/jp/ja/servers/linux/matrix/index-26-ubuntu.html)から最適なバージョンを確認する
    - `apt upgrade`を実行すると、カーネルのバージョンが上がり、OSに合わなくて起動できなくなることがあった

# 各シェルについて

- `1a_create_disk.sh`
ディスクイメージを直接作成する\
`./disk`ディレクトリに生成される\
`91a_~~`から`93a_~`によって、バックアップ&復元ができる
`./conf/conf.sh`の`_DISK_BASE`は中で適切に設定される

- `1b_parted_format.sh`
物理ディスクに対してパーティションの作成を行う

- `2_debootstrap.sh`
デブートストラップを実行する\
これにより、ubuntuの最小構成を作成する

- `kernek_install.sh`
カーネルとinitrdのインストールを行う

- `4_user_setting.sh`
ユーザー設定(時差やキーボード設定)を行う

- `5_grub_install.sh`
grubのインストールを行う

- `71_connect_disk.sh`
ディスクイメージファイルをループバックディスクに展開し、設定ファイルのmntとディスクファイルの値を書き換える

- `72a_disconnect_disk.sh`
ディスクイメージファイルをループバックディスクから解除する

- `81_open.sh`
マウントを実行する

- `82_open.sh`
umountする。`81_open.sh`をした場合にのみ利用する

- `83_chroot.sh`
mountをし、chrootをする。exit後、umountまで行う

- `91a_~`から`93a_~`
`1a_create_disk.sh`で生成されたdiskイメージにのみ有効\
`1b_~`で使用した場合にどうなるかはわからない

# 蛇足
- `3_kernel_install.sh`について
    - `ubuntu-minimal`をインストールしているが、なくても起動は可能ただしその場合は`4_user_setting.sh`で使用している`systemd-networkd`や`dpkg-reconfigure *`が使えなかったため導入した
    - `linux-headers`はdkmsを使用するのに必要で、nvidiaのdriverを適用させるのに必要
    - `linux-modules-extra`も同様の理由で入れておく。なお`linux-modules`は`linux-image`のインストールでデフォルトで入る

# 参考サイト
- [パーティション作成](https://qiita.com/kakkie/items/8f960f2dc5eb6e591d9d)
- [ドライバー確認](https://qiita.com/aosho235/items/079b37a9485041b96ed0)
- [Ubuntuの手動インストール](https://gist.github.com/subrezon/9c04d10635ebbfb737816c5196c8ca24)
- [debootstrapのvariantによる違いについて](https://zat.ifdef.jp/html/2008/04-03.html)
- [man debootstrapの情報が記載](https://linux.die.net/man/8/debootstrap)
- [aptのsource.listについて](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0677)
