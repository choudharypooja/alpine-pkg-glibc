pkgname="glibc"
pkgver="2.35"
_pkgrel="1"
pkgrel="0"
pkgdesc="GNU C Library compatibility layer"
arch="x86_64"
url="https://hub.docker.com/"
license="LGPL"
source="glibc-bin-$pkgver-$_pkgrel-x86_64.tar.gz
nsswitch.conf
ld.so.conf"
triggers="$pkgname.trigger=/lib:/usr/lib:/usr/glibc-compat/lib"

package() {
  depends="bash libc6-compat libgcc"
  mkdir -p "$pkgdir/lib" "$pkgdir/usr/glibc-compat/lib/locale"  "$pkgdir"/usr/glibc-compat/lib64 "$pkgdir"/etc
  cp -a "$srcdir"/usr "$pkgdir"
  cp "$srcdir"/ld.so.conf "$pkgdir"/usr/glibc-compat/etc/ld.so.conf
  cp "$srcdir"/nsswitch.conf "$pkgdir"/etc/nsswitch.conf
  rm "$pkgdir"/usr/glibc-compat/etc/rpc
  rm -rf "$pkgdir"/usr/glibc-compat/bin
  rm -rf "$pkgdir"/usr/glibc-compat/sbin
  rm -rf "$pkgdir"/usr/glibc-compat/lib/gconv
  rm -rf "$pkgdir"/usr/glibc-compat/lib/getconf
  rm -rf "$pkgdir"/usr/glibc-compat/lib/audit
  rm -rf "$pkgdir"/usr/glibc-compat/lib/*crt*.o
  rm -rf "$pkgdir"/usr/glibc-compat/lib/*.a
  rm -rf "$pkgdir"/usr/glibc-compat/include
  rm -rf "$pkgdir"/usr/glibc-compat/share
  rm -rf "$pkgdir"/usr/glibc-compat/var
  ln -s /usr/glibc-compat/lib/ld-linux-x86-64.so.2 ${pkgdir}/lib/ld-linux-x86-64.so.2
  ln -s /usr/glibc-compat/lib/ld-linux-x86-64.so.2 ${pkgdir}/usr/glibc-compat/lib64/ld-linux-x86-64.so.2
  ln -s /usr/glibc-compat/etc/ld.so.cache ${pkgdir}/etc/ld.so.cache
  cp -a "$srcdir"/usr/glibc-compat/bin "$pkgdir"/usr/glibc-compat
  cp -a "$srcdir"/usr/glibc-compat/sbin "$pkgdir"/usr/glibc-compat
}

sha512sums="
2eee2ab332ed4e46f65d0d68d47d9bcef2babb5d5a65d81e553ebe3837ea17180d96bc7641ccf0431ff132878578fb3904a9bdc3e03852a5d05e1136dd7a9516  glibc-bin-$pkgver-$_pkgrel-x86_64.tar.gz
478bdd9f7da9e6453cca91ce0bd20eec031e7424e967696eb3947e3f21aa86067aaf614784b89a117279d8a939174498210eaaa2f277d3942d1ca7b4809d4b7e  nsswitch.conf
2912f254f8eceed1f384a1035ad0f42f5506c609ec08c361e2c0093506724a6114732db1c67171c8561f25893c0dd5c0c1d62e8a726712216d9b45973585c9f7  ld.so.conf"
