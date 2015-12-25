# Based on this AUR pkg: https://aur.archlinux.org/packages/vim-x11/ 
# Might need to bump the pkgver variable to the current version before running makepkg
# You can manually download Vim 7.4.944 source from this archive: http://github.com/vim/vim/archive/v7.4.944.tar.gz

_pkgbase=vim
pkgname=vim-x11-spcmd
pkgver=7.4.944
_versiondir=74
pkgrel=1
_upstream_pkgrel=1
arch=('i686' 'x86_64')
license=('custom:vim')
url='http://www.vim.org'
makedepends=('python2' 'libxt' 'lua')
source=("vim-$pkgver.tar.gz::http://github.com/vim/vim/archive/v$pkgver.tar.gz")
#source=("vim-7.4.944.tar.gz")
sha1sums=('SKIP')
pkgdesc='Vim with X11 and clipboard support (spcmd config)'
depends=("vim-runtime=${pkgver}-${_upstream_pkgrel}" 'python2' 'acl' 'lua')
conflicts=('vim-minimal' 'vim' 'vim-python3' 'gvim' 'gvim-python3' 'vim-x11')
provides=("vim=${pkgver}-${_upstream_pkgrel}" 'xxd')

prepare() {
  cd vim-$pkgver

  # define the place for the global (g)vimrc file (set to /etc/vimrc)
  sed -i 's|^.*\(#define SYS_.*VIMRC_FILE.*"\) .*$|\1|' \
    src/feature.h
  sed -i 's|^.*\(#define VIMRC_FILE.*"\) .*$|\1|' \
    src/feature.h

  (cd src && autoconf)

  cd "$srcdir"
  for pkg in ${pkgname[@]}
  do
    cp -a vim-$pkgver ${pkg}-build
  done
}

build() {

  cd "${srcdir}"/"${pkgname}"-build

# --enable-luainterp is needed for lua support
# lua support is required by some vim plugins (e.g.: https://github.com/Shougo/neocomplete.vim)

  ./configure \
    --prefix=/usr \
    --localstatedir=/var/lib/vim \
    --with-features=normal \
    --with-compiledby='Arch:spcmd' \
    --enable-multibyte \
    --enable-acl \
    --enable-luainterp \
    --with-x=yes \
    --disable-gpm \
    --disable-gui \
    --disable-netbeans \
    --disable-cscope \
    
  make
}

package() {
  cd "${srcdir}"/"${pkgname}"-build
  make -j$(nproc) VIMRCLOC=/etc DESTDIR="${pkgdir}" install

  # provided by (n)vi in core
  rm "${pkgdir}"/usr/bin/{ex,view}

  # delete some manpages
  find "${pkgdir}"/usr/share/man -type d -name 'man1' 2>/dev/null | \
    while read _mandir; do
    cd ${_mandir}
    rm -f ex.1 view.1 # provided by (n)vi
    rm -f evim.1    # this does not make sense if we have no GUI
  done

  # Runtime provided by runtime package
  rm -r "${pkgdir}"/usr/share/vim

  # license
  install -Dm644 runtime/doc/uganda.txt \
    "${pkgdir}"/usr/share/licenses/${pkgname}/license.txt
}
