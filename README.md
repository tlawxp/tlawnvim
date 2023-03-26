# tlawnvim

Configurasi nvim

![20230326_074713](https://user-images.githubusercontent.com/101454769/227749296-995edd92-dcfd-4b2b-8db2-60d2304a9181.gif)

## instalasi

cukup ikuti langkah langkahnya

install vim-plug
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

```
install nodejs
```bash
apt install nodejs
```
Clone repository
```bash
git clone https://github.com/tlawxp/tlawnvim
```
Sebelum masuk ke directory tlawnvim, pastikan kalian harus punya dulu directory ~/.config/nvim
```bash
mkdir ~/.config
mkdir ~/.config/nvim
```
Masuk ke directory
```bash
cd tlawnvim
```
pindahkan file init.vim ke directory ~/.config/nvim
```bash
mv init.vim ~/.config/nvim
```
untuk menjalankan sebuah nvim ketik
```bash
nvim
```
saya anggap kalian sudah masuk ke dalam nvim, untuk menginstall sebuah plugin ketik
```bash
:PlugInstall
```
Otomatis nvim akan menginstall sebuah plugin

untuk update plugin cukup ketik
```bash
:PlugUpdate
```


## add plugin

ingin menambahkan plugin, masuk ke directory .config/nvim edit file init.vim lalu tambahkan plugin di bagian.
```bash
call plug#begin()
  Plug [name]
call plug#end()
```

## install coc

untuk menginstall sebuah bahasa pemrograman seperti css,html,js,php dan py

cukup ketik di dalam nvim

CONTOH : 
```bash
:CocInstall coc-pyright
```
Update coc
```bash
:CocUpdate
```
untuk lebih detailnya kunjungi <a href="https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions">coc extensions</a>
